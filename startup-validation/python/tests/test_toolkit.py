#!/usr/bin/env python3
"""Tests for the startup-validation kpi / funnel / cost scripts.

Standard library only. Runs from any working directory:
    python3 -m unittest discover -s <repo>/startup-validation/python/tests -v
"""
import importlib.util
import os
import subprocess
import sys
import tempfile
import unittest

sys.dont_write_bytecode = True  # keep __pycache__ out of the repo

PY_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SAMPLE_INTERVIEWS = os.path.join(PY_DIR, "sample", "interviews.csv")
SAMPLE_OFFERS = os.path.join(PY_DIR, "sample", "offers.csv")
HEADER = ("id,qualified,freq_weekly_plus,paying_for_workaround,"
          "pain_score,is_stranger,source_community,advanced_commitment")
OFFER_HEADER = "id,price_thb,paid,is_stranger,reason"

# Expected output of `python3 kpi.py interviews.csv offers.csv 180 7`.
# The sample fails two gates that preregistration.md sets for GO: 12 offers (<15) and fbB at 33% (>30%).
EXPECTED_SAMPLE_KPI = [
    "qualified interviews n=15 (need >=10; target 15)",
    "K1 weekly+: 10/15 = 67%  CI 42%-85%  threshold>=8 -> PASS",
    "K2 paying : 7/15 = 47%  CI 25%-70%  threshold>=5 -> PASS",
    "K5 pain mean 6.5/10 (opinion-grade; corroborating only)",
    "strangers 13/15 = 87% (target >=50%)",
    "largest community 'fbB' = 33% (cap 30%)",
    "buyers not checked: add an is_buyer column (1/0) to interviews.csv",
    "K3 offers 12, paid 2 (strangers 2)",
    "K4 landing 7/180 = 3.9%  CI 1.9-7.8%",
    "GO blocked by: K3 needs >=15 offers (have 12); largest community 'fbB' 33% > 30%",
    "TIER: PIVOT or extend per PART 7.4 / K6",
]


def load_kpi():
    spec = importlib.util.spec_from_file_location("kpi", os.path.join(PY_DIR, "kpi.py"))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


kpi = load_kpi()


def run_script(name, *args, cwd):
    """Run one of the CLI scripts in a subprocess and return the CompletedProcess."""
    return subprocess.run(
        [sys.executable, "-B", os.path.join(PY_DIR, name), *args],
        cwd=cwd, capture_output=True, text=True, encoding="utf-8", timeout=60,
    )


class WilsonTests(unittest.TestCase):
    def test_ten_of_fifteen(self):
        lo, hi = kpi.wilson(10, 15)
        self.assertEqual(round(lo, 2), 0.42)
        self.assertEqual(round(hi, 2), 0.85)
        self.assertAlmostEqual(lo, 0.4171, places=3)
        self.assertAlmostEqual(hi, 0.8482, places=3)

    def test_zero_successes(self):
        lo, hi = kpi.wilson(0, 10)
        self.assertEqual(lo, 0.0)
        self.assertAlmostEqual(hi, 0.2775, places=3)

    def test_all_successes(self):
        lo, hi = kpi.wilson(10, 10)
        self.assertAlmostEqual(lo, 0.7225, places=3)
        self.assertEqual(hi, 1.0)

    def test_zero_trials(self):
        self.assertEqual(kpi.wilson(0, 0), (0.0, 0.0))

    def test_bounds_stay_in_unit_interval(self):
        for n in range(1, 40):
            for k in range(n + 1):
                lo, hi = kpi.wilson(k, n)
                self.assertTrue(0.0 <= lo <= hi <= 1.0, (k, n, lo, hi))


class SampleDataTests(unittest.TestCase):
    def test_row_counts(self):
        self.assertEqual(len(kpi.read(SAMPLE_INTERVIEWS)[1]), 16)
        self.assertEqual(len(kpi.read(SAMPLE_OFFERS)[1]), 12)


