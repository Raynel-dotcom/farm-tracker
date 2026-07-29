alter table rental enable row level security;
alter table matooke enable row level security;
alter table coffee enable row level security;
alter table expenses enable row level security;
alter table debtors enable row level security;

create policy "Allow all" on rental for all using (true) with check (true);
create policy "Allow all" on matooke for all using (true) with check (true);
create policy "Allow all" on coffee for all using (true) with check (true);
create policy "Allow all" on expenses for all using (true) with check (true);
create policy "Allow all" on debtors for all using (true) with check (true);
