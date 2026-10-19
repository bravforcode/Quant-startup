#property strict
#property script_show_inputs

// Read-only EURUSD tick export for a connected ICMarketsSC-Demo terminal.
// No trading APIs are used. TimeGMT() depends on the workstation clock.
// API_COMPLETE_UNVERIFIED means all requested API chunks returned without
// errors; it does NOT prove that the broker supplied a complete history.

const int  LOOKBACK_DAYS       = 7;
const long HOUR_MILLISECONDS   = 3600000;
const long DAY_MILLISECONDS    = 86400000;
const int  MAX_ATTEMPTS        = 2;
const int  HISTORY_TIMEOUT     = 4403;

int audit_handle = INVALID_HANDLE;
int data_handle  = INVALID_HANDLE;
string run_id;
string audit_name;
string data_name;
long requested_from_msc = 0;
long requested_to_msc   = 0;
long total_ticks         = 0;
int expected_chunks      = 0;
int successful_chunks    = 0;
int failed_chunks        = 0;
bool audit_ok            = true;
bool data_ok             = true;

bool WriteAudit(const string record_type,
                const long from_msc,
                const long to_msc,
                const long tick_count,
                const int attempt,
                const int error_code,
                const string status,
                const int expected,
                const int succeeded,
                const int failed)
  {
   if(audit_handle == INVALID_HANDLE)
      return false;

   uint written = FileWrite(audit_handle,
                            record_type,
                            run_id,
                            from_msc,
                            to_msc,
                            tick_count,
                            attempt,
                            error_code,
                            status,
                            expected,
                            succeeded,
                            failed,
                            requested_from_msc,
                            requested_to_msc);
   if(written == 0)
     {
      PrintFormat("Audit write failed, error=%d", GetLastError());
      return false;
     }
   return true;
  }

bool WriteMetadata(const string key, const string value)
  {
   return WriteAudit("META", 0, 0, 0, 0, 0, key + "=" + value,
                     expected_chunks, 0, 0);
  }

