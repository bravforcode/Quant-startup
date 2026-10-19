//+------------------------------------------------------------------+
//| GRAXIA EA - guarded demo execution with deterministic tester path |
//| Signals come from Python in demo/live and CSV replay in tester.  |
//| This EA never uses a fixed lot as a risk substitute.              |
//+------------------------------------------------------------------+
#property copyright "GRAXIA-OS"
#property version   "2.00"
#property strict

input string SignalServiceUrl    = "http://localhost:8752";
input string SignalApiKey        = ""; // must match SIGNAL_SERVICE_API_KEY on the service
input int    BarsToSend          = 200;
input int    PollIntervalSec     = 60;
input bool   EnableTrading       = false;
const bool   VALIDATION_GATES_PASSED = false; // unlock only after reviewed evidence passes all release gates
input double RiskPerTradePct     = 1.0;
input double RiskCeilingPct      = 2.0;
input double MaxDailyLossPct     = 4.0;
input double MaxWeeklyLossPct    = 8.0;
input double HardDrawdownPct     = 25.0;
input double ThrottleDrawdownPct = 10.0;
input double PauseDrawdownPct    = 15.0;
input double MinConfidence       = 0.50;
input double MaxSpreadPoints     = 0.0; // 0 = use the adaptive 2x baseline guard
input double MaxSpreadMultiplier = 2.0;
input int    MagicNumber         = 123456;
input int    MaxSlippage         = 10;
input string ReplayFileName      = "ea_signals.csv";
input string TradeComment        = "GRAXIA EA";

datetime lastPollTime = 0;
datetime lastDecisionBar = 0;
datetime lastReplayTime = 0;
string   lastSignalId = "";
string   eaStatus = "INIT";
int      totalTrades = 0;
double   peakEquity = 0.0;
double   activeRiskPerTradePct = 0.0;
double   spreadBaselinePoints = 0.0;
bool     hardKilled = false;
int      replayHandle = INVALID_HANDLE;
bool     replayPending = false;
datetime pendingReplayTime = 0;
datetime pendingReplayValidUntil = 0;
string   pendingReplaySymbol = "";
string   pendingReplaySide = "";
double   pendingReplayEntry = 0.0;
double   pendingReplayStop = 0.0;
double   pendingReplayTp = 0.0;
string   pendingReplayId = "";

string KillKey()
{
   return StringFormat("GRAXIA_KILL_%d_%s", MagicNumber, _Symbol);
}

string PeakKey()
{
   return StringFormat("GRAXIA_PEAK_%d_%s", MagicNumber, _Symbol);
}

bool ExecutionScopeAllowed()
{
   // Strategy Tester orders are simulated and remain available for validation.
   if(MQLInfoInteger(MQL_TESTER)) return true;
   if(AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO) return false;
   if(AccountInfoString(ACCOUNT_SERVER) != "ICMarketsSC-Demo") return false;
   if(_Symbol != "EURUSD" || MagicNumber != 123456) return false;
   return true;
}

string JsonGetString(string json, string key)
{
   string search = "\"" + key + "\":";
   int pos = StringFind(json, search);
   if(pos == -1) return "";
   pos += StringLen(search);
   while(pos < StringLen(json))
   {
      ushort ch = StringGetCharacter(json, pos);
      if(ch != ' ' && ch != '\t') break;
      pos++;
   }
   if(pos < StringLen(json) && StringGetCharacter(json, pos) == '"')
   {
      pos++;
      int end = StringFind(json, "\"", pos);
      if(end == -1) return "";
      return StringSubstr(json, pos, end - pos);
   }
   int start = pos;
   while(pos < StringLen(json))
   {
      ushort ch = StringGetCharacter(json, pos);
      if(ch == ',' || ch == '}' || ch == ']' || ch == ' ') break;
      pos++;
   }
   return StringSubstr(json, start, pos - start);
}

