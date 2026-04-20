import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/auth_landing_page.dart';
import '../features/auth/presentation/onboarding_page.dart';
import '../features/auth/presentation/sign_in_page.dart';
import '../features/auth/presentation/sign_up_page.dart';
import '../features/auth/presentation/splash_page.dart';
import '../features/bookings/presentation/bookings_page.dart';
import '../features/bookings/presentation/cart_page.dart';
import '../features/favorites/presentation/favorites_page.dart';
import '../features/governorates/presentation/governorate_detail_page.dart';
import '../features/governorates/presentation/governorates_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/interests/presentation/interests_page.dart';
import '../features/itinerary/presentation/itinerary_page.dart';
import '../features/payments/presentation/payment_page.dart';
import '../features/payments/presentation/receipt_page.dart';
import '../features/places/presentation/place_details_page.dart';
import '../features/planner/presentation/planner_page.dart';
import '../features/profile/presentation/profile_page.dart';
import '../shared/layouts/main_navigation_layout.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthLandingPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const SignInPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      GoRoute(
        path: '/interests',
        builder: (context, state) => const InterestsPage(),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            MainNavigationLayout(location: state.uri.path, child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/explore',
            builder: (context, state) => const GovernoratesPage(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            path: '/bookings',
            builder: (context, state) => const BookingsPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/explore/governorate/:slug',
        builder: (context, state) =>
            GovernorateDetailPage(slug: state.pathParameters['slug']!),
      ),
      GoRoute(
        path: '/place/:id',
        builder: (context, state) =>
            PlaceDetailsPage(placeId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/planner',
        builder: (context, state) => const PlannerPage(),
      ),
      GoRoute(
        path: '/itinerary',
        builder: (context, state) => const ItineraryPage(),
      ),
      GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentPage(),
      ),
      GoRoute(
        path: '/receipt/:bookingId',
        builder: (context, state) =>
            ReceiptPage(bookingId: state.pathParameters['bookingId']!),
      ),
    ],
  );
});
