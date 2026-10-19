# GRAXIA broker-evidence handoff

Date: 2026-09-23

## Verified in this workspace

- Added a read-only seven-day EURUSD tick collector. It refuses Strategy Tester,
  disconnected terminals, non-demo accounts, servers other than
  `ICMarketsSC-Demo`, and symbols other than `EURUSD`.
- The collector writes hourly `COPY_TICKS_ALL` chunks, retry/error records,
  broker symbol volume/tick/contract/swap metadata, and a final audit row.
  It has no trade API references.
- The PowerShell packer accepts only a successful API run with matching run IDs,
  exact seven-day chunk coverage/counts, required broker metadata, and matching
  CSV row counts. It writes gzip files plus a SHA-256 manifest and preserves the
  raw source files.
- The packer labels the result `COMPRESSED_API_EVIDENCE_UNVERIFIED`: clean API
  returns do not prove that the broker supplied an exhaustive history.
- The packer tests pass for a complete synthetic fixture and reject both an
  incomplete fixture and wrong-server metadata. This validates tooling only,
  not market data.
- MetaEditor compile log reports `0 errors, 0 warnings`. The launcher returned
  exit code 1; the compile log, not that launcher code, is the compile evidence.
- The EA remains `EnableTrading=false` and
  `VALIDATION_GATES_PASSED=false`. No orders were sent by this task.

`TimeGMT()` uses the workstation clock/time-zone configuration, so clock
accuracy must be checked before treating the requested window as an exact UTC
window. MQL5 documents the millisecond range semantics and possible history
timeout on [`CopyTicksRange`](https://www.mql5.com/en/docs/series/copyticksrange)
and the workstation-clock dependency on [`TimeGMT`](https://www.mql5.com/en/docs/dateandtime/timegmt).

## Still blocked / not verified

- The only detected terminal process was Pepperstone MT5; no
  `ICMarketsSC-Demo` terminal/account was available to this task.
- No broker ticks, symbol properties, quotes, fills, commissions, or swaps were
  collected. Account orders/positions were not queried.
- Minimum-lot feasibility, the required 30 observed round trips, WFO, cost
  stress, bootstrap, DSR, PBO, FDR, locked holdout, and shadow/demo gates have
  not been evidenced here. No strategy edge or “best” strategy is claimed.
- This workspace contains no strategy service/model or runnable validation
  pipeline, so production XGBoost/M15 parity cannot be backtested from these
  files alone.

Release state remains `NO_GO`; keep the EA disabled. The guarded EA permits
non-tester execution only after an explicit source-level validation unlock;
do not change it on the strength of a successful collector run.

## Run only on the authorized demo terminal

1. Open the IC Markets demo terminal and independently verify account type is
   Demo, server is exactly `ICMarketsSC-Demo`, and the chart symbol is exactly
   `EURUSD`. Do not use the currently detected Pepperstone terminal.
2. Copy `artifacts/GRAXIA_TickCollector.ex5` into that terminal's
   `MQL5\Scripts` folder, refresh Navigator, open an EURUSD chart, and run the
   script. It does not require enabling EA auto-trading and contains no order
   functions.
3. Find the two `GRAXIA_EURUSD_*_<run_id>.csv` files under that terminal's local
   `MQL5\Files` folder. Require the terminal log's final status to be
   `API_COMPLETE_UNVERIFIED`; any incomplete/missing final row is a failed
   collection. Preserve both raw files.
4. Run the packer with those exact paths and a new destination folder:

   ```powershell
   powershell -NoProfile -File C:\quant-bot\scripts\compress_ticks.ps1 `
     -DataCsv  "<terminal-data-folder>\MQL5\Files\GRAXIA_EURUSD_ticks_<run_id>.csv" `
     -AuditCsv "<terminal-data-folder>\MQL5\Files\GRAXIA_EURUSD_audit_<run_id>.csv" `
     -OutputDirectory C:\quant-bot\artifacts\campaign_<new_id>
   ```

5. Inspect the generated manifest and reconcile symbol metadata, row counts,
   hashes, and coverage before using the data. Treat metadata as the demo
   server's observed contract settings, not proof of live-account equivalence.
6. Do not start the 30-round-trip demo campaign from this collector. It is a
   separate execution activity, even though the collector itself is read-only.
   Record every authorized EURUSD 0.01 / MagicNumber 123456 open-close pair and
   reconcile the account after the campaign.
7. Pre-register a fresh strategy experiment, keep its locked holdout untouched,
   then run the existing statistical gates and shadow process. A clean tick
   export alone does not pass any strategy gate.

## Files and artifact identity

- Collector source: `mql5check/GRAXIA_TickCollector.mq5`
- Collector binary: `artifacts/GRAXIA_TickCollector.ex5`
- Compile log: `artifacts/GRAXIA_TickCollector.compile.log`
- Compression tool/test: `scripts/compress_ticks.ps1`,
  `tests/test_compress_ticks.ps1`
- Collector binary SHA-256:
  `74528DE1AFA1139FA90317C4222CFEAE6A5F0FE9F7B2A3D53179A76E33DFCBB3`