double JsonGetDouble(string json, string key)
{
   string value = JsonGetString(json, key);
   if(value == "" || value == "null") return 0.0;
   return StringToDouble(value);
}

string HttpPost(string url, string body)
{
   string headers = "Content-Type: application/json\r\n";
   if(SignalApiKey != "") headers += "X-API-Key: " + SignalApiKey + "\r\n";
   char postData[];
   char result[];
   string resultHeaders;
   StringToCharArray(body, postData, 0, WHOLE_ARRAY, CP_UTF8);
   ArrayResize(postData, ArraySize(postData) - 1);
   int code = WebRequest("POST", url, headers, 5000, postData, result, resultHeaders);
   if(code != 200)
   {
      Print("WebRequest POST failed code=", code, " err=", GetLastError());
      return "";
   }
   return CharArrayToString(result, 0, WHOLE_ARRAY, CP_UTF8);
}

string HttpGet(string url)
{
   string headers = "Content-Type: application/json\r\n";
   if(SignalApiKey != "") headers += "X-API-Key: " + SignalApiKey + "\r\n";
   char postData[];
   char result[];
   string resultHeaders;
   int code = WebRequest("GET", url, headers, 5000, postData, result, resultHeaders);
   if(code != 200) return "";
   return CharArrayToString(result, 0, WHOLE_ARRAY, CP_UTF8);
}

string BuildBarsJson()
{
   string json = "[";
   MqlRates rates[];
   // Shift 1 excludes the still-forming bar.  The tester/live paths therefore
   // receive identical closed-bar information.
   int copied = CopyRates(_Symbol, PERIOD_M15, 1, BarsToSend, rates);
   if(copied < BarsToSend) return "[]";
   ArraySetAsSeries(rates, false);
   for(int i = 0; i < copied; i++)
   {
      if(i > 0) json += ",";
      json += StringFormat(
         "{\"time\":%I64d,\"open\":%.8f,\"high\":%.8f,\"low\":%.8f,\"close\":%.8f,\"volume\":%.0f}",
         rates[i].time, rates[i].open, rates[i].high, rates[i].low, rates[i].close, rates[i].tick_volume);
   }
   return json + "]";
}

bool HasOpenPosition()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0 && PositionGetInteger(POSITION_MAGIC) == MagicNumber)
         return true;
   }
   return false;
}

bool GetCurrentPosition(string &direction, double &openPrice, double &sl, double &tp, double &profit)
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0 && PositionGetInteger(POSITION_MAGIC) == MagicNumber &&
         PositionGetString(POSITION_SYMBOL) == _Symbol)
      {
         direction = (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) ? "long" : "short";
         openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
         sl = PositionGetDouble(POSITION_SL);
         tp = PositionGetDouble(POSITION_TP);
         profit = PositionGetDouble(POSITION_PROFIT);
         return true;
      }
   }
   return false;
}

datetime BrokerDayStart(datetime value)
{
   return StringToTime(TimeToString(value, TIME_DATE));
}

datetime BrokerWeekStart(datetime value)
{
   MqlDateTime dt;
   TimeToStruct(value, dt);
   int daysFromMonday = (dt.day_of_week == 0) ? 6 : dt.day_of_week - 1;
   return BrokerDayStart(value) - daysFromMonday * 86400;
}

double RealizedPnL(datetime from)
{
   datetime now = TimeCurrent();
   if(!HistorySelect(from, now)) return 0.0;
   double pnl = 0.0;
   int total = HistoryDealsTotal();
   for(int i = 0; i < total; i++)
   {
      ulong ticket = HistoryDealGetTicket(i);
      if(ticket == 0) continue;
      if((long)HistoryDealGetInteger(ticket, DEAL_MAGIC) != MagicNumber) continue;
      if(HistoryDealGetString(ticket, DEAL_SYMBOL) != _Symbol) continue;
      long entry = HistoryDealGetInteger(ticket, DEAL_ENTRY);
      if(entry != DEAL_ENTRY_OUT && entry != DEAL_ENTRY_OUT_BY) continue;
      pnl += HistoryDealGetDouble(ticket, DEAL_PROFIT);
      pnl += HistoryDealGetDouble(ticket, DEAL_COMMISSION);
      pnl += HistoryDealGetDouble(ticket, DEAL_SWAP);
   }
   return pnl;
}

