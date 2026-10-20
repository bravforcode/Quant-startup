#!/usr/bin/env bash
# Check that the anon role can do exactly what the validation design allows.
# Run after apply.sh on the same database. Each check runs in a transaction that is rolled back,
# so no test rows are left behind.
#
# Usage:  DATABASE_URL='postgresql://...' ./test_schema.sh
set -uo pipefail

: "${DATABASE_URL:?set DATABASE_URL to the database that apply.sh populated}"
failures=0

# run_as_anon <sql>  -> sets rc and out (combined psql output)
run_as_anon() {
  rc=0
  out=$(psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -q \
    -c "begin; set local role anon; ${1}; rollback;" 2>&1) || rc=$?
}

# expect <ok|denied> <label> <sql>
# "denied" only counts when Postgres says "permission denied", so a typo in the SQL cannot pass.
expect() {
  local want="$1" label="$2" sql="$3"
  run_as_anon "$sql"
  if [[ "$want" == ok ]] && (( rc != 0 )); then
    echo "FAIL  ${label}: ${out}"; failures=$((failures + 1))
  elif [[ "$want" == denied ]] && { (( rc == 0 )) || [[ "$out" != *"permission denied"* ]]; }; then
    echo "FAIL  ${label}: expected permission denied, got: ${out:-success}"; failures=$((failures + 1))
  else
    echo "ok    ${label}"
  fi
}

# expect_rejected <label> <error text that must appear> <sql>
# Rows that break a check or policy must fail with that specific error, not a different one.
expect_rejected() {
  local label="$1" pattern="$2" sql="$3"
  run_as_anon "$sql"
  if (( rc != 0 )) && [[ "$out" == *"$pattern"* ]]; then
    echo "ok    ${label}"
  else
    echo "FAIL  ${label}: expected '${pattern}', got: ${out:-success}"; failures=$((failures + 1))
  fi
}

expect ok     "anon can add a waitlist signup with consent" \
  "insert into waitlist_signups (email, source, consent_given, consent_version) values ('schema-test@example.invalid', 'test_schema', true, 'consent-v0.1-draft')"
expect_rejected "anon cannot add a waitlist signup without consent" "violates check constraint" \
  "insert into waitlist_signups (email, source) values ('schema-test@example.invalid', 'test_schema')"
expect_rejected "anon cannot add a waitlist row with a malformed address" "violates check constraint" \
  "insert into waitlist_signups (email, consent_given, consent_version) values ('not-an-address', true, 'consent-v0.1-draft')"
expect denied "anon cannot read waitlist emails"        "select 1 from waitlist_signups"
expect denied "anon cannot read contacts"               "select 1 from contacts"
expect denied "anon cannot read interviews"             "select 1 from interviews"
expect denied "anon cannot read the K1-K5 view"         "select 1 from v_k"
expect denied "anon cannot read the evidence score view" "select 1 from v_evidence_score"
expect denied "anon cannot write an interview"          "insert into interviews (interviewed_on) values (current_date)"
expect denied "anon cannot write a site event"          "insert into site_events (kind) values ('visit')"
expect denied "anon cannot read decisions"              "select 1 from decisions"
expect ok     "anon can read the keep-alive ping row"   "select 1 from keepalive"
expect denied "anon cannot change the keep-alive row"   "update keepalive set pinged_at = now()"

expect ok     "anon can place a pending order at a test tier" \
  "insert into orders (email, tier_thb, consent_given, consent_version) values ('schema-test@example.invalid', 990, true, 'consent-v0.1-draft')"
expect_rejected "anon cannot order at a price that is not a test tier" "violates check constraint" \
  "insert into orders (email, tier_thb, consent_given, consent_version) values ('schema-test@example.invalid', 1234, true, 'consent-v0.1-draft')"
expect_rejected "anon cannot insert an order already marked paid" "violates row-level security" \
  "insert into orders (email, tier_thb, status, paid_at, consent_given, consent_version) values ('schema-test@example.invalid', 990, 'paid', now(), true, 'consent-v0.1-draft')"
expect_rejected "anon cannot place an order without consent" "violates" \
  "insert into orders (email, tier_thb) values ('schema-test@example.invalid', 990)"
expect denied "anon cannot read orders"                 "select 1 from orders"
expect denied "anon cannot mark an order paid"          "update orders set status = 'paid', paid_at = now()"

if (( failures > 0 )); then
  echo "${failures} check(s) failed"
  exit 1
fi
echo "all checks passed"
