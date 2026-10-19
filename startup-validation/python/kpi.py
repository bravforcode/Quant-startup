#!/usr/bin/env python3
"""kpi.py - compute K1..K5 + Wilson 95% CI from CSV exports.
Usage: python3 kpi.py interviews.csv offers.csv [visitors] [signups]
interviews.csv columns: id,qualified,freq_weekly_plus,paying_for_workaround,pain_score,is_stranger,source_community,advanced_commitment
offers.csv columns: id,price_thb,paid,is_stranger,reason
(qualified/freq_weekly_plus/paying_for_workaround/paid/is_stranger are 1/0)"""
import csv, math, sys, collections

def wilson(k, n, z=1.96):
    if n == 0:
        return (0.0, 0.0)
    p = k / n
    d = 1 + z * z / n
    c = (p + z * z / (2 * n)) / d
    h = z * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n)) / d
    return (max(0.0, c - h), min(1.0, c + h))

def pct(x):
    return f"{x * 100:.0f}%"

def read(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))

def main():
    iv = [r for r in read(sys.argv[1]) if r["qualified"] == "1"]
    of = read(sys.argv[2])
    n = len(iv)
    k1 = sum(r["freq_weekly_plus"] == "1" for r in iv)
    k2 = sum(r["paying_for_workaround"] == "1" for r in iv)
    pains = [float(r["pain_score"]) for r in iv if r["pain_score"]]
    strangers = sum(r["is_stranger"] == "1" for r in iv)
    comm = collections.Counter(r["source_community"] for r in iv)
    k1_min, k2_min = math.ceil(0.53 * n), math.ceil(0.33 * n)

    if n == 0:
        print("n=0: no qualified interviews yet (need >=10; target 15) - K1/K2/K5/strangers not computed")
    else:
        print(f"qualified interviews n={n} (need >=10; target 15)")
        lo, hi = wilson(k1, n)
        print(f"K1 weekly+: {k1}/{n} = {pct(k1/n)}  CI {pct(lo)}-{pct(hi)}  threshold>={k1_min} -> {'PASS' if k1 >= k1_min else 'FAIL'}")
        lo2, hi2 = wilson(k2, n)
        print(f"K2 paying : {k2}/{n} = {pct(k2/n)}  CI {pct(lo2)}-{pct(hi2)}  threshold>={k2_min} -> {'PASS' if k2 >= k2_min else 'FAIL'}")
        if pains:
            print(f"K5 pain mean {sum(pains)/len(pains):.1f}/10 (opinion-grade; corroborating only)")
        print(f"strangers {strangers}/{n} = {pct(strangers/n)} (target >=50%)")
        if comm:
            top, cnt = comm.most_common(1)[0]
            print(f"largest community '{top}' = {pct(cnt/n)} (cap 30%)")

    m = len(of)
    paid = [r for r in of if r["paid"] == "1"]
    paid_strangers = sum(r["is_stranger"] == "1" for r in paid)
    print(f"K3 offers {m}, paid {len(paid)} (strangers {paid_strangers})")
    if len(paid) == 0 and m < 15:
        print("  -> 0 paid but offers <15: NOT enough to KILL on K3 (PART 7.3)")

    if len(sys.argv) >= 5:
        v, s = int(sys.argv[3]), int(sys.argv[4])
        if v == 0:
            print(f"K4 landing {s}/{v} = n/a (0 visitors: no rate yet)")
        else:
            lo3, hi3 = wilson(s, v)
            note = "" if v >= 150 else "  (visitors<150: do NOT conclude)"
            print(f"K4 landing {s}/{v} = {s/v*100:.1f}%  CI {lo3*100:.1f}-{hi3*100:.1f}%{note}")

    if n == 0:
        tier = "INSUFFICIENT DATA (n=0: need >=10 qualified interviews)"
    elif k1 < k1_min:
        tier = "KILL (K1 failed)"
    elif len(paid) >= 3 and paid_strangers >= 2 and k2 >= k2_min and wilson(k1, n)[0] >= 0.35:
        tier = "GO-STRONG (also check pattern>=3 strangers, warm list>=8)"
    elif k2 >= k2_min and len(paid) >= 1 and paid_strangers >= 1:
        tier = "GO-CONDITIONAL (check warm list>=5)"
    elif k2 < k2_min and len(paid) == 0 and m >= 15:
        tier = "KILL/PIVOT (K2 and K3 failed)"
    else:
        tier = "PIVOT or extend per PART 7.4 / K6"
    print("TIER:", tier)

if __name__ == "__main__":
    main()