void LoadRiskState()
{
   if(GlobalVariableCheck(KillKey()) && GlobalVariableGet(KillKey()) > 0.0)
      hardKilled = true;
   double equity = AccountInfoDouble(ACCOUNT_EQUITY);
   if(GlobalVariableCheck(PeakKey()))
      peakEquity = MathMax(equity, GlobalVariableGet(PeakKey()));
   else
      peakEquity = equity;
   GlobalVariableSet(PeakKey(), peakEquity);
}

void ActivateHardKill(string reason)
{
   if(hardKilled) return;
   hardKilled = true;
   GlobalVariableSet(KillKey(), (double)TimeCurrent());
   Print("HARD KILL ACTIVATED: ", reason);
}

bool RiskSessionAllowed()
{
   if(!EnableTrading) { eaStatus = "DISABLED"; return false; }
   if(!MQLInfoInteger(MQL_TESTER) && !VALIDATION_GATES_PASSED)
   { eaStatus = "GATES_NOT_PASSED"; return false; }
   if(!ExecutionScopeAllowed()) { eaStatus = "SCOPE_REJECTED"; return false; }
   if(hardKilled) { eaStatus = "HARD_KILLED"; return false; }
   if(RiskPerTradePct <= 0.0 || RiskPerTradePct > RiskCeilingPct || RiskCeilingPct > 2.0)
   { eaStatus = "INVALID_RISK_CONFIG"; return false; }
   if(MaxDailyLossPct <= 0.0 || MaxWeeklyLossPct <= 0.0 || HardDrawdownPct <= 0.0 ||
      ThrottleDrawdownPct < 0.0 || PauseDrawdownPct <= ThrottleDrawdownPct ||
      HardDrawdownPct <= PauseDrawdownPct)
   { eaStatus = "INVALID_RISK_CONFIG"; return false; }

   double equity = AccountInfoDouble(ACCOUNT_EQUITY);
   if(equity <= 0.0) { eaStatus = "NO_EQUITY"; return false; }
   peakEquity = MathMax(peakEquity, equity);
   GlobalVariableSet(PeakKey(), peakEquity);
   double drawdown = (peakEquity > 0.0) ? (peakEquity - equity) / peakEquity * 100.0 : 0.0;
   if(drawdown >= HardDrawdownPct)
   {
      ActivateHardKill(StringFormat("equity drawdown %.2f%% >= %.2f%%", drawdown, HardDrawdownPct));
      eaStatus = "HARD_KILLED";
      return false;
   }
   if(drawdown >= PauseDrawdownPct) { eaStatus = "DD_PAUSED"; return false; }
   activeRiskPerTradePct = RiskPerTradePct;
   if(drawdown >= ThrottleDrawdownPct)
   {
      activeRiskPerTradePct = RiskPerTradePct * 0.5;
      eaStatus = "DD_THROTTLED";
   }

   double dayLoss = RealizedPnL(BrokerDayStart(TimeCurrent()));
   double weekLoss = RealizedPnL(BrokerWeekStart(TimeCurrent()));
   if(dayLoss <= -equity * MaxDailyLossPct / 100.0) { eaStatus = "DAILY_LOSS_STOP"; return false; }
   if(weekLoss <= -equity * MaxWeeklyLossPct / 100.0) { eaStatus = "WEEKLY_LOSS_STOP"; return false; }
   return true;
}

