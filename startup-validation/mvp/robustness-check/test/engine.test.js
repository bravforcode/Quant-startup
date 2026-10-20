// Run from the repo root:  node --test startup-validation/mvp/robustness-check/test/
const test = require("node:test");
const assert = require("node:assert/strict");
const path = require("node:path");

const R = require(path.join(__dirname, "..", "engine.js"));

const steady = (n, profit) => Array.from({ length: n }, () => ({ profit, time: NaN }));

test("max drawdown follows the peak-to-trough fall", () => {
  assert.equal(R.maxDrawdown([10, -5, 10, -20]), 20);
  assert.equal(R.maxDrawdown([5, 5, 5]), 0);
  assert.equal(R.maxDrawdown([-3, -4]), 7);
});

test("summary gives net, win rate, profit factor and expectancy", () => {
  const s = R.summarize(steady(0, 0).concat([10, -5, 10, -20].map((p) => ({ profit: p, time: NaN }))));
  assert.equal(s.n, 4);
  assert.equal(s.net, -5);
  assert.equal(s.winRate, 0.5);
  assert.equal(s.profitFactor, 0.8);
  assert.equal(s.expectancy, -1.25);
  assert.equal(s.maxDrawdown, 20);
});

test("profit factor is infinite only when there are wins and no losses", () => {
  assert.equal(R.summarize(steady(3, 4)).profitFactor, Infinity);
  assert.equal(R.summarize(steady(3, 0)).profitFactor, 0);
});

test("MT5 dates are parsed and rows are sorted by close time", () => {
  const csv = [
    "close_time,profit",
    "2026.10.02 10:00,5",
    "2026.10.01 09:00,-3",
    "2026.10.03 11:30,8",
  ].join("\n");
  const trades = R.parseTrades(csv);
  assert.deepEqual(trades.map((t) => t.profit), [-3, 5, 8]);
});

test("rows keep file order when a time cannot be read", () => {
  const csv = ["close_time,profit", "not a date,5", "2026.10.01 09:00,-3"].join("\n");
  assert.deepEqual(R.parseTrades(csv).map((t) => t.profit), [5, -3]);
});

test("missing profit column is rejected with a clear message", () => {
  assert.throws(() => R.parseTrades("time,amount\n2026.10.01,5"), /ไม่พบคอลัมน์ profit/);
});

test("a non-numeric profit names the row", () => {
  assert.throws(() => R.parseTrades("profit\n5\nabc"), /แถวที่ 3: profit ไม่ใช่ตัวเลข/);
});

test("a header with no data rows is rejected", () => {
  assert.throws(() => R.parseTrades("profit"), /อย่างน้อย 1 แถว/);
});

test("walk-forward keeps the first two thirds in-sample", () => {
  const wf = R.walkForward(steady(9, 1));
  assert.equal(wf.cut, 6);
  assert.equal(wf.inSample.n, 6);
  assert.equal(wf.outOfSample.n, 3);
});

test("Monte Carlo is reproducible for the same seed", () => {
  const profits = [4, -2, 7, -5, 3, -1, 6, -4, 2, -3];
  const a = R.monteCarlo(profits, 200, 42);
  const b = R.monteCarlo(profits, 200, 42);
  assert.deepEqual(a, b);
  assert.ok(a.median <= a.p95);
});

test("all-loss sequences have the same drawdown in every ordering", () => {
  const mc = R.monteCarlo([-1, -2, -3, -4], 100, 7);
  assert.equal(mc.actual, 10);
  assert.equal(mc.median, 10);
  assert.equal(mc.p95, 10);
});

test("equity curve starts at zero and accumulates profit", () => {
  assert.deepEqual(R.equityCurve([{ profit: 2 }, { profit: -1 }, { profit: 4 }]), [0, 2, 1, 5]);
});

test("fewer than the minimum trades gives 'not enough data'", () => {
  const result = R.assess(steady(10, 5));
  assert.equal(result.verdict, "ข้อมูลไม่พอ");
  assert.equal(result.checks.find((c) => c.id === "enough").pass, false);
});

test("steady profits pass every check", () => {
  const trades = Array.from({ length: 120 }, (_, i) => ({ profit: 10 + ((i % 5) - 2), time: NaN }));
  const result = R.assess(trades);
  assert.equal(result.verdict, "ผ่านเกณฑ์เบื้องต้นของ prototype");
  assert.ok(result.checks.every((c) => c.pass));
});

test("a losing out-of-sample period is reported as not passing", () => {
  const trades = steady(80, 10).concat(steady(40, -10));
  const result = R.assess(trades);
  assert.equal(result.verdict, "ไม่ผ่าน");
  assert.equal(result.checks.find((c) => c.id === "oos_positive").pass, false);
});

test("out-of-sample that is positive but far below in-sample needs more checks", () => {
  const trades = steady(80, 10).concat(steady(40, 3));
  const result = R.assess(trades);
  assert.equal(result.verdict, "ควรตรวจเพิ่ม");
  assert.equal(result.checks.find((c) => c.id === "oos_ratio").pass, false);
});
