create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  email text not null unique,
  avatar_url text,
  selected_interests text[] not null default '{}',
  has_completed_onboarding boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.governorates (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  description text not null,
  hero_image text not null,
  cover_image text not null,
  latitude double precision not null,
  longitude double precision not null,
  featured_tags text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  icon_name text not null,
  color_hex text not null,
  featured_theme text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.places (
  id uuid primary key default gen_random_uuid(),
  governorate_id uuid not null references public.governorates(id) on delete cascade,
  category_id uuid not null references public.categories(id) on delete restrict,
  type text not null check (
    type in (
      'accommodation',
      'restaurant',
      'artisan',
      'activity',
      'museum',
      'transport',
      'natureSpot',
      'experience'
    )
  ),
  name text not null,
  description text not null,
  short_description text not null,
  image_url text not null,
  gallery_urls jsonb not null default '[]'::jsonb,
  address text not null,
  latitude double precision not null,
  longitude double precision not null,
  price_min numeric(10, 2) not null default 0,
  price_max numeric(10, 2) not null default 0,
  rating numeric(3, 1) not null default 0,
  recommendation_score numeric(5, 2) not null default 0,
  is_family_friendly boolean not null default false,
  is_local_partner boolean not null default false,
  is_active boolean not null default true,
  tags text[] not null default '{}',
  opening_hours text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.accommodations (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null unique references public.places(id) on delete cascade,
  stay_type text not null,
  nightly_price numeric(10, 2) not null default 0,
  max_guests integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.restaurants (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null unique references public.places(id) on delete cascade,
  cuisine_type text not null,
  average_meal_price numeric(10, 2) not null default 0,
  reservation_required boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.artisans (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null unique references public.places(id) on delete cascade,
  craft_type text not null,
  workshop_duration_hours numeric(4, 1),
  demo_price numeric(10, 2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.activities (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null unique references public.places(id) on delete cascade,
  duration_hours numeric(4, 1),
  difficulty_level text,
  equipment_included boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.museums (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null unique references public.places(id) on delete cascade,
  heritage_period text,
  entry_fee numeric(10, 2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.transport_services (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null unique references public.places(id) on delete cascade,
  transport_type text not null,
  capacity integer not null default 1,
  price_per_day numeric(10, 2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.itineraries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  title text not null,
  theme text not null,
  budget numeric(10, 2) not null,
  start_date date not null,
  end_date date not null,
  travelers_count integer not null default 1,
  local_impact_score numeric(5, 2) not null default 0,
  total_estimated_cost numeric(10, 2) not null default 0,
  supported_partners_count integer not null default 0,
  local_budget_percent integer not null default 0,
  artisans_included integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.itinerary_items (
  id uuid primary key default gen_random_uuid(),
  itinerary_id uuid not null references public.itineraries(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  day_number integer not null,
  start_time text not null,
  end_time text not null,
  item_type text not null,
  estimated_cost numeric(10, 2) not null default 0,
  notes text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, place_id)
);

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  status text not null default 'draft',
  total_amount numeric(10, 2) not null default 0,
  currency text not null default 'TND',
  payment_status text not null default 'pending',
  booked_from_itinerary_id uuid references public.itineraries(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.booking_items (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  type text not null,
  quantity integer not null default 1,
  unit_price numeric(10, 2) not null default 0,
  scheduled_for text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.payments (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings(id) on delete cascade,
  provider text not null,
  provider_reference text not null,
  amount numeric(10, 2) not null default 0,
  currency text not null default 'TND',
  status text not null default 'pending',
  paid_at timestamptz,
  raw_response jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  rating numeric(3, 1) not null,
  comment text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.app_banners (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  subtitle text not null,
  image_path text not null,
  cta_label text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, email)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', 'Traveler'),
    coalesce(new.email, '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

create index if not exists idx_places_governorate on public.places(governorate_id);
create index if not exists idx_places_category on public.places(category_id);
create index if not exists idx_places_type on public.places(type);
create index if not exists idx_places_active_score on public.places(is_active, recommendation_score desc);
create index if not exists idx_itineraries_user on public.itineraries(user_id);
create index if not exists idx_itinerary_items_itinerary on public.itinerary_items(itinerary_id, day_number, sort_order);
create index if not exists idx_favorites_user on public.favorites(user_id);
create index if not exists idx_bookings_user on public.bookings(user_id);
create index if not exists idx_booking_items_booking on public.booking_items(booking_id);
create index if not exists idx_payments_booking on public.payments(booking_id);
create index if not exists idx_reviews_place on public.reviews(place_id);

drop trigger if exists trg_profiles_updated_at on public.profiles;
create trigger trg_profiles_updated_at before update on public.profiles
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_governorates_updated_at on public.governorates;
create trigger trg_governorates_updated_at before update on public.governorates
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_categories_updated_at on public.categories;
create trigger trg_categories_updated_at before update on public.categories
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_places_updated_at on public.places;
create trigger trg_places_updated_at before update on public.places
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_accommodations_updated_at on public.accommodations;
create trigger trg_accommodations_updated_at before update on public.accommodations
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_restaurants_updated_at on public.restaurants;
create trigger trg_restaurants_updated_at before update on public.restaurants
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_artisans_updated_at on public.artisans;
create trigger trg_artisans_updated_at before update on public.artisans
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_activities_updated_at on public.activities;
create trigger trg_activities_updated_at before update on public.activities
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_museums_updated_at on public.museums;
create trigger trg_museums_updated_at before update on public.museums
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_transport_services_updated_at on public.transport_services;
create trigger trg_transport_services_updated_at before update on public.transport_services
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_itineraries_updated_at on public.itineraries;
create trigger trg_itineraries_updated_at before update on public.itineraries
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_itinerary_items_updated_at on public.itinerary_items;
create trigger trg_itinerary_items_updated_at before update on public.itinerary_items
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_favorites_updated_at on public.favorites;
create trigger trg_favorites_updated_at before update on public.favorites
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_bookings_updated_at on public.bookings;
create trigger trg_bookings_updated_at before update on public.bookings
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_booking_items_updated_at on public.booking_items;
create trigger trg_booking_items_updated_at before update on public.booking_items
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_payments_updated_at on public.payments;
create trigger trg_payments_updated_at before update on public.payments
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_reviews_updated_at on public.reviews;
create trigger trg_reviews_updated_at before update on public.reviews
for each row execute procedure public.set_updated_at();

drop trigger if exists trg_app_banners_updated_at on public.app_banners;
create trigger trg_app_banners_updated_at before update on public.app_banners
for each row execute procedure public.set_updated_at();

alter table public.profiles enable row level security;
alter table public.governorates enable row level security;
alter table public.categories enable row level security;
alter table public.places enable row level security;
alter table public.accommodations enable row level security;
alter table public.restaurants enable row level security;
alter table public.artisans enable row level security;
alter table public.activities enable row level security;
alter table public.museums enable row level security;
alter table public.transport_services enable row level security;
alter table public.itineraries enable row level security;
alter table public.itinerary_items enable row level security;
alter table public.favorites enable row level security;
alter table public.bookings enable row level security;
alter table public.booking_items enable row level security;
alter table public.payments enable row level security;
alter table public.reviews enable row level security;
alter table public.app_banners enable row level security;

drop policy if exists "profiles_select_own" on public.profiles;
create policy "profiles_select_own" on public.profiles
for select using (auth.uid() = id);

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own" on public.profiles
for insert with check (auth.uid() = id);

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own" on public.profiles
for update using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "public_read_governorates" on public.governorates;
create policy "public_read_governorates" on public.governorates
for select using (true);

drop policy if exists "public_read_categories" on public.categories;
create policy "public_read_categories" on public.categories
for select using (true);

drop policy if exists "public_read_places" on public.places;
create policy "public_read_places" on public.places
for select using (true);

drop policy if exists "public_read_accommodations" on public.accommodations;
create policy "public_read_accommodations" on public.accommodations
for select using (true);

drop policy if exists "public_read_restaurants" on public.restaurants;
create policy "public_read_restaurants" on public.restaurants
for select using (true);

drop policy if exists "public_read_artisans" on public.artisans;
create policy "public_read_artisans" on public.artisans
for select using (true);

drop policy if exists "public_read_activities" on public.activities;
create policy "public_read_activities" on public.activities
for select using (true);

drop policy if exists "public_read_museums" on public.museums;
create policy "public_read_museums" on public.museums
for select using (true);

drop policy if exists "public_read_transport" on public.transport_services;
create policy "public_read_transport" on public.transport_services
for select using (true);

drop policy if exists "public_read_banners" on public.app_banners;
create policy "public_read_banners" on public.app_banners
for select using (true);

drop policy if exists "itineraries_own_all" on public.itineraries;
create policy "itineraries_own_all" on public.itineraries
for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "itinerary_items_own_all" on public.itinerary_items;
create policy "itinerary_items_own_all" on public.itinerary_items
for all using (
  exists (
    select 1 from public.itineraries i
    where i.id = itinerary_id and i.user_id = auth.uid()
  )
) with check (
  exists (
    select 1 from public.itineraries i
    where i.id = itinerary_id and i.user_id = auth.uid()
  )
);

drop policy if exists "favorites_own_all" on public.favorites;
create policy "favorites_own_all" on public.favorites
for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "bookings_own_all" on public.bookings;
create policy "bookings_own_all" on public.bookings
for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "booking_items_own_all" on public.booking_items;
create policy "booking_items_own_all" on public.booking_items
for all using (
  exists (
    select 1 from public.bookings b
    where b.id = booking_id and b.user_id = auth.uid()
  )
) with check (
  exists (
    select 1 from public.bookings b
    where b.id = booking_id and b.user_id = auth.uid()
  )
);

drop policy if exists "payments_own_all" on public.payments;
create policy "payments_own_all" on public.payments
for all using (
  exists (
    select 1 from public.bookings b
    where b.id = booking_id and b.user_id = auth.uid()
  )
) with check (
  exists (
    select 1 from public.bookings b
    where b.id = booking_id and b.user_id = auth.uid()
  )
);

drop policy if exists "reviews_public_read" on public.reviews;
create policy "reviews_public_read" on public.reviews
for select using (true);

drop policy if exists "reviews_own_write" on public.reviews;
create policy "reviews_own_write" on public.reviews
for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