bool SpreadAllowed(double spreadPoints)
{
   if(spreadPoints <= 0.0) return false;
   if(MaxSpreadPoints > 0.0 && spreadPoints > MaxSpreadPoints) return false;
   if(spreadBaselinePoints > 0.0 && spreadPoints > spreadBaselinePoints * MaxSpreadMultiplier) return false;
   if(spreadBaselinePoints <= 0.0) spreadBaselinePoints = spreadPoints;
   else spreadBaselinePoints = 0.95 * spreadBaselinePoints + 0.05 * spreadPoints;
   return true;
}

int VolumeDigits(double step)
{
   int digits = 0;
   while(digits < 8 && MathAbs(step - MathRound(step)) > 0.00000001)
   {
      step *= 10.0;
      digits++;
   }
   return digits;
}

bool CalculateRiskVolume(ENUM_ORDER_TYPE orderType, double entry, double stop, double &volume, string &reason)
{
   double equity = AccountInfoDouble(ACCOUNT_EQUITY);
   double riskPct = (activeRiskPerTradePct > 0.0) ? activeRiskPerTradePct : RiskPerTradePct;
   double budget = equity * riskPct / 100.0;
   double oneLotLoss = 0.0;
   if(!OrderCalcProfit(orderType, _Symbol, 1.0, entry, stop, oneLotLoss))
   { reason = "OrderCalcProfit failed"; return false; }
   oneLotLoss = MathAbs(oneLotLoss);
   if(oneLotLoss <= 0.0) { reason = "one-lot stop loss is zero"; return false; }

   double minVolume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxVolume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double step = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   if(minVolume <= 0.0 || maxVolume < minVolume || step <= 0.0)
   { reason = "invalid broker volume properties"; return false; }
   double volumeCap = maxVolume;
   if(!MQLInfoInteger(MQL_TESTER))
   {
      if(minVolume > 0.01 || maxVolume < 0.01)
      { reason = "broker volume bounds do not support authorized 0.01 lot"; return false; }
      volumeCap = MathMin(volumeCap, 0.01);
   }
   double raw = budget / oneLotLoss;
   volume = MathFloor(MathMin(raw, volumeCap) / step + 0.000000001) * step;
   volume = NormalizeDouble(MathMin(volume, maxVolume), VolumeDigits(step));
   if(volume < minVolume) { reason = StringFormat("risk volume %.8f below min %.8f", volume, minVolume); return false; }
   if(!MQLInfoInteger(MQL_TESTER) && MathAbs(volume - 0.01) > 0.00000001)
   { reason = StringFormat("risk volume %.8f cannot satisfy authorized exact 0.01 lot", volume); return false; }

   double actualLoss = 0.0;
   if(!OrderCalcProfit(orderType, _Symbol, volume, entry, stop, actualLoss))
   { reason = "post-round OrderCalcProfit failed"; return false; }
   actualLoss = MathAbs(actualLoss);
   if(actualLoss > budget + 0.00000001)
   { reason = StringFormat("rounded stop loss %.8f exceeds budget %.8f", actualLoss, budget); return false; }

   double margin = 0.0;
   if(!OrderCalcMargin(orderType, _Symbol, volume, entry, margin))
   { reason = "OrderCalcMargin failed"; return false; }
   if(margin > AccountInfoDouble(ACCOUNT_MARGIN_FREE))
   { reason = StringFormat("margin %.8f exceeds free margin", margin); return false; }
   return true;
}

bool ValidateReplayRow()
{
   if(pendingReplaySymbol != _Symbol || pendingReplaySide == "") return false;
   if(pendingReplaySide != "BUY" && pendingReplaySide != "SELL") return false;
   if(pendingReplayTime <= lastReplayTime || pendingReplayId == "") return false;
   if(pendingReplayValidUntil <= pendingReplayTime) return false;
   if(pendingReplayEntry <= 0.0 || pendingReplayStop <= 0.0) return false;
   if(pendingReplaySide == "BUY" && pendingReplayStop >= pendingReplayEntry) return false;
   if(pendingReplaySide == "SELL" && pendingReplayStop <= pendingReplayEntry) return false;
   if(pendingReplayTp > 0.0 && pendingReplaySide == "BUY" && pendingReplayTp <= pendingReplayEntry) return false;
   if(pendingReplayTp > 0.0 && pendingReplaySide == "SELL" && pendingReplayTp >= pendingReplayEntry) return false;
   return true;
}

