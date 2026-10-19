# Startup validation toolkit

Tools for the Zero-Budget Startup Validation Playbook v4.0. Everything here is for validation, not for the product. The playbook says to build product code only after a GO verdict, so there is no MVP, multi-tenant schema, or job queue in this folder.

## Layout

```
startup-validation/
├── sql/
│   ├── 01_evidence_ledger.sql   Evidence Ledger tables, RLS, and K1–K5 views (playbook App. B)
│   ├── 02_waitlist.sql          Fake-door waitlist table (section 2.5)
│   └── 03_keepalive.sql         Keep-alive table for Supabase free tier (App. C.4)
├── python/
│   ├── kpi.py                   K1–K5, Wilson 95% CI, and GO tier from CSV exports (App. C.1)
│   ├── funnel.py                Reverse funnel: customers wanted → DMs needed (App. C.2)
│   ├── cost.py                  LLM cost per user per month (App. C.3)
│   ├── sample/                  Synthetic CSVs for trying the scripts
│   └── tests/                   unittest suite (stdlib only)
├── ops/
│   ├── keepalive.sh             Pings the keep-alive table; optional Telegram alert
│   ├── keepalive.workflow.yml   GitHub Actions template (move to .github/workflows when needed)
│   └── crontab.example          VPS cron line for keepalive.sh
└── templates/                   Copy-paste templates from playbook sections 3, 4, 5, 6, 8
```

## Playbook section → file

| Section | File |
|---|---|
| 2.5 Waitlist table | `sql/02_waitlist.sql` |
| 6.4 / App. B Evidence Ledger | `sql/01_evidence_ledger.sql` |
| 7.1–7.7 Statistics | `python/kpi.py` |
| 9.7 Reverse funnel | `python/funnel.py` |
| 11.3 LLM cost (validation sizing) | `python/cost.py` |
| 6.3 / C.4 Supabase keep-alive | `sql/03_keepalive.sql`, `ops/` |
| 3.1–3.6, 4.4, 5.3, 6.2.4, 6.2.5, 8.2, 8.10 | `templates/` |

## Run

```bash
# Statistics and GO tier on the synthetic sample
python3 python/kpi.py python/sample/interviews.csv python/sample/offers.csv 180 7

# Reverse funnel for 3 paying customers
python3 python/funnel.py 3

# LLM cost per user per month (use prices from the vendor page on the day you run it)
python3 python/cost.py 20 800 150 1 4 990

# Tests
cd python && python3 -m unittest discover -s tests -v
```

Apply the SQL in order: `01`, then `02` and `03`. Use the Supabase SQL editor, or `psql -v ON_ERROR_STOP=1 -f <file>` against any Postgres 16 instance. Files `02` and `03` use the Supabase `anon` role, so a plain Postgres instance needs that role created first.

## Notes

- **Sample data is synthetic.** Do not treat its output as research results.
- **Prices in `cost.py` are placeholders.** Enter current prices from the vendor's pricing page each time you run it.
- **Real interview data is personal data (PDPA).** Do not commit real ledger exports, interview notes, or contact lists to this repo unless it is private. Keep them in a private store (playbook 6.4 and 13.2).
- **Keep-alive** only applies once you have a Supabase project. Until then, leave `ops/keepalive.workflow.yml` out of `.github/`.
