-- 05_consent_and_orders.sql (added 2026-10-20, P01 payment-first test)
-- Consent is recorded per signup and per order (PDPA: what was agreed, which text, when).
-- Anonymous visitors may insert only rows that carry consent, and orders only at a listed test tier
-- in status pending. Anon can never read or update either table. Marking an order paid happens in the
-- dashboard, as postgres, once a payment provider is connected.

-- 1. Consent on waitlist signups; an address that does not look like one is rejected.
alter table waitlist_signups
  add column consent_given boolean not null default false,
  add column consent_version text,
  add column consented_at timestamptz not null default now(),
  add constraint waitlist_consent_required check (consent_given and consent_version is not null),
  add constraint waitlist_email_format check (email ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$');

-- 2. Orders. Test tiers come from plan section 8. They are hypotheses, not prices on sale.
create table orders (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  email text not null check (email ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$'),
  tier_thb int not null check (tier_thb in (990, 2490, 4990)),
  status text not null default 'pending' check (status in ('pending', 'paid', 'cancelled')),
  consent_given boolean not null default false,
  consent_version text,
  consented_at timestamptz not null default now(),
  paid_at timestamptz,
  payment_ref text,
  source text,
  utm text,
  constraint orders_consent_required check (consent_given and consent_version is not null),
  constraint orders_paid_fields check ((status = 'paid') = (paid_at is not null))
);

alter table orders enable row level security;

create policy "anon insert pending order" on orders
  for insert to anon
  with check (status = 'pending' and paid_at is null and payment_ref is null and consent_given);

revoke all on orders from anon, authenticated;
grant insert on orders to anon;
