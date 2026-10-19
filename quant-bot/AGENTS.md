# AGENTS.md — quant-bot

Python trading-bot workspace at `C:\quant-bot` (tick data, MQL5 checks, scripts, tests, artifacts).

## Stack

- Python (machine default 3.12) + pytest + ruff (`.pytest_cache/`, `.ruff_cache/` present at root).
- MQL5 tooling under `mql5check/`; tick-data scripts under `scripts/`; outputs under `artifacts/`.

## Layout

- `scripts/` — data/tool scripts. `tests/` — tests (`test_compress_ticks.ps1`, `windmill/`).
- `artifacts/` — generated outputs. Do not hand-edit; regenerate via scripts.
- `mql5check/` — MQL5-related checks.

## Commands

```powershell
cd C:\quant-bot
python -m pytest tests/ -q        # full suite
ruff check .                       # lint
```

## Rules

- MUST NOT commit credentials, API keys, or broker account data. No live-trading changes without explicit approval.
- MUST run pytest before finishing any change to `scripts/` or strategy logic.
- MUST NOT edit `artifacts/` by hand — fix the generating script instead.
- Backtests/strategy changes: keep risk rules in `C:\Global\Knowledge\Trading\Memories\Risk rules memory.md` consistent (15% DD, 2% daily, 5% weekly, max 5 positions, XAUUSD min SL $28).
- Paper trading by default. Live execution requires explicit user approval every time.
