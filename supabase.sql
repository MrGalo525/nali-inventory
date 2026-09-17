
-- NALI INVENTORY SYSTEM - SUPABASE DATABASE
-- Run this entire script in Supabase SQL Editor.

create table if not exists public.products (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  sku text not null,
  name text not null,
  category text not null check (category in ('Raw Material','Empty Bottle','Finished Water')),
  unit text not null default 'pcs',
  minimum_stock integer not null default 0,
  created_at timestamptz not null default now(),
  unique(user_id, sku)
);

create table if not exists public.transactions (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  product_id bigint not null references public.products(id) on delete restrict,
  transaction_date date not null default current_date,
  transaction_type text not null check (
    transaction_type in (
      'Purchase','Manufactured','Production Loss','Filled',
      'Sold','Damaged','Adjustment In','Adjustment Out'
    )
  ),
  quantity integer not null check (quantity > 0),
  reference_no text,
  notes text,
  created_at timestamptz not null default now()
);

alter table public.products enable row level security;
alter table public.transactions enable row level security;

drop policy if exists "Users can view own products" on public.products;
create policy "Users can view own products"
on public.products for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own products" on public.products;
create policy "Users can insert own products"
on public.products for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own products" on public.products;
create policy "Users can update own products"
on public.products for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own products" on public.products;
create policy "Users can delete own products"
on public.products for delete
using (auth.uid() = user_id);

drop policy if exists "Users can view own transactions" on public.transactions;
create policy "Users can view own transactions"
on public.transactions for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own transactions" on public.transactions;
create policy "Users can insert own transactions"
on public.transactions for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own transactions" on public.transactions;
create policy "Users can update own transactions"
on public.transactions for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own transactions" on public.transactions;
create policy "Users can delete own transactions"
on public.transactions for delete
using (auth.uid() = user_id);

create index if not exists transactions_user_date_idx
on public.transactions(user_id, transaction_date desc);

create index if not exists transactions_product_idx
on public.transactions(product_id);

-- Optional starter products are NOT inserted automatically.
