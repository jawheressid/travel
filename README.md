# HKEYETNA

HKEYETNA is a Flutter + Supabase mobile app for curated Tunisia travel. It supports onboarding, email auth, guest browsing, interests selection, themed discovery across all 24 governorates, itinerary planning, favorites, bookings, and a full mock payment flow.

## Stack

- Flutter 3.35+
- Dart 3.9+
- Riverpod
- GoRouter
- Freezed + json_serializable
- Supabase Auth / PostgreSQL / Storage-ready structure
- SharedPreferences local cache fallback

## Included Deliverables

- Full Flutter app in `lib/`
- Supabase schema in [supabase/migrations/20260420190000_init.sql](/C:/Users/jawhe/Downloads/travel/hkeyetna/supabase/migrations/20260420190000_init.sql)
- Starter seed in [supabase/seed.sql](/C:/Users/jawhe/Downloads/travel/hkeyetna/supabase/seed.sql)
- Local starter datasets in `assets/data/`
- Placeholder asset folders in `assets/images/`
- Demo-friendly payment layer with `PaymentGateway` and `MockPaymentGateway`

## Main Product Flow

1. Splash
2. Onboarding
3. Sign in / sign up / guest mode
4. After sign up: direct interests selection
5. Home with banners, categories, featured governorates, local experiences, artisans, and recommended trips
6. Explore all 24 Tunisian governorates
7. Place detail with favorite and booking actions
8. Planner form
9. Generated itinerary with local impact
10. Booking cart
11. Secure mock payment
12. Receipt, bookings history, and profile

## Supabase Setup

1. Create a new Supabase project.
2. Copy `.env.example` to `.env`.
3. Fill:

```env
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

4. Apply the migration:

```bash
supabase db push
```

If you prefer SQL editor, run the migration file manually:

- [supabase/migrations/20260420190000_init.sql](/C:/Users/jawhe/Downloads/travel/hkeyetna/supabase/migrations/20260420190000_init.sql)

5. Seed the content:

```bash
supabase db reset
```

Or paste [supabase/seed.sql](/C:/Users/jawhe/Downloads/travel/hkeyetna/supabase/seed.sql) into the SQL editor after the schema exists.

## Local Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

If Supabase is not configured, the app still works in demo mode with:

- guest browsing
- local cached content
- local itinerary persistence
- local favorites, bookings, and mock payments

## Asset Strategy

Expected folders:

- `assets/images/regions/`
- `assets/images/places/`
- `assets/images/banners/`
- `assets/images/onboarding/`
- `assets/images/mockups/`

The app is already wired to those paths. If an image is missing, it falls back to a gradient placeholder instead of crashing.

See the folder README files for guidance:

- [assets/images/regions/README.md](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/images/regions/README.md)
- [assets/images/places/README.md](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/images/places/README.md)
- [assets/images/banners/README.md](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/images/banners/README.md)
- [assets/images/onboarding/README.md](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/images/onboarding/README.md)
- [assets/images/mockups/README.md](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/images/mockups/README.md)

## Data Files

- [assets/data/governorates.json](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/data/governorates.json)
- [assets/data/places.json](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/data/places.json)
- [assets/data/activities.json](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/data/activities.json)
- [assets/data/artisans.json](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/data/artisans.json)
- [assets/data/categories.json](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/data/categories.json)
- [assets/data/banners.json](/C:/Users/jawhe/Downloads/travel/hkeyetna/assets/data/banners.json)

The starter content includes:

- all 24 governorates
- 264 sample places
- accommodations, restaurants, artisans, activities, museums, transport, and nature spots
- placeholder image paths
- prices in TND
- ratings
- recommendation scores
- local partner flags

## Payment Demo Rules

- `FREELOCAL` applies a 10% mock discount
- `FAILPAY` forces a failed payment
- the payment screen also includes a manual failure toggle for testing
- bookings become confirmed only when payment succeeds

## Validation Done

- `flutter analyze`
- `flutter test`
- `dart run build_runner build --delete-conflicting-outputs`

## Notes

- `flutter build apk --debug` was started, but it exceeded the execution timeout in this environment before completion.
- On Windows, Flutter may ask for Developer Mode if desktop plugin symlinks are required. This project targets Android/iOS first, so mobile work is unaffected once your local Flutter environment is configured.