bool RecordSymbolMetadata()
  {
   string server = AccountInfoString(ACCOUNT_SERVER);
   string account_currency = AccountInfoString(ACCOUNT_CURRENCY);
   string currency_base, currency_profit, currency_margin;
   long digits, trade_mode, calc_mode, stops_level, freeze_level, swap_mode;
   double volume_min, volume_max, volume_step, volume_limit;
   double tick_size, tick_value, tick_value_profit, tick_value_loss;
   double contract_size, swap_long, swap_short;

   if(server != "ICMarketsSC-Demo" ||
      !SymbolInfoString(_Symbol, SYMBOL_CURRENCY_BASE, currency_base) ||
      !SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT, currency_profit) ||
      !SymbolInfoString(_Symbol, SYMBOL_CURRENCY_MARGIN, currency_margin) ||
      !SymbolInfoInteger(_Symbol, SYMBOL_DIGITS, digits) ||
      !SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE, trade_mode) ||
      !SymbolInfoInteger(_Symbol, SYMBOL_TRADE_CALC_MODE, calc_mode) ||
      !SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL, stops_level) ||
      !SymbolInfoInteger(_Symbol, SYMBOL_TRADE_FREEZE_LEVEL, freeze_level) ||
      !SymbolInfoInteger(_Symbol, SYMBOL_SWAP_MODE, swap_mode) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN, volume_min) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX, volume_max) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP, volume_step) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_LIMIT, volume_limit) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE, tick_size) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE, tick_value) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE_PROFIT, tick_value_profit) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE_LOSS, tick_value_loss) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_TRADE_CONTRACT_SIZE, contract_size) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_SWAP_LONG, swap_long) ||
      !SymbolInfoDouble(_Symbol, SYMBOL_SWAP_SHORT, swap_short) ||
      volume_min <= 0.0 || volume_max < volume_min || volume_step <= 0.0 ||
      tick_size <= 0.0 || contract_size <= 0.0)
     {
      PrintFormat("REFUSED: unable to read required broker symbol metadata, error=%d",
                  GetLastError());
      return false;
     }

   if(!WriteMetadata("ACCOUNT_SERVER", server) ||
      !WriteMetadata("ACCOUNT_TRADE_MODE", "DEMO") ||
      !WriteMetadata("ACCOUNT_CURRENCY", account_currency) ||
      !WriteMetadata("SYMBOL_NAME", _Symbol) ||
      !WriteMetadata("SYMBOL_CURRENCY_BASE", currency_base) ||
      !WriteMetadata("SYMBOL_CURRENCY_PROFIT", currency_profit) ||
      !WriteMetadata("SYMBOL_CURRENCY_MARGIN", currency_margin) ||
      !WriteMetadata("SYMBOL_DIGITS", StringFormat("%I64d", digits)) ||
      !WriteMetadata("SYMBOL_TRADE_MODE", StringFormat("%I64d", trade_mode)) ||
      !WriteMetadata("SYMBOL_TRADE_CALC_MODE", StringFormat("%I64d", calc_mode)) ||
      !WriteMetadata("SYMBOL_TRADE_STOPS_LEVEL", StringFormat("%I64d", stops_level)) ||
      !WriteMetadata("SYMBOL_TRADE_FREEZE_LEVEL", StringFormat("%I64d", freeze_level)) ||
      !WriteMetadata("SYMBOL_SWAP_MODE", StringFormat("%I64d", swap_mode)) ||
      !WriteMetadata("SYMBOL_VOLUME_MIN", DoubleToString(volume_min, 16)) ||
      !WriteMetadata("SYMBOL_VOLUME_MAX", DoubleToString(volume_max, 16)) ||
      !WriteMetadata("SYMBOL_VOLUME_STEP", DoubleToString(volume_step, 16)) ||
      !WriteMetadata("SYMBOL_VOLUME_LIMIT", DoubleToString(volume_limit, 16)) ||
      !WriteMetadata("SYMBOL_TRADE_TICK_SIZE", DoubleToString(tick_size, 16)) ||
      !WriteMetadata("SYMBOL_TRADE_TICK_VALUE", DoubleToString(tick_value, 16)) ||
      !WriteMetadata("SYMBOL_TRADE_TICK_VALUE_PROFIT", DoubleToString(tick_value_profit, 16)) ||
      !WriteMetadata("SYMBOL_TRADE_TICK_VALUE_LOSS", DoubleToString(tick_value_loss, 16)) ||
      !WriteMetadata("SYMBOL_TRADE_CONTRACT_SIZE", DoubleToString(contract_size, 16)) ||
      !WriteMetadata("SYMBOL_SWAP_LONG", DoubleToString(swap_long, 16)) ||
      !WriteMetadata("SYMBOL_SWAP_SHORT", DoubleToString(swap_short, 16)))
      return false;
   return true;
  }

void CloseFiles()
  {
   if(data_handle != INVALID_HANDLE)
     {
      FileFlush(data_handle);
      FileClose(data_handle);
      data_handle = INVALID_HANDLE;
     }
   if(audit_handle != INVALID_HANDLE)
     {
      FileFlush(audit_handle);
      FileClose(audit_handle);
      audit_handle = INVALID_HANDLE;
     }
  }

bool ValidateTicks(const MqlTick &ticks[], const int count,
                   const long from_msc, const long to_msc)
  {
   if(count != ArraySize(ticks))
      return false;

   long previous_msc = from_msc;
   for(int i = 0; i < count; ++i)
     {
      long current_msc = (long)ticks[i].time_msc;
      if(current_msc < from_msc || current_msc > to_msc ||
         (i > 0 && current_msc < previous_msc))
         return false;
      previous_msc = current_msc;
     }
   return true;
  }

