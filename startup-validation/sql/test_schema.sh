#!/usr/bin/env bash
# Check that the anon role can do exactly what the validation design allows.
# Run after apply.sh on the same database. Each check runs in a transaction that is rolled back,
# so no test rows are left behind.
#
# Usage:  DATABASE_URL='postgresql://...' ./test_schema.sh
set -uo pipefail

: "${DATABASE_URL:?set DATABASE_URL to the database that apply.sh populated}"
failures=0

# expect <ok|denied> <label> <sql>
# "denied" only counts when Postgres says "permission denied", so a typo in the SQL cannot pass.
expect() {
  local want="$1" label="$2" sql="$3" rc=0 out
  out=$(psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -q \
    -c "begin; set local role anon; ${sql}; rollback;" 2>&1) || rc=$?
  if [[ "$want" == ok ]] && (( rc != 0 )); then
    echo "FAIL  ${label}: ${out}"
    failures=$((failures + 1))
  elif [[ "$want" == denied ]] && { (( rc == 0 )) || [[ "$out" != *"permission denied"* ]]; }; then
    echo "FAIL  ${label}: expected permission denied, got: ${out:-success}"
    failures=$((failures + 1))
  else
    echo "ok    ${label}"
  fi
}

expect ok     "anon can add a waitlist signup"          "insert into waitlist_signups (email, source) values ('schema-test@example.invalid', 'test_schema')"
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

if (( failures > 0 )); then
  echo "${failures} check(s) failed"
  exit 1
fi
echo "all checks passed"
