create table rental (
  id bigint generated always as identity primary key,
  property text not null,
  month text,
  due numeric not null,
  amount numeric not null,
  date date not null default current_date
);

create table matooke (
  id bigint generated always as identity primary key,
  date date not null default current_date,
  qty numeric not null,
  price numeric not null,
  notes text
);

create table coffee (
  id bigint generated always as identity primary key,
  date date not null default current_date,
  qty numeric not null,
  price numeric not null,
  notes text
);

create table expenses (
  id bigint generated always as identity primary key,
  date date not null default current_date,
  category text not null,
  amount numeric not null,
  notes text
);

create table debtors (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  amount numeric not null,
  date date not null default current_date,
  notes text,
  status text not null default 'owing',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);
