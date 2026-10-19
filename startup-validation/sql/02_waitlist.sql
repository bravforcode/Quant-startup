-- Source: playbook section 2.5 (startup-validation-playbook-v3_1.md, lines 340-353), copied verbatim.
-- Requires the Supabase "anon" role (created locally for tests; exists by default on Supabase).
create table waitlist_signups (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  email text,
  line_id text,
  segment text,           -- อาชีพ/ประเภทธุรกิจ
  biggest_pain text,      -- คำถามเสริม 1 ข้อ: "อะไรคือสิ่งที่เจ็บที่สุดเรื่อง [ปัญหา]?"
  source text,            -- fb_group_x / reddit_y / dm
  utm text
);
alter table waitlist_signups enable row level security;
create policy "anon insert" on waitlist_signups
  for insert to anon with check (true);
-- อย่าเปิด select policy — ป้องกันคนอ่านอีเมลคนอื่น (PDPA-friendly)

-- [FIX] Supabase grants anon full table access by default. Anon only needs to insert.
revoke all on waitlist_signups from anon;
grant insert on waitlist_signups to anon;