bool ReadNextReplayRow()
{
   if(replayHandle == INVALID_HANDLE || FileIsEnding(replayHandle)) return false;
   string timeText = FileReadString(replayHandle);
   // A header is allowed once; all data rows use epoch seconds.
   if(StringLen(timeText) == 0) return false;
   if(timeText == "time")
   {
      for(int i = 0; i < 7 && !FileIsEnding(replayHandle); i++) FileReadString(replayHandle);
      return ReadNextReplayRow();
   }
   if(!StringToInteger(timeText)) { eaStatus = "REPLAY_INVALID"; return false; }
   pendingReplayTime = (datetime)StringToInteger(timeText);
   pendingReplaySymbol = FileReadString(replayHandle);
   pendingReplaySide = FileReadString(replayHandle);
   string entryText = FileReadString(replayHandle);
   string stopText = FileReadString(replayHandle);
   string tpText = FileReadString(replayHandle);
   pendingReplayEntry = StringToDouble(entryText);
   pendingReplayStop = StringToDouble(stopText);
   pendingReplayTp = StringToDouble(tpText);
   pendingReplayId = FileReadString(replayHandle);
   string validUntilText = FileReadString(replayHandle);
   pendingReplayValidUntil = (datetime)StringToInteger(validUntilText);
   if(pendingReplaySymbol == "" || pendingReplaySide == "" || entryText == "" || stopText == "" ||
      tpText == "" || pendingReplayId == "" || validUntilText == "" ||
      pendingReplayTime <= 0 || pendingReplayValidUntil <= 0)
   {
      eaStatus = "REPLAY_INVALID";
      return false;
   }
   replayPending = true;
   return true;
}

bool GetReplaySignal(string &direction, double &entry, double &stop, double &tp, string &signalId)
{
   datetime now = TimeCurrent();
   while(true)
   {
      if(!replayPending && !ReadNextReplayRow()) return false;
      if(pendingReplayTime > now) return false;
      replayPending = false;
      if(!ValidateReplayRow()) { eaStatus = "REPLAY_INVALID"; return false; }
      if(pendingReplayValidUntil <= now) continue;
      lastReplayTime = pendingReplayTime;
      direction = (pendingReplaySide == "BUY") ? "long" : "short";
      entry = pendingReplayEntry;
      stop = pendingReplayStop;
      tp = pendingReplayTp;
      signalId = pendingReplayId;
      return true;
   }
   return false;
}

ENUM_ORDER_TYPE_FILLING BrokerFillingMode()
{
   long flags = SymbolInfoInteger(_Symbol, SYMBOL_FILLING_MODE);
   if((flags & SYMBOL_FILLING_FOK) == SYMBOL_FILLING_FOK) return ORDER_FILLING_FOK;
   if((flags & SYMBOL_FILLING_IOC) == SYMBOL_FILLING_IOC) return ORDER_FILLING_IOC;
   return ORDER_FILLING_RETURN;
}

