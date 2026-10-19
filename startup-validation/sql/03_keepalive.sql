create table keepalive (id int primary key default 1, pinged_at timestamptz default now());
insert into keepalive (id) values (1) on conflict do nothing;
alter table keepalive enable row level security;
create policy "anon read keepalive" on keepalive for select to anon using (true);  -- ไม่มีข้อมูลอ่อนไหว
