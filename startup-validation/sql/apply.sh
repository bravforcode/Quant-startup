#!/usr/bin/env bash
# Apply the P01 validation schema to a fresh, empty Postgres 16 database.
# Works on Neon (free plan), a local Postgres, or Supabase. Run it once per database.
#
# Usage:  DATABASE_URL='postgresql://user:pass@host/db?sslmode=require' ./apply.sh
set -euo pipefail

: "${DATABASE_URL:?set DATABASE_URL to the connection string of an empty database}"
dir="$(cd "$(dirname "$0")" && pwd)"

# Supabase creates anon and authenticated for you. Neon and plain Postgres do not, so create them
# (NOLOGIN, like Supabase) before the grants and policies in the SQL files refer to them.
# Granting membership to the current user lets test_schema.sh switch to the anon role.
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -q <<'SQL'
do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'anon') then
    create role anon nologin;
  end if;
  if not exists (select 1 from pg_roles where rolname = 'authenticated') then
    create role authenticated nologin;
  end if;
end
$$;
grant anon, authenticated to current_user;
SQL

for f in 01_evidence_ledger.sql 02_waitlist.sql 03_keepalive.sql 04_seed_assumptions.sql 05_consent_and_orders.sql; do
  echo "applying $f"
  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -q -f "$dir/$f"
done
echo "done: schema applied. Next: DATABASE_URL=... $dir/test_schema.sh"