bool WriteTicks(const MqlTick &ticks[], const int count)
  {
   for(int i = 0; i < count; ++i)
     {
      uint written = FileWrite(data_handle,
                               (long)ticks[i].time_msc,
                               DoubleToString(ticks[i].bid, _Digits),
                               DoubleToString(ticks[i].ask, _Digits),
                               DoubleToString(ticks[i].last, _Digits),
                               (long)ticks[i].volume,
                               DoubleToString(ticks[i].volume_real, 16),
                               (long)ticks[i].flags);
      if(written == 0)
        {
         PrintFormat("Tick write failed at array index %d, error=%d",
                     i, GetLastError());
         return false;
        }
     }
   FileFlush(data_handle);
   return true;
  }

void OnStart()
  {
   if(MQLInfoInteger(MQL_TESTER))
     {
      Print("REFUSED: collector requires a connected broker terminal, not Strategy Tester.");
      return;
     }
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
     {
      Print("REFUSED: terminal is not connected.");
      return;
     }
   if((ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO)
     {
      Print("REFUSED: demo account required; no data files created.");
      return;
     }
   if(AccountInfoString(ACCOUNT_SERVER) != "ICMarketsSC-Demo")
     {
      PrintFormat("REFUSED: server must be ICMarketsSC-Demo; observed '%s'.",
                  AccountInfoString(ACCOUNT_SERVER));
      return;
     }
   if(_Symbol != "EURUSD")
     {
      PrintFormat("REFUSED: chart symbol must be EURUSD; observed '%s'.", _Symbol);
      return;
     }

   datetime utc_now_seconds = TimeGMT();
   if(utc_now_seconds <= 0)
     {
      Print("REFUSED: TimeGMT returned an invalid workstation time.");
      return;
     }

   requested_to_msc = (long)utc_now_seconds * 1000 - 1;
   requested_from_msc = requested_to_msc - LOOKBACK_DAYS * DAY_MILLISECONDS + 1;
   if(requested_from_msc <= 0 || requested_to_msc <= requested_from_msc)
     {
      Print("REFUSED: invalid seven-day range.");
      return;
     }

   run_id = StringFormat("%I64d_%I64d",
                         requested_from_msc,
                         (long)(GetMicrosecondCount() % 2147483647));
   data_name  = "GRAXIA_EURUSD_ticks_" + run_id + ".csv";
   audit_name = "GRAXIA_EURUSD_audit_" + run_id + ".csv";
   if(FileIsExist(data_name) || FileIsExist(audit_name))
     {
      PrintFormat("REFUSED: output already exists; no overwrite. run_id=%s", run_id);
      return;
     }

   expected_chunks = (int)((requested_to_msc - requested_from_msc + 1 +
                            HOUR_MILLISECONDS - 1) / HOUR_MILLISECONDS);
   ResetLastError();
   data_handle = FileOpen(data_name, FILE_WRITE | FILE_CSV, ',', CP_UTF8);
   if(data_handle == INVALID_HANDLE)
     {
      PrintFormat("Cannot open data file '%s', error=%d", data_name, GetLastError());
      return;
     }
   ResetLastError();
   audit_handle = FileOpen(audit_name, FILE_WRITE | FILE_CSV, ',', CP_UTF8);
   if(audit_handle == INVALID_HANDLE)
     {
      PrintFormat("Cannot open audit file '%s', error=%d", audit_name, GetLastError());
      CloseFiles();
      return;
     }

   if(FileWrite(data_handle, "time_msc", "bid", "ask", "last", "volume",
                "volume_real", "flags") == 0 ||
      FileWrite(audit_handle, "record_type", "run_id", "from_msc", "to_msc",
                "tick_count", "attempt", "error_code", "status",
                "expected_chunks", "successful_chunks", "failed_chunks",
                "requested_from_msc", "requested_to_msc") == 0)
     {
      PrintFormat("Cannot write CSV headers, error=%d", GetLastError());
      CloseFiles();
      return;
     }

   if(!WriteAudit("RUN", requested_from_msc, requested_to_msc, 0, 0, 0,
                  "RUNNING", expected_chunks, 0, 0))
     {
      audit_ok = false;
      CloseFiles();
      return;
     }
   if(!RecordSymbolMetadata())
     {
      Print("REFUSED: metadata capture failed; no tick request started.");
      CloseFiles();
      return;
     }

   PrintFormat("Starting read-only tick capture. run_id=%s, window=%I64d..%I64d, chunks=%d",
               run_id, requested_from_msc, requested_to_msc, expected_chunks);

   long chunk_from_msc = requested_from_msc;
   while(chunk_from_msc <= requested_to_msc && audit_ok && data_ok)
     {
      long chunk_to_msc = chunk_from_msc + HOUR_MILLISECONDS - 1;
      if(chunk_to_msc > requested_to_msc)
         chunk_to_msc = requested_to_msc;

      bool chunk_saved = false;
      for(int attempt = 1; attempt <= MAX_ATTEMPTS; ++attempt)
        {
         MqlTick ticks[];
         ArrayResize(ticks, 0);
         ResetLastError();
         int copied = CopyTicksRange("EURUSD", ticks, COPY_TICKS_ALL,
                                     (ulong)chunk_from_msc,
                                     (ulong)chunk_to_msc);
         int api_error = GetLastError();

         if(copied >= 0 && api_error == 0 &&
            ValidateTicks(ticks, copied, chunk_from_msc, chunk_to_msc))
           {
            if(!WriteTicks(ticks, copied))
              {
               data_ok = false;
               audit_ok = WriteAudit("ATTEMPT", chunk_from_msc, chunk_to_msc,
                                     copied, attempt, 0, "DATA_WRITE_FAILED",
                                     expected_chunks, successful_chunks,
                                     failed_chunks);
               break;
              }
            total_ticks += copied;
            ++successful_chunks;
            chunk_saved = true;
            audit_ok = WriteAudit("CHUNK", chunk_from_msc, chunk_to_msc,
                                  copied, attempt, 0, "API_OK",
                                  expected_chunks, successful_chunks,
                                  failed_chunks);
            break;
           }

         string failure_status = (copied >= 0 && api_error == 0)
                                 ? "INVALID_TICK_RANGE_OR_ORDER"
                                 : "API_ERROR";
         audit_ok = WriteAudit("ATTEMPT", chunk_from_msc, chunk_to_msc,
                               copied, attempt, api_error, failure_status,
                               expected_chunks, successful_chunks,
                               failed_chunks);
         if(!audit_ok)
            break;

         if(api_error == HISTORY_TIMEOUT && attempt < MAX_ATTEMPTS)
            Sleep(1000);
         else
            break;
        }

      if(!chunk_saved)
        {
         ++failed_chunks;
         audit_ok = WriteAudit("CHUNK", chunk_from_msc, chunk_to_msc,
                               0, 0, 0, "FAILED_OR_UNVERIFIED",
                               expected_chunks, successful_chunks,
                               failed_chunks);
        }

      if(!audit_ok || !data_ok)
         break;
      chunk_from_msc = chunk_to_msc + 1;
      if(successful_chunks > 0 && successful_chunks % 24 == 0)
         PrintFormat("Progress: %d/%d clean chunks; %I64d ticks; %d failed chunks",
                     successful_chunks, expected_chunks, total_ticks,
                     failed_chunks);
     }

   string final_status = (audit_ok && data_ok && failed_chunks == 0 &&
                          successful_chunks == expected_chunks)
                         ? "API_COMPLETE_UNVERIFIED"
                         : "INCOMPLETE";
   if(audit_ok)
      audit_ok = WriteAudit("FINAL", requested_from_msc, requested_to_msc,
                            total_ticks, 0, 0, final_status,
                            expected_chunks, successful_chunks, failed_chunks);
   CloseFiles();

   PrintFormat("Capture ended: status=%s, ticks=%I64d, chunks=%d/%d, failed=%d. Data=%s Audit=%s",
               final_status, total_ticks, successful_chunks, expected_chunks,
               failed_chunks, data_name, audit_name);
   Print("Coverage warning: an API-clean result does not prove broker history is exhaustive.");
   PrintFormat("Files are in the terminal's local Files folder: %s\\MQL5\\Files",
               TerminalInfoString(TERMINAL_DATA_PATH));
  }
