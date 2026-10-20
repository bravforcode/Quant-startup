# Startup validation toolkit

Tools for the Zero-Budget Startup Validation Playbook v4.0. Everything here is for validation, not for the product. The playbook says to build product code only after a GO verdict, so there is no MVP, multi-tenant schema, or job queue in this folder.

Project status against the P01 plan lives in `validation/p01-ea-validation/STATUS.md`.

## Layout

```
startup-validation/
├── sql/
│   ├── 01_evidence_ledger.sql   Evidence Ledger tables, RLS, and K1–K5 views (playbook App. B)
│   ├── 02_waitlist.sql          Fake-door waitlist table (section 2.5)
│   ├── 03_keepalive.sql         Keep-alive table for Supabase free tier (App. C.4); not needed on Neon
│   ├── 04_seed_assumptions.sql  The nine P01 assumptions (A1–A9) from validation/p01-ea-validation/assumptions.md
│   ├── apply.sh                 Applies 01–04 to an empty Postgres 16 database
│   └── test_schema.sh           Checks what the anon role may and may not do
├── python/
│   ├── kpi.py                   K1–K5, Wilson 95% CI, and the Stage 4 tier from CSV exports (App. C.1)
│   ├── funnel.py                Reverse funnel: customers wanted → DMs needed (App. C.2)
│   ├── cost.py                  LLM cost per user per month (App. C.3)
│   ├── sample/                  Synthetic CSVs for trying the scripts
│   └── tests/                   unittest suite (stdlib only)
├── ops/
│   ├── keepalive.sh             Pings the keep-alive table; optional Telegram alert (Supabase only)
│   ├── keepalive.workflow.yml   GitHub Actions template (move to .github/workflows when needed)
│   └── crontab.example          VPS cron line for keepalive.sh
├── validation/p01-ea-validation/  P01 protocol, pre-registration, assumptions, competitor worksheet,
│                                  drafts (withdrawn), consent and lawyer drafts, landing page
└── templates/                   Copy-paste templates from playbook sections 3, 4, 5, 6, 8
```

## Playbook section → file

| Section | File |
|---|---|
| 2.5 Waitlist table | `sql/02_waitlist.sql` |
| 6.4 / App. B Evidence Ledger | `sql/01_evidence_ledger.sql`, `sql/apply.sh` |
| 7.1–7.7 Statistics | `python/kpi.py` |
| 9.7 Reverse funnel | `python/funnel.py` |
| 11.3 LLM cost (validation sizing) | `python/cost.py` |
| 6.3 / C.4 Supabase keep-alive | `sql/03_keepalive.sql`, `ops/` |
| 3.1–3.6, 4.4, 5.3, 6.2.4, 6.2.5, 8.2, 8.10 | `templates/` |

## Free Postgres for the Evidence Ledger

**Use Neon.** Checked on 2026-10-19 at neon.com/pricing: the free plan needs no card, allows 100 projects, gives each project 100 CU-hours a month and 1 GB of storage, and suspends idle compute after 5 minutes without deleting data.

**Why not Supabase here:** the free tier allows two active projects per organization, and this organization already has two active production projects. Free projects also pause after seven days without activity.

Setup, once:

1. Create a free Neon project and copy its connection string (it ends in `sslmode=require`).
2. Run the schema on the empty database:
   ```bash
   cd startup-validation/sql
   DATABASE_URL='postgresql://...' ./apply.sh
   ```
3. Check the anon-role permissions. It should end with `all checks passed`:
   ```bash
   DATABASE_URL='postgresql://...' ./test_schema.sh
   ```

Keep the connection string in a password manager. Do not commit it. `apply.sh` creates the `anon` and `authenticated` roles because Neon does not have them. The scripts were tested on PostgreSQL 16.15, not yet on Neon itself. If step 2 fails on role creation or grants, keep the error text and check it against this README.

The landing page writes through the Neon Data API (PostgREST). The `anon` role can insert into `waitlist_signups` (with consent) and `orders` (pending, at a listed test tier), and nothing else. Set `API_BASE` in `validation/p01-ea-validation/landing/index.html` to the project's Data API URL. Before that, enable the Data API and confirm how it authenticates anonymous requests in the Neon console, because sources disagree on whether it is generally available on the free plan. If it is not available, use a Cloudflare Worker that holds the connection string in its environment instead.

Neon's free plan allows the Data API only where the console offers it. Re-run `test_schema.sh` after any change to `anon` grants.

## Stage 4 tier rules (kpi.py)

- Fewer than 10 qualified interviews gives `INSUFFICIENT DATA`. K6 allows one one-week extension.
- K1 and K2 use the thresholds from `preregistration.md` (53% and 33% of n, rounded up).
- A GO tier also needs at least 15 offers (K3), at least 50% strangers, a largest community at or below 30%, and at least 60% buyers when the `is_buyer` column is present. When a gate fails, the output lists it on a `GO blocked by` line.
- The tier is computed only by `kpi.py`. The SQL views are dashboards and do not decide anything.

## Run

```bash
# Statistics and tier on the synthetic sample (expect "GO blocked by" and PIVOT or extend)
python3 python/kpi.py python/sample/interviews.csv python/sample/offers.csv 180 7

# Reverse funnel for 3 paying customers
python3 python/funnel.py 3

# LLM cost per user per month (use prices from the vendor page on the day you run it)
python3 python/cost.py 20 800 150 1 4 990

# Python tests
cd python && python3 -m unittest discover -s tests -v
```

Apply the SQL with `sql/apply.sh` against an empty database. For a database you set up by hand, run `01`, `02`, `03`, and `04` in order with `psql -v ON_ERROR_STOP=1 -f <file>`, after creating the `anon` and `authenticated` roles.

## Notes

- **Sample data is synthetic.** Do not treat its output as research results.
- **Prices in `cost.py` are placeholders.** Enter current prices from the vendor's pricing page each time you run it.
- **Real interview data is personal data (PDPA).** Do not commit real ledger exports, interview notes, or contact lists to this repo unless it is private. Keep them in a private store (playbook 6.4 and 13.2).
- **Keep-alive** applies only to Supabase free projects, which pause after seven days without activity. Neon does not pause the project, so `ops/` is not needed there. Until you use Supabase, leave `ops/keepalive.workflow.yml` out of `.github/`.
