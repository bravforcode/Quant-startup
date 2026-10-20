# Robustness check (prototype)

A browser-only prototype that reads an MT5-style trade history (CSV) and reports:

- summary statistics (net profit, win rate, profit factor, expectancy, max drawdown)
- a simple walk-forward split: the first two thirds in time are in-sample, the last third is out-of-sample
- a Monte Carlo test: 1,000 shuffled orderings with a fixed seed, compared with the actual drawdown
- a checklist with four pass or fail checks, and a verdict

## What it is not

- It is not investment advice, and a passing result does not mean a strategy will make money.
- The thresholds (30 trades, out-of-sample at least half of in-sample, drawdown within the 95th percentile of shuffles) are demo heuristics. They are not statistically calibrated.
- The walk-forward is a single split, not a rolling re-optimisation. It does not test parameter stability.
- Quoted CSV fields containing commas are not supported.
- Data never leaves the browser. There is no server, no account and no storage.

## Files

| File | Purpose |
|---|---|
| `index.html` | The page. Loads `engine.js` and `sample_data.js` from the same folder |
| `engine.js` | Pure functions (parsing, statistics, Monte Carlo, verdict). Works in the browser and in Node |
| `sample_data.js`, `sample/synthetic_trades.csv` | Synthetic demo data made by `make_sample.js`. Not a real strategy |
| `make_sample.js` | Regenerates the synthetic sample with a fixed seed |
| `build_standalone.js` | Writes `dist/robustness-check.html`, one file with everything inlined, for sharing |
| `test/engine.test.js` | 16 unit tests for the engine (Node's built-in test runner) |

## Run

```bash
# Unit tests (from the repo root)
node --test startup-validation/mvp/robustness-check/test/engine.test.js

# Open the prototype
xdg-open startup-validation/mvp/robustness-check/index.html   # or double-click it

# One-file version for sending to someone
node startup-validation/mvp/robustness-check/build_standalone.js
```

## CSV format

```
close_time,profit
2026.10.02 10:00,5.50
2026.10.03 14:20,-3.00
```

- `profit` is required. `net profit` and `pnl` are also accepted.
- `close_time` is optional. When every row has a readable time, the rows are sorted by it. Otherwise the file order is used.
- MT5 date format (dots in the date) is accepted.
- Use the account currency for `profit`. The numbers are shown without a currency symbol.

## Known gaps before real use

- Not yet tested with a real MT5 history export. Only the synthetic sample has been run.
- Not yet tested with commissions and swaps. Use the net profit column if the export has one.
- No browser test of a losing history beyond the single case in the manual check.
