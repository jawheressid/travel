create table if not exists public.partner_types (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  label text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.partners (
  id uuid primary key default gen_random_uuid(),
  owner_user_id uuid not null references public.profiles(id) on delete cascade,
  partner_type_id uuid references public.partner_types(id) on delete set null,
  display_name text not null,
  legal_name text not null,
  email text not null,
  phone text,
  region_id uuid references public.governorates(id) on delete set null,
  status text not null default 'pending',
  kyc_status text not null default 'not_submitted',
  is_active boolean not null default false,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint partners_status_check check (
    status in ('draft', 'pending', 'approved', 'rejected', 'suspended')
  ),
  constraint partners_kyc_status_check check (
    kyc_status in ('not_submitted', 'pending', 'verified', 'rejected')
  )
);

create table if not exists public.partner_documents (
  id uuid primary key default gen_random_uuid(),
  partner_id uuid not null references public.partners(id) on delete cascade,
  document_type text not null,
  file_path text not null,
  status text not null default 'pending',
  notes text,
  reviewed_by uuid references public.profiles(id) on delete set null,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint partner_documents_status_check check (
    status in ('pending', 'approved', 'rejected')
  )
);

alter table public.places
  add column if not exists partner_id uuid references public.partners(id) on delete set null,
  add column if not exists review_status text not null default 'approved',
  add column if not exists published_at timestamptz,
  add column if not exists metadata jsonb not null default '{}'::jsonb;

update public.places
set
  review_status = coalesce(review_status, 'approved'),
  published_at = coalesce(published_at, created_at);

alter table public.places drop constraint if exists places_review_status_check;
alter table public.places
add constraint places_review_status_check check (
  review_status in ('draft', 'pending_review', 'approved', 'rejected', 'archived')
);

create table if not exists public.availability_slots (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null references public.places(id) on delete cascade,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  capacity_total integer not null default 1,
  capacity_reserved integer not null default 0,
  is_closed boolean not null default false,
  min_notice_hours integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint availability_slots_window_check check (ends_at > starts_at),
  constraint availability_slots_capacity_total_check check (capacity_total > 0),
  constraint availability_slots_capacity_reserved_check check (
    capacity_reserved >= 0 and capacity_reserved <= capacity_total
  ),
  unique (place_id, starts_at, ends_at)
);

create table if not exists public.pricing_rules (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null references public.places(id) on delete cascade,
  rule_type text not null,
  date_from date,
  date_to date,
  days_of_week integer[] not null default '{}',
  min_quantity integer,
  max_quantity integer,
  adjustment_type text not null,
  adjustment_value numeric(10, 2) not null,
  priority integer not null default 100,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint pricing_rules_rule_type_check check (
    rule_type in ('date_range', 'day_of_week', 'quantity', 'seasonal')
  ),
  constraint pricing_rules_adjustment_type_check check (
    adjustment_type in ('fixed_delta', 'percent_delta', 'override')
  ),
  constraint pricing_rules_quantity_check check (
    coalesce(min_quantity, 0) >= 0
    and (max_quantity is null or max_quantity >= coalesce(min_quantity, 0))
  ),
  constraint pricing_rules_date_window_check check (
    date_from is null or date_to is null or date_to >= date_from
  )
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  channel text not null,
  type text not null,
  title text not null,
  body text not null,
  payload jsonb not null default '{}'::jsonb,
  status text not null default 'pending',
  sent_at timestamptz,
  read_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint notifications_channel_check check (
    channel in ('in_app', 'email', 'push', 'sms')
  ),
  constraint notifications_status_check check (
    status in ('pending', 'sent', 'failed', 'read')
  )
);

create table if not exists public.support_tickets (
  id uuid primary key default gen_random_uuid(),
  requester_user_id uuid not null references public.profiles(id) on delete cascade,
  booking_id uuid references public.bookings(id) on delete set null,
  partner_id uuid references public.partners(id) on delete set null,
  category text not null,
  priority text not null default 'normal',
  status text not null default 'open',
  subject text not null,
  description text not null,
  assigned_to uuid references public.profiles(id) on delete set null,
  resolved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint support_tickets_priority_check check (
    priority in ('low', 'normal', 'high', 'urgent')
  ),
  constraint support_tickets_status_check check (
    status in ('open', 'in_progress', 'waiting_customer', 'resolved', 'closed')
  )
);

create table if not exists public.booking_status_history (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings(id) on delete cascade,
  old_status text,
  new_status text not null,
  changed_by uuid references public.profiles(id) on delete set null,
  reason text,
  created_at timestamptz not null default now()
);

create table if not exists public.audit_logs (
  id uuid primary key default gen_random_uuid(),
  actor_user_id uuid references public.profiles(id) on delete set null,
  entity_type text not null,
  entity_id text not null,
  action text not null,
  context jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

alter table public.bookings
  add column if not exists expires_at timestamptz,
  add column if not exists confirmed_at timestamptz,
  add column if not exists cancelled_at timestamptz,
  add column if not exists metadata jsonb not null default '{}'::jsonb;

alter table public.bookings drop constraint if exists bookings_status_check;
alter table public.bookings
add constraint bookings_status_check check (
  status in (
    'draft',
    'pendingPayment',
    'confirmed',
    'cancelled',
    'failed',
    'expired',
    'refunded'
  )
);

alter table public.bookings drop constraint if exists bookings_payment_status_check;
alter table public.bookings
add constraint bookings_payment_status_check check (
  payment_status in ('pending', 'success', 'failed', 'refunded')
);

alter table public.payments
  add column if not exists idempotency_key text,
  add column if not exists failure_reason text;

alter table public.payments drop constraint if exists payments_status_check;
alter table public.payments
add constraint payments_status_check check (
  status in ('pending', 'success', 'failed', 'refunded')
);

insert into public.partner_types (code, label)
values
  ('accommodation', 'Accommodation'),
  ('restaurant', 'Restaurant'),
  ('artisan', 'Artisan'),
  ('activity', 'Activity'),
  ('transport', 'Transport'),
  ('guide', 'Guide')
on conflict (code) do update
set label = excluded.label;

create or replace function public.is_partner_owned_by_current_user(target_partner_id uuid)
returns boolean
language sql
stable
as $$
  select exists (
    select 1
    from public.partners p
    where p.id = target_partner_id and p.owner_user_id = auth.uid()
  );
$$;

create or replace function public.is_place_owned_by_current_user(target_place_id uuid)
returns boolean
language sql
stable
as $$
  select exists (
    select 1
    from public.places pl
    join public.partners p on p.id = pl.partner_id
    where pl.id = target_place_id and p.owner_user_id = auth.uid()
  );
$$;

create or replace function public.refresh_booking_total_from_items()
returns trigger
language plpgsql
as $$
declare
  target_booking_id uuid;
begin
  target_booking_id := coalesce(new.booking_id, old.booking_id);

  update public.bookings
  set total_amount = coalesce((
    select sum(item.quantity * item.unit_price)
    from public.booking_items item
    where item.booking_id = target_booking_id
  ), 0)
  where id = target_booking_id;

  return coalesce(new, old);
end;
$$;

create or replace function public.set_booking_state_timestamps()
returns trigger
language plpgsql
as $$
begin
  if new.status is distinct from old.status then
    if new.status = 'confirmed' then
      new.confirmed_at = coalesce(new.confirmed_at, now());
    end if;

    if new.status = 'cancelled' then
      new.cancelled_at = coalesce(new.cancelled_at, now());
    end if;
  end if;

  return new;
end;
$$;

create or replace function public.track_booking_status_change()
returns trigger
language plpgsql
as $$
begin
  if new.status is distinct from old.status then
    insert into public.booking_status_history (
      booking_id,
      old_status,
      new_status,
      changed_by
    )
    values (
      new.id,
      old.status,
      new.status,
      auth.uid()
    );
  end if;

  return new;
end;
$$;

create or replace function public.sync_booking_state_from_payment()
returns trigger
language plpgsql
as $$
begin
  update public.bookings
  set
    payment_status = new.status,
    status = case
      when new.status = 'success' then 'confirmed'
      when new.status = 'failed' and status in ('draft', 'pendingPayment') then 'failed'
      when new.status = 'refunded' then 'refunded'
      else status
    end
  where id = new.booking_id;

  return new;
end;
$$;

create unique index if not exists idx_partners_owner_display_name on public.partners(owner_user_id, display_name);
create index if not exists idx_places_partner on public.places(partner_id);
create index if not exists idx_places_review_status on public.places(review_status);
create index if not exists idx_availability_slots_place_start on public.availability_slots(place_id, starts_at);
create index if not exists idx_pricing_rules_place_active on public.pricing_rules(place_id, is_active, priority);
create index if not exists idx_notifications_user_created on public.notifications(user_id, created_at desc);
create index if not exists idx_support_tickets_requester on public.support_tickets(requester_user_id, created_at desc);
create index if not exists idx_booking_status_history_booking on public.booking_status_history(booking_id, created_at desc);
create unique index if not exists idx_payments_provider_reference_unique on public.payments(provider, provider_reference);
create unique index if not exists idx_payments_idempotency_key_unique on public.payments(idempotency_key) where idempotency_key is not null;

drop trigger if exists trg_partner_types_updated_at on public.partner_types;
create trigger trg_partner_types_updated_at before update on public.partner_types
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_partners_updated_at on public.partners;
create trigger trg_partners_updated_at before update on public.partners
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_partner_documents_updated_at on public.partner_documents;
create trigger trg_partner_documents_updated_at before update on public.partner_documents
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_availability_slots_updated_at on public.availability_slots;
create trigger trg_availability_slots_updated_at before update on public.availability_slots
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_pricing_rules_updated_at on public.pricing_rules;
create trigger trg_pricing_rules_updated_at before update on public.pricing_rules
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_notifications_updated_at on public.notifications;
create trigger trg_notifications_updated_at before update on public.notifications
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_support_tickets_updated_at on public.support_tickets;
create trigger trg_support_tickets_updated_at before update on public.support_tickets
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_bookings_state_timestamps on public.bookings;
create trigger trg_bookings_state_timestamps before update on public.bookings
for each row execute procedure public.set_booking_state_timestamps();

drop trigger if exists trg_bookings_status_history on public.bookings;
create trigger trg_bookings_status_history after update on public.bookings
for each row execute procedure public.track_booking_status_change();

drop trigger if exists trg_booking_items_refresh_total_insert on public.booking_items;
create trigger trg_booking_items_refresh_total_insert after insert on public.booking_items
for each row execute procedure public.refresh_booking_total_from_items();

drop trigger if exists trg_booking_items_refresh_total_update on public.booking_items;
create trigger trg_booking_items_refresh_total_update after update on public.booking_items
for each row execute procedure public.refresh_booking_total_from_items();

drop trigger if exists trg_booking_items_refresh_total_delete on public.booking_items;
create trigger trg_booking_items_refresh_total_delete after delete on public.booking_items
for each row execute procedure public.refresh_booking_total_from_items();

drop trigger if exists trg_payments_sync_booking_state on public.payments;
create trigger trg_payments_sync_booking_state after insert or update on public.payments
for each row execute procedure public.sync_booking_state_from_payment();

alter table public.partner_types enable row level security;
alter table public.partners enable row level security;
alter table public.partner_documents enable row level security;
alter table public.availability_slots enable row level security;
alter table public.pricing_rules enable row level security;
alter table public.notifications enable row level security;
alter table public.support_tickets enable row level security;
alter table public.booking_status_history enable row level security;
alter table public.audit_logs enable row level security;

drop policy if exists "partner_types_public_read" on public.partner_types;
create policy "partner_types_public_read" on public.partner_types
for select using (true);

drop policy if exists "partners_select_own_or_approved" on public.partners;
create policy "partners_select_own_or_approved" on public.partners
for select using (
  owner_user_id = auth.uid() or (status = 'approved' and is_active = true)
);

drop policy if exists "partners_insert_own" on public.partners;
create policy "partners_insert_own" on public.partners
for insert with check (owner_user_id = auth.uid());

drop policy if exists "partners_update_own" on public.partners;
create policy "partners_update_own" on public.partners
for update using (owner_user_id = auth.uid()) with check (owner_user_id = auth.uid());

drop policy if exists "partner_documents_own_all" on public.partner_documents;
create policy "partner_documents_own_all" on public.partner_documents
for all using (public.is_partner_owned_by_current_user(partner_id))
with check (public.is_partner_owned_by_current_user(partner_id));

drop policy if exists "public_read_places" on public.places;
drop policy if exists "places_public_read_or_owner" on public.places;
create policy "places_public_read_or_owner" on public.places
for select using (
  (is_active = true and review_status = 'approved') or public.is_place_owned_by_current_user(id)
);

drop policy if exists "availability_slots_public_read" on public.availability_slots;
create policy "availability_slots_public_read" on public.availability_slots
for select using (
  exists (
    select 1
    from public.places pl
    where pl.id = place_id
      and ((pl.is_active = true and pl.review_status = 'approved') or public.is_place_owned_by_current_user(pl.id))
  )
);

drop policy if exists "availability_slots_owner_write" on public.availability_slots;
create policy "availability_slots_owner_write" on public.availability_slots
for all using (public.is_place_owned_by_current_user(place_id))
with check (public.is_place_owned_by_current_user(place_id));

drop policy if exists "pricing_rules_public_read" on public.pricing_rules;
create policy "pricing_rules_public_read" on public.pricing_rules
for select using (
  exists (
    select 1
    from public.places pl
    where pl.id = place_id
      and ((pl.is_active = true and pl.review_status = 'approved') or public.is_place_owned_by_current_user(pl.id))
  )
);

drop policy if exists "pricing_rules_owner_write" on public.pricing_rules;
create policy "pricing_rules_owner_write" on public.pricing_rules
for all using (public.is_place_owned_by_current_user(place_id))
with check (public.is_place_owned_by_current_user(place_id));

drop policy if exists "notifications_own_all" on public.notifications;
create policy "notifications_own_all" on public.notifications
for all using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "support_tickets_own_all" on public.support_tickets;
create policy "support_tickets_own_all" on public.support_tickets
for all using (requester_user_id = auth.uid())
with check (requester_user_id = auth.uid());

drop policy if exists "booking_status_history_own_read" on public.booking_status_history;
create policy "booking_status_history_own_read" on public.booking_status_history
for select using (
  exists (
    select 1
    from public.bookings b
    where b.id = booking_id and b.user_id = auth.uid()
  )
);

drop policy if exists "booking_status_history_own_insert" on public.booking_status_history;
create policy "booking_status_history_own_insert" on public.booking_status_history
for insert with check (
  exists (
    select 1
    from public.bookings b
    where b.id = booking_id and b.user_id = auth.uid()
  )
);