bool PlaceOrder(string direction, double entry, double stop, double tp, string signalId)
{
   if(!MQLInfoInteger(MQL_TESTER) && !VALIDATION_GATES_PASSED)
   { eaStatus = "GATES_NOT_PASSED"; Print("ORDER REJECTED: validation release gates remain locked"); return false; }
   if(!ExecutionScopeAllowed())
   { eaStatus = "SCOPE_REJECTED"; Print("ORDER REJECTED: outside authorized demo scope"); return false; }
   ENUM_ORDER_TYPE orderType;
   if(direction == "long") orderType = ORDER_TYPE_BUY;
   else if(direction == "short") orderType = ORDER_TYPE_SELL;
   else return false;
   if(entry <= 0.0 || stop <= 0.0) return false;
   if(direction == "long" && stop >= entry) return false;
   if(direction == "short" && stop <= entry) return false;
   if(tp > 0.0 && direction == "long" && tp <= entry) return false;
   if(tp > 0.0 && direction == "short" && tp >= entry) return false;

   double volume = 0.0;
   string reason = "";
   if(!CalculateRiskVolume(orderType, entry, stop, volume, reason))
   { Print("RISK REJECT: ", reason); eaStatus = "RISK_REJECT"; return false; }

   MqlTradeRequest request = {};
   MqlTradeCheckResult check = {};
   MqlTradeResult result = {};
   request.action = TRADE_ACTION_DEAL;
   request.symbol = _Symbol;
   request.type = orderType;
   request.volume = volume;
   request.price = NormalizeDouble(entry, _Digits);
   request.sl = NormalizeDouble(stop, _Digits);
   request.tp = (tp > 0.0) ? NormalizeDouble(tp, _Digits) : 0.0;
   request.deviation = MaxSlippage;
   request.magic = MagicNumber;
   request.comment = StringFormat("%s %s id=%s", TradeComment, direction, signalId);
   request.type_filling = BrokerFillingMode();

   if(!OrderCheck(request, check))
   { Print("ORDER CHECK FAILED: ", GetLastError()); return false; }
   if(check.retcode != 0 && check.retcode != TRADE_RETCODE_DONE && check.retcode != TRADE_RETCODE_PLACED)
   { Print("ORDER CHECK REJECTED: ", check.retcode, " ", check.comment); return false; }
   if(!OrderSend(request, result))
   { Print("ORDER SEND FAILED: ", result.retcode, " ", result.comment); return false; }
   totalTrades++;
   lastSignalId = signalId;
   Print("ORDER PLACED: ", direction, " volume=", DoubleToString(volume, 8), " entry=", request.price,
         " SL=", request.sl, " TP=", request.tp, " id=", signalId);
   return true;
}

bool RequestSignal(string &direction, double &entry, double &stop, double &tp, double &confidence, string &signalId)
{
   datetime closedBar = iTime(_Symbol, PERIOD_M15, 1);
   if(closedBar <= 0 || closedBar == lastDecisionBar) return false;

   if(MQLInfoInteger(MQL_TESTER))
   {
      if(replayHandle == INVALID_HANDLE)
      { eaStatus = "TESTER_REPLAY_REQUIRED"; return false; }
      if(!GetReplaySignal(direction, entry, stop, tp, signalId)) return false;
      confidence = 1.0;
      lastDecisionBar = closedBar;
      return true;
   }

   if(SignalApiKey == "") { eaStatus = "SERVICE_KEY_REQUIRED"; return false; }
   string bars = BuildBarsJson();
   if(bars == "[]") { eaStatus = "NO_BARS"; return false; }
   MqlTick tick;
   if(!SymbolInfoTick(_Symbol, tick)) return false;
   string body = StringFormat("{\"bars\":%s,\"bid\":%.8f,\"ask\":%.8f,\"server_time\":%I64d,\"symbol\":\"%s\"}",
                              bars, tick.bid, tick.ask, TimeCurrent(), _Symbol);
   string response = HttpPost(SignalServiceUrl + "/api/signal", body);
   if(response == "") { eaStatus = "NO_RESPONSE"; return false; }
   direction = JsonGetString(response, "direction");
   confidence = JsonGetDouble(response, "confidence");
   double distance = JsonGetDouble(response, "sl_distance");
   double tpDistance = JsonGetDouble(response, "tp_distance");
   signalId = JsonGetString(response, "signal_id");
   if(signalId == "") signalId = StringFormat("%s-%I64d", direction, closedBar);
   if(direction == "flat" || direction == "") { lastDecisionBar = closedBar; return false; }
   if(confidence < MinConfidence || distance <= 0.0) { lastDecisionBar = closedBar; return false; }
   entry = (direction == "long") ? tick.ask : tick.bid;
   stop = (direction == "long") ? entry - distance : entry + distance;
   tp = (tpDistance > 0.0) ? ((direction == "long") ? entry + tpDistance : entry - tpDistance) : 0.0;
   lastDecisionBar = closedBar;
   return true;
}

