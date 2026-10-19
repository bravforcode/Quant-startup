-- Source: playbook Appendix B (startup-validation-playbook-v3_1.md, lines 2096-2222), copied verbatim
-- except for the [FIX] block at the end of this file.
create table contacts (
  id bigserial primary key,
  created_at timestamptz not null default now(),
  alias text not null,                         -- นามแฝง ไม่ใช่ชื่อจริง
  channel text, segment text, community text,
  is_stranger boolean not null default true,   -- ไม่รู้จักมาก่อน
  dm_variant text,
  status text not null default 'new',          -- new|replied|scheduled|interviewed|declined|no_response
  consent_recorded boolean not null default false
);

create table assumptions (
  id text primary key,                         -- A1, A2, ...
  kind text check (kind in ('problem','awareness','value','channel')),
  statement text not null,
  kill_if text,
  status text not null default 'untested'
    check (status in ('untested','confirmed','weakened','falsified')),
  updated_at timestamptz not null default now()
);

create table interviews (
  id bigserial primary key,
  contact_id bigint references contacts(id),
  interviewed_on date not null,
  qualified boolean not null default true,     -- ตรง segment (ผ่าน screener)
  freq_weekly_plus boolean,
  workaround text,
  hours_lost_pw numeric,
  thb_spent_monthly numeric,
  paying_for_workaround boolean,               -- จ่ายเงิน/เวลามูลค่าชัดเจนอยู่แล้ว
  pain_score int check (pain_score between 0 and 10),
  advanced_commitment int check (advanced_commitment between 0 and 4),
  referral_given boolean not null default false,
  notes text
);

create table evidence (
  id bigserial primary key,
  interview_id bigint references interviews(id),
  assumption_id text references assumptions(id),
  grade char(1) not null check (grade in ('S','A','B','C','D')),
  tag text,                                    -- TRIGGER/WORKAROUND/COST_MONEY/... (8.8)
  quote text,                                  -- คำพูดเป๊ะ
  my_interpretation text,                      -- การตีความแยกจาก quote
  created_at timestamptz not null default now()
);

create table offers (
  id bigserial primary key,
  contact_id bigint references contacts(id),
  offered_on date not null default current_date,
  price_thb int not null,
  outcome text not null default 'pending'
    check (outcome in ('pending','paid','declined','no_response')),
  paid_at timestamptz,
  reason text                                  -- เหตุผลที่ไม่ซื้อ (บังคับกรอก)
);

create table site_events (
  id bigserial primary key,
  created_at timestamptz not null default now(),
  kind text not null check (kind in ('visit','signup')),
  source text, utm text, variant text,
  is_target boolean not null default true      -- กรองบอท/ตัวเอง/เพื่อนสนิทออกด้วย false
);

create table decisions (
  id text primary key,                         -- D1, D2, ...
  decided_on date not null default current_date,
  decision text not null,
  options text, evidence_ids text, chosen text,
  falsifier text, review_on date
);

alter table contacts enable row level security;
alter table assumptions enable row level security;
alter table interviews enable row level security;
alter table evidence enable row level security;
alter table offers enable row level security;
alter table site_events enable row level security;
alter table decisions enable row level security;

-- ===== Views =====
create view v_k as
with q as (
  select i.*, c.is_stranger
  from interviews i join contacts c on c.id = i.contact_id
  where i.qualified
)
select
  count(*) as n,
  count(*) filter (where freq_weekly_plus) as k1,
  ceil(0.53 * count(*)) as k1_min,
  count(*) filter (where paying_for_workaround) as k2,
  ceil(0.33 * count(*)) as k2_min,
  round(avg(pain_score)::numeric, 1) as pain_avg,
  round(100.0 * count(*) filter (where is_stranger) / nullif(count(*), 0)) as stranger_pct
from q;

create view v_offers as
select count(*) as offers,
       count(*) filter (where o.outcome = 'paid') as paid,
       count(*) filter (where o.outcome = 'paid' and c.is_stranger) as paid_strangers
from offers o join contacts c on c.id = o.contact_id;

create view v_site as
select variant,
       count(*) filter (where kind = 'visit' and is_target)  as visits,
       count(*) filter (where kind = 'signup' and is_target) as signups
from site_events group by variant;

create view v_community_share as
select c.community, count(*) as n,
       round(100.0 * count(*) / sum(count(*)) over (), 0) as pct
from interviews i join contacts c on c.id = i.contact_id
where i.qualified group by c.community;

create view v_evidence_score as          -- 7.7 (S=10 A=3 B=1; x1.5 ถ้าคนแปลกหน้า)
select e.assumption_id,
       sum(case e.grade when 'S' then 10 when 'A' then 3 when 'B' then 1 else 0 end
           * case when c.is_stranger then 1.5 else 1 end) as score,
       count(distinct i.contact_id) as distinct_sources
from evidence e
join interviews i on i.id = e.interview_id
join contacts c on c.id = i.contact_id
group by e.assumption_id;

-- [FIX] v_evidence_score: playbook 7.2 says interviews that fail the screener are not counted,
-- so their evidence must not score an assumption either.
create or replace view v_evidence_score as
select e.assumption_id,
       sum(case e.grade when 'S' then 10 when 'A' then 3 when 'B' then 1 else 0 end
           * case when c.is_stranger then 1.5 else 1 end) as score,
       count(distinct i.contact_id) as distinct_sources
from evidence e
join interviews i on i.id = e.interview_id
join contacts c on c.id = i.contact_id
where i.qualified
group by e.assumption_id;

-- [FIX] Supabase grants anon/authenticated full access to public tables and views by default.
-- RLS blocks the tables, but views run with their owner's rights and skip RLS, so anon could
-- read the K1-K5 aggregates. Revoke the API roles; the dashboard (postgres) and service_role keep access.
revoke all on contacts, assumptions, interviews, evidence, offers, site_events, decisions,
  v_k, v_offers, v_site, v_community_share, v_evidence_score
  from anon, authenticated;
