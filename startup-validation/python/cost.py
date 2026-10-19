#!/usr/bin/env python3
"""cost.py - LLM cost per user per month. Fill prices from the vendor page TODAY.
Usage: python3 cost.py calls_per_day tokens_in tokens_out price_in_per_1M price_out_per_1M [price_thb]"""
import sys
c, ti, to, pi, po = map(float, sys.argv[1:6])
price = float(sys.argv[6]) if len(sys.argv) > 6 else None
per_call = (ti * pi + to * po) / 1_000_000
month = c * 30 * per_call
print(f"per call {per_call:.5f} THB | per user/month {month:.2f} THB")
if price:
    print(f"share of price {month/price:.2%} | gross margin (LLM only) {(price-month)/price:.2%}")