int OnInit()
{
   if(!ExecutionScopeAllowed())
   {
      eaStatus = "SCOPE_REJECTED";
      Print("INIT REJECTED: execution is restricted to ICMarketsSC-Demo / EURUSD / magic 123456.");
      return INIT_FAILED;
   }
   if(!MQLInfoInteger(MQL_TESTER) && !VALIDATION_GATES_PASSED)
   {
      eaStatus = "GATES_NOT_PASSED";
      Print("INIT LOCKED: release gates have not passed; trading remains unavailable.");
      return INIT_SUCCEEDED;
   }
   if(!SymbolSelect(_Symbol, true)) return INIT_FAILED;
   LoadRiskState();
   if(MQLInfoInteger(MQL_TESTER))
   {
      replayHandle = FileOpen(ReplayFileName, FILE_READ | FILE_CSV | FILE_ANSI, ',');
      if(replayHandle == INVALID_HANDLE) eaStatus = "TESTER_REPLAY_REQUIRED";
   }
   else
   {
      if(SignalApiKey == "")
         eaStatus = "SERVICE_KEY_REQUIRED";
      else
      {
         string health = HttpGet(SignalServiceUrl + "/api/health");
         eaStatus = (health == "") ? "NO_SERVICE" : "ONLINE";
      }
   }
   EventSetTimer(MathMax(1, PollIntervalSec));
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   EventKillTimer();
   if(replayHandle != INVALID_HANDLE) FileClose(replayHandle);
}

void OnTimer()
{
   if(!RiskSessionAllowed()) return;
   if(HasOpenPosition()) { eaStatus = "HOLDING"; return; }

   MqlTick tick;
   if(!SymbolInfoTick(_Symbol, tick)) { eaStatus = "NO_TICK"; return; }
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   if(point <= 0.0) { eaStatus = "NO_POINT"; return; }
   double spreadPoints = (tick.ask - tick.bid) / point;
   if(!SpreadAllowed(spreadPoints)) { eaStatus = "SPREAD_REJECT"; return; }

   string direction, signalId;
   double entry, stop, tp, confidence;
   if(!RequestSignal(direction, entry, stop, tp, confidence, signalId)) return;
   if(signalId == lastSignalId) { eaStatus = "DUPLICATE_SIGNAL"; return; }
   if(direction == "long" && stop >= entry) { eaStatus = "INVALID_SL"; return; }
   if(direction == "short" && stop <= entry) { eaStatus = "INVALID_SL"; return; }
   if(PlaceOrder(direction, entry, stop, tp, signalId)) eaStatus = "ORDER_PLACED";
}

void OnTick()
{
   string direction;
   double openPrice, sl, tp, profit;
   string position = "";
   if(GetCurrentPosition(direction, openPrice, sl, tp, profit))
      position = StringFormat("\nPosition: %s @ %.5f SL=%.5f TP=%.5f PnL=%.2f", direction, openPrice, sl, tp, profit);
   Comment("=== GRAXIA EA ===\n", "Status: ", eaStatus, "\n", "Trades: ", totalTrades,
           "\nServer time: ", TimeToString(TimeCurrent(), TIME_DATE | TIME_SECONDS), position);
}
//+------------------------------------------------------------------+
