#!/usr/bin/env python3
"""funnel.py - reverse funnel: customers wanted -> DMs needed.
Usage: python3 funnel.py 3   (override rates with env or edit RATES)"""
import math, sys
RATES = [("reply", 0.25), ("accept", 0.65), ("show", 0.75),
         ("qualified", 0.60), ("offer", 0.70), ("close", 0.15)]
target = float(sys.argv[1]) if len(sys.argv) > 1 else 3
need = target
rows = [("customers wanted", target)]
for name, r in reversed(RATES):
    need = need / r
    rows.append((f"need (before '{name}' {r:.0%})", need))
for label, v in rows:
    print(f"{label:<32}{v:8.1f}")
print(f"\nDMs needed = {math.ceil(need)}  | at 0.05h/DM = {need*0.05:.1f}h of sending time")
