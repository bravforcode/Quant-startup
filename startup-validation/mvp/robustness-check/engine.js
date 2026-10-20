/* Robustness check prototype: pure functions with no I/O.
 * Runs in the browser (window.Robustness) and in Node (module.exports).
 * Thresholds are demo heuristics, not statistically calibrated limits. */
(function (root, factory) {
  const api = factory();
  if (typeof module === "object" && module.exports) {
    module.exports = api;
  } else {
    root.Robustness = api;
  }
})(typeof self !== "undefined" ? self : this, function () {
  "use strict";

  const CONFIG = {
    minTrades: 30,        // below this the verdict is "not enough data"
    oosShare: 1 / 3,      // the last third of the history is out-of-sample
    oosRatioMin: 0.5,     // out-of-sample expectancy must reach half of in-sample
    mcRuns: 1000,         // number of shuffled orderings
    mcPercentile: 0.95,   // the actual drawdown should not be worse than this share of shuffles
    seed: 20261020,       // fixed seed so the same file always gives the same numbers
  };

  function mulberry32(seed) {
    let a = seed >>> 0;
    return function next() {
      a = (a + 0x6d2b79f5) >>> 0;
      let t = a;
      t = Math.imul(t ^ (t >>> 15), t | 1);
      t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
      return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
  }

  function sum(xs) {
    return xs.reduce((s, x) => s + x, 0);
  }

  function round2(x) {
    return Math.round(x * 100) / 100;
  }

  // MT5 exports dates with dots, for example 2026.10.02 10:00. Convert them before parsing.
  function parseTime(text) {
    if (!text) return NaN;
    return Date.parse(text.trim().replace(/^(\d{4})\.(\d{2})\.(\d{2})/, "$1-$2-$3"));
  }

  // Plain comma split. Quoted fields containing commas are not supported.
  function parseCsvLine(line) {
    return line.split(",").map((c) => c.trim());
  }

  // Returns [{ profit, time }]. Sorted by time when every row has a valid time, otherwise file order.
  function parseTrades(text) {
    const lines = String(text).split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
    if (lines.length < 2) {
      throw new Error("ต้องมีบรรทัดหัวคอลัมน์และอย่างน้อย 1 แถวข้อมูล");
    }
    const header = parseCsvLine(lines[0]).map((h) => h.toLowerCase());
    const profitIdx = header.findIndex((h) => ["profit", "net profit", "pnl"].includes(h));
    if (profitIdx < 0) {
      throw new Error("ไม่พบคอลัมน์ profit (ใช้ได้: profit, net profit, pnl)");
    }
    const timeIdx = header.findIndex((h) => ["close_time", "close time", "time", "close"].includes(h));
    const trades = lines.slice(1).map((line, i) => {
      const cells = parseCsvLine(line);
      const profit = Number(cells[profitIdx]);
      if (!Number.isFinite(profit)) {
        throw new Error(`แถวที่ ${i + 2}: profit ไม่ใช่ตัวเลข`);
      }
      const time = timeIdx >= 0 ? parseTime(cells[timeIdx]) : NaN;
      return { profit, time };
    });
    if (trades.every((t) => Number.isFinite(t.time))) {
      trades.sort((a, b) => a.time - b.time);
    }
    return trades;
  }

  // Largest peak-to-trough fall of the cumulative profit, starting from zero equity.
  function maxDrawdown(profits) {
    let equity = 0;
    let peak = 0;
    let worst = 0;
    for (const p of profits) {
      equity += p;
      if (equity > peak) peak = equity;
      if (peak - equity > worst) worst = peak - equity;
    }
    return worst;
  }

  function summarize(trades) {
    const profits = trades.map((t) => t.profit);
    const n = profits.length;
    const net = sum(profits);
    const wins = profits.filter((p) => p > 0);
    const grossWin = sum(wins);
    const grossLoss = -sum(profits.filter((p) => p < 0));
    return {
      n,
      net: round2(net),
      winRate: n ? wins.length / n : 0,
      profitFactor: grossLoss > 0 ? round2(grossWin / grossLoss) : (grossWin > 0 ? Infinity : 0),
      expectancy: n ? net / n : 0,
      maxDrawdown: round2(maxDrawdown(profits)),
    };
  }

  // Simple split in time order: the first part is in-sample, the last part is out-of-sample.
  function walkForward(trades, oosShare = CONFIG.oosShare) {
    const cut = Math.floor(trades.length * (1 - oosShare));
    return {
      cut,
      inSample: summarize(trades.slice(0, cut)),
      outOfSample: summarize(trades.slice(cut)),
    };
  }

  // Shuffles the trade order and records the drawdown of each ordering.
  function monteCarlo(profits, runs = CONFIG.mcRuns, seed = CONFIG.seed) {
    const rand = mulberry32(seed);
    const work = profits.slice();
    const drawdowns = new Array(runs);
    for (let r = 0; r < runs; r++) {
      for (let i = work.length - 1; i > 0; i--) {
        const j = Math.floor(rand() * (i + 1));
        [work[i], work[j]] = [work[j], work[i]];
      }
      drawdowns[r] = maxDrawdown(work);
    }
    drawdowns.sort((a, b) => a - b);
    const at = (q) => drawdowns[Math.min(drawdowns.length - 1, Math.floor(q * drawdowns.length))];
    return {
      runs,
      actual: round2(maxDrawdown(profits)),
      median: round2(at(0.5)),
      p95: round2(at(CONFIG.mcPercentile)),
    };
  }

  function equityCurve(trades) {
    const curve = [0];
    let equity = 0;
    for (const t of trades) {
      equity += t.profit;
      curve.push(round2(equity));
    }
    return curve;
  }

  function assess(trades, options = {}) {
    const cfg = Object.assign({}, CONFIG, options);
    const n = trades.length;
    const full = summarize(trades);
    const wf = walkForward(trades, cfg.oosShare);
    const mc = monteCarlo(trades.map((t) => t.profit), cfg.mcRuns, cfg.seed);
    const isExp = wf.inSample.expectancy;
    const oosExp = wf.outOfSample.expectancy;

    const checks = [
      {
        id: "enough",
        label: `มีอย่างน้อย ${cfg.minTrades} รายการ (มี ${n})`,
        pass: n >= cfg.minTrades,
      },
      {
        id: "oos_positive",
        label: "กำไรเฉลี่ยต่อรายการในช่วง out-of-sample เป็นบวก",
        pass: wf.outOfSample.n > 0 && oosExp > 0,
      },
      {
        id: "oos_ratio",
        label: `กำไรเฉลี่ย out-of-sample อย่างน้อย ${Math.round(cfg.oosRatioMin * 100)}% ของ in-sample`,
        pass: isExp > 0 && oosExp / isExp >= cfg.oosRatioMin,
      },
      {
        id: "drawdown",
        label: "Max drawdown จริงไม่แย่กว่า 95% ของการสับลำดับ",
        pass: mc.actual <= mc.p95,
      },
    ];

    let verdict;
    if (n < cfg.minTrades) {
      verdict = "ข้อมูลไม่พอ";
    } else if (checks.every((c) => c.pass)) {
      verdict = "ผ่านเกณฑ์เบื้องต้นของ prototype";
    } else if (!checks.find((c) => c.id === "oos_positive").pass) {
      verdict = "ไม่ผ่าน";
    } else {
      verdict = "ควรตรวจเพิ่ม";
    }

    return { verdict, n, full, walkForward: wf, monteCarlo: mc, checks, config: cfg };
  }

  return {
    CONFIG,
    mulberry32,
    parseTrades,
    summarize,
    maxDrawdown,
    walkForward,
    monteCarlo,
    equityCurve,
    assess,
  };
});
