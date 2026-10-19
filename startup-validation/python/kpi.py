#!/usr/bin/env python3
"""kpi.py - compute K1..K5 + Wilson 95% CI and the Stage 4 tier from CSV exports.
Usage: python3 kpi.py interviews.csv offers.csv [visitors] [signups]
interviews.csv columns: id,qualified,freq_weekly_plus,paying_for_workaround,pain_score,is_stranger,source_community,advanced_commitment[,is_buyer]
offers.csv columns: id,price_thb,paid,is_stranger,reason
(qualified/freq_weekly_plus/paying_for_workaround/paid/is_stranger/is_buyer are 1/0; is_buyer is optional)

Tier rules follow preregistration.md: no tier below 10 qualified interviews (K6 allows one
1-week extension). GO tiers also need >=15 offers (K3), strangers >=50%, largest community
<=30%, and buyers >=60% when the is_buyer column is present."""
import csv, math, sys, collections

MIN_INTERVIEWS = 10
MIN_OFFERS = 15
MIN_STRANGERS = 0.50
MAX_COMMUNITY = 0.30
MIN_BUYERS = 0.60

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
        reader = csv.DictReader(f)
        return reader.fieldnames or [], list(reader)

def gate_gaps(m, stranger_share, top, top_share, buyer_share):
    gaps = []
    if m < MIN_OFFERS:
        gaps.append(f"K3 needs >={MIN_OFFERS} offers (have {m})")
    if stranger_share < MIN_STRANGERS:
        gaps.append(f"strangers {pct(stranger_share)} < {pct(MIN_STRANGERS)}")
    if top_share > MAX_COMMUNITY:
        gaps.append(f"largest community '{top}' {pct(top_share)} > {pct(MAX_COMMUNITY)}")
    if buyer_share is not None and buyer_share < MIN_BUYERS:
        gaps.append(f"buyers {pct(buyer_share)} < {pct(MIN_BUYERS)}")
    return gaps

def decide(n, k1, k1_min, k2, k2_min, m, paid, paid_strangers, k1_lower, gaps):
    if n < MIN_INTERVIEWS:
        return (f"INSUFFICIENT DATA (n={n}: need >={MIN_INTERVIEWS} qualified interviews; "
                "K6 allows one 1-week extension)")
    if k1 < k1_min:
        return "KILL (K1 failed)"
    if not gaps and k2 >= k2_min and paid >= 3 and paid_strangers >= 2 and k1_lower >= 0.35:
        return "GO-STRONG (also check pattern>=3 strangers, warm list>=8)"
    if not gaps and k2 >= k2_min and paid >= 1 and paid_strangers >= 1:
        return "GO-CONDITIONAL (check warm list>=5)"
    if k2 < k2_min and paid == 0 and m >= MIN_OFFERS:
        return "KILL/PIVOT (K2 and K3 failed)"
    return "PIVOT or extend per PART 7.4 / K6"

def main():
    header, rows = read(sys.argv[1])
    iv = [r for r in rows if r["qualified"] == "1"]
    _, of = read(sys.argv[2])
    n = len(iv)
    has_buyer = "is_buyer" in header
    k1 = sum(r["freq_weekly_plus"] == "1" for r in iv)
    k2 = sum(r["paying_for_workaround"] == "1" for r in iv)
    pains = [float(r["pain_score"]) for r in iv if r["pain_score"]]
    strangers = sum(r["is_stranger"] == "1" for r in iv)
    comm = collections.Counter(r["source_community"] for r in iv)
    buyers = sum(r["is_buyer"] == "1" for r in iv) if has_buyer else 0
    k1_min, k2_min = math.ceil(0.53 * n), math.ceil(0.33 * n)
    top, top_n = comm.most_common(1)[0] if comm else ("", 0)
    top_share = top_n / n if n else 0.0
    stranger_share = strangers / n if n else 0.0
    buyer_share = buyers / n if has_buyer and n else None
    k1_lower = wilson(k1, n)[0] if n else 0.0

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
        print(f"strangers {strangers}/{n} = {pct(stranger_share)} (target >=50%)")
        if comm:
            print(f"largest community '{top}' = {pct(top_share)} (cap 30%)")
        if has_buyer:
            print(f"buyers {buyers}/{n} = {pct(buyer_share)} (target >=60%)")
        else:
            print("buyers not checked: add an is_buyer column (1/0) to interviews.csv")

    m = len(of)
    paid = [r for r in of if r["paid"] == "1"]
    paid_strangers = sum(r["is_stranger"] == "1" for r in paid)
    print(f"K3 offers {m}, paid {len(paid)} (strangers {paid_strangers})")
    if len(paid) == 0 and m < MIN_OFFERS:
        print(f"  -> 0 paid but offers <{MIN_OFFERS}: NOT enough to KILL on K3 (PART 7.3)")

    if len(sys.argv) >= 5:
        v, s = int(sys.argv[3]), int(sys.argv[4])
        if v == 0:
            print(f"K4 landing {s}/{v} = n/a (0 visitors: no rate yet)")
        else:
            lo3, hi3 = wilson(s, v)
            note = "" if v >= 150 else "  (visitors<150: do NOT conclude)"
            print(f"K4 landing {s}/{v} = {s/v*100:.1f}%  CI {lo3*100:.1f}-{hi3*100:.1f}%{note}")

    gaps = gate_gaps(m, stranger_share, top, top_share, buyer_share) if n else []
    go_signal = (n >= MIN_INTERVIEWS and k1 >= k1_min and k2 >= k2_min
                 and len(paid) >= 1 and paid_strangers >= 1)
    if go_signal and gaps:
        print("GO blocked by: " + "; ".join(gaps))
    print("TIER:", decide(n, k1, k1_min, k2, k2_min, m, len(paid), paid_strangers, k1_lower, gaps))

if __name__ == "__main__":
    main()
