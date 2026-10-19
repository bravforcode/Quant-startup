#!/usr/bin/env bash
# Supabase keep-alive ping for the free project (playbook C.4).
# Required env: SUPABASE_URL, SUPABASE_ANON_KEY
# Optional env: TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID (failure alert)
set -euo pipefail

if [ -z "${SUPABASE_URL:-}" ]; then
  echo "keepalive failed: SUPABASE_URL is not set" >&2
  exit 1
fi
if [ -z "${SUPABASE_ANON_KEY:-}" ]; then
  echo "keepalive failed: SUPABASE_ANON_KEY is not set" >&2
  exit 1
fi

if ! curl -fsS --max-time 20 \
  "$SUPABASE_URL/rest/v1/keepalive?select=id&limit=1" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" >/dev/null; then
  echo "keepalive failed" >&2
  if [ -n "${TELEGRAM_BOT_TOKEN:-}" ] && [ -n "${TELEGRAM_CHAT_ID:-}" ]; then
    if ! curl -fsS --max-time 20 \
      "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
      --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
      --data-urlencode "text=keepalive failed (Supabase ping) at $(date -u '+%Y-%m-%d %H:%M UTC')" \
      >/dev/null; then
      echo "keepalive: Telegram alert could not be sent" >&2
    fi
  fi
  exit 1
fi

echo "keepalive ok"