class FunnelTests(unittest.TestCase):
    def test_three_customers_needs_391_dms(self):
        with tempfile.TemporaryDirectory() as tmp:
            proc = run_script("funnel.py", "3", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertIn("DMs needed = 391", proc.stdout)


class CostTests(unittest.TestCase):
    def test_example_is_084_thb_per_user_month(self):
        with tempfile.TemporaryDirectory() as tmp:
            proc = run_script("cost.py", "20", "800", "150", "1", "4", "990", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertIn("per user/month 0.84 THB", proc.stdout)
        self.assertIn("share of price 0.08%", proc.stdout)
        self.assertIn("gross margin (LLM only) 99.92%", proc.stdout)

    def test_without_price_has_no_margin_line(self):
        with tempfile.TemporaryDirectory() as tmp:
            proc = run_script("cost.py", "20", "800", "150", "1", "4", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertIn("per user/month 0.84 THB", proc.stdout)
        self.assertNotIn("share of price", proc.stdout)


class KpiSampleTests(unittest.TestCase):
    def test_sample_run_matches_doc_output(self):
        with tempfile.TemporaryDirectory() as tmp:
            proc = run_script("kpi.py", SAMPLE_INTERVIEWS, SAMPLE_OFFERS, "180", "7", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertEqual(proc.stdout.splitlines(), EXPECTED_SAMPLE_KPI)

    def test_k4_line_omitted_without_visitor_args(self):
        with tempfile.TemporaryDirectory() as tmp:
            proc = run_script("kpi.py", SAMPLE_INTERVIEWS, SAMPLE_OFFERS, cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertNotIn("K4 landing", proc.stdout)


class KpiEdgeCaseTests(unittest.TestCase):
    def write_interviews(self, tmp, rows):
        path = os.path.join(tmp, "interviews.csv")
        with open(path, "w", encoding="utf-8", newline="") as f:
            f.write(HEADER + "\n")
            for row in rows:
                f.write(row + "\n")
        return path

    def test_no_qualified_rows_does_not_crash(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self.write_interviews(tmp, ["1,0,0,0,,1,fbA,0", "2,0,1,1,8,1,line,2"])
            proc = run_script("kpi.py", path, SAMPLE_OFFERS, "180", "7", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertNotIn("Traceback", proc.stderr)
        self.assertIn("n=0: no qualified interviews yet", proc.stdout)
        self.assertIn("TIER: INSUFFICIENT DATA", proc.stdout)
        self.assertNotIn("GO-", proc.stdout)

    def test_header_only_interviews_does_not_crash(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = self.write_interviews(tmp, [])
            proc = run_script("kpi.py", path, SAMPLE_OFFERS, "180", "7", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertNotIn("Traceback", proc.stderr)
        self.assertIn("n=0: no qualified interviews yet", proc.stdout)
        self.assertIn("K4 landing 7/180", proc.stdout)

    def test_zero_visitors_does_not_crash(self):
        with tempfile.TemporaryDirectory() as tmp:
            proc = run_script("kpi.py", SAMPLE_INTERVIEWS, SAMPLE_OFFERS, "0", "0", cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertNotIn("Traceback", proc.stderr)
        self.assertIn("K4 landing 0/0 = n/a", proc.stdout)
        self.assertIn("TIER: PIVOT or extend", proc.stdout)


class TierTests(unittest.TestCase):
    """Stage 4 tier rules from preregistration.md: K1-K3 plus the extra GO criteria."""

    def run_case(self, interviews, offers, header=HEADER):
        with tempfile.TemporaryDirectory() as tmp:
            ip = os.path.join(tmp, "interviews.csv")
            op = os.path.join(tmp, "offers.csv")
            with open(ip, "w", encoding="utf-8", newline="") as f:
                f.write(header + "\n" + "\n".join(interviews) + "\n")
            with open(op, "w", encoding="utf-8", newline="") as f:
                f.write(OFFER_HEADER + "\n" + "\n".join(offers) + "\n")
            proc = run_script("kpi.py", ip, op, cwd=tmp)
        self.assertEqual(proc.returncode, 0, proc.stderr)
        self.assertNotIn("Traceback", proc.stderr)
        return proc.stdout

    @staticmethod
    def interview_rows(n, weekly, paying, strangers, communities, buyers=None):
        rows = []
        for i in range(n):
            row = (f"{i + 1},1,{int(i < weekly)},{int(i < paying)},6,"
                   f"{int(i < strangers)},{communities[i % len(communities)]},1")
            if buyers is not None:
                row += f",{int(i < buyers)}"
            rows.append(row)
        return rows

    @staticmethod
    def offer_rows(m, paid_stranger=1):
        return [f"1,990,1,{paid_stranger},"] + [f"{i},990,0,1,no" for i in range(2, m + 1)]

    BALANCED = ["a", "b", "c", "d", "e"]  # 3 of 15 each = 20%

    def test_under_ten_interviews_is_insufficient(self):
        out = self.run_case(self.interview_rows(8, 8, 8, 8, self.BALANCED), self.offer_rows(15))
        self.assertIn("TIER: INSUFFICIENT DATA", out)

    def test_go_conditional_when_every_gate_passes(self):
        out = self.run_case(self.interview_rows(15, 12, 8, 10, self.BALANCED), self.offer_rows(15))
        self.assertIn("TIER: GO-CONDITIONAL", out)
        self.assertNotIn("GO blocked by", out)
        self.assertIn("buyers not checked", out)

    def test_fewer_than_15_offers_blocks_go(self):
        out = self.run_case(self.interview_rows(15, 12, 8, 10, self.BALANCED), self.offer_rows(12))
        self.assertIn("GO blocked by: K3 needs >=15 offers (have 12)", out)
        self.assertIn("TIER: PIVOT or extend", out)

    def test_community_cap_blocks_go(self):
        communities = ["a"] * 6 + ["b", "c", "d", "e", "f", "g", "h", "i", "j"]
        out = self.run_case(self.interview_rows(15, 12, 8, 10, communities), self.offer_rows(15))
        self.assertIn("largest community 'a' 40% > 30%", out)
        self.assertIn("TIER: PIVOT or extend", out)

    def test_stranger_share_blocks_go(self):
        out = self.run_case(self.interview_rows(15, 12, 8, 6, self.BALANCED), self.offer_rows(15))
        self.assertIn("strangers 40% < 50%", out)
        self.assertIn("TIER: PIVOT or extend", out)

    def test_buyer_share_blocks_go_when_column_present(self):
        header = HEADER + ",is_buyer"
        rows = self.interview_rows(15, 12, 8, 10, self.BALANCED, buyers=5)
        out = self.run_case(rows, self.offer_rows(15), header=header)
        self.assertIn("buyers 33% < 60%", out)
        self.assertIn("TIER: PIVOT or extend", out)


if __name__ == "__main__":
    unittest.main()
