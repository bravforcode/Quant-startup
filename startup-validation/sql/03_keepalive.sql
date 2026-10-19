-- Source: playbook section C.4 (startup-validation-playbook-v3_1.md, lines 2394-2397), copied verbatim.
-- Requires the Supabase "anon" role (created locally for tests; exists by default on Supabase).
create table keepalive (id int primary key default 1, pinged_at timestamptz default now());
insert into keepalive (id) values (1) on conflict do nothing;
alter table keepalive enable row level security;
create policy "anon read keepalive" on keepalive for select to anon using (true);  -- ไม่มีข้อมูลอ่อนไหว
