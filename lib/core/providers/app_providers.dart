import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../features/payments/domain/mock_payment_gateway.dart';
import '../../features/payments/domain/payment_gateway.dart';
import '../enums/app_enums.dart';
import '../models/booking.dart';
import '../models/itinerary.dart';
import '../models/payment_record.dart';
import '../models/place.dart';
import '../models/session_state.dart';
import '../models/travel_catalog.dart';
import '../repositories/auth_repository.dart';
import '../repositories/content_repository.dart';
import '../repositories/user_data_repository.dart';
import '../services/app_bootstrap.dart';
import '../services/local_cache_service.dart';
import '../services/recommendation_service.dart';

final appBootstrapProvider = Provider<AppBootstrap>(
  (ref) => throw UnimplementedError('Bootstrap override missing'),
);

final environmentProvider = Provider(
  (ref) => ref.watch(appBootstrapProvider).environment,
);
final sharedPreferencesProvider = Provider(
  (ref) => ref.watch(appBootstrapProvider).sharedPreferences,
);
final supabaseClientProvider = Provider(
  (ref) => ref.watch(appBootstrapProvider).supabaseClient,
);

final localCacheServiceProvider = Provider(
  (ref) => LocalCacheService(ref.watch(sharedPreferencesProvider)),
);

final contentRepositoryProvider = Provider(
  (ref) => ContentRepository(
    cacheService: ref.watch(localCacheServiceProvider),
    supabaseClient: ref.watch(supabaseClientProvider),
  ),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    preferences: ref.watch(sharedPreferencesProvider),
    supabaseClient: ref.watch(supabaseClientProvider),
  ),
);

final userDataRepositoryProvider = Provider(
  (ref) => UserDataRepository(
    preferences: ref.watch(sharedPreferencesProvider),
    supabaseClient: ref.watch(supabaseClientProvider),
  ),
);

final recommendationServiceProvider = Provider(
  (ref) => RecommendationService(),
);

final paymentGatewayProvider = Provider<PaymentGateway>(
  (ref) => MockPaymentGateway(),
);

final sessionControllerProvider =
    AsyncNotifierProvider<SessionController, SessionState>(
      SessionController.new,
    );

final catalogProvider = FutureProvider<TravelCatalog>(
  (ref) => ref.watch(contentRepositoryProvider).loadCatalog(),
);

final favoritesControllerProvider =
    AsyncNotifierProvider<FavoritesController, Set<String>>(
      FavoritesController.new,
    );

final itinerariesControllerProvider =
    AsyncNotifierProvider<ItinerariesController, List<Itinerary>>(
      ItinerariesController.new,
    );

final bookingsControllerProvider =
    AsyncNotifierProvider<BookingsController, List<Booking>>(
      BookingsController.new,
    );

final cartControllerProvider =
    NotifierProvider<CartController, List<BookingItem>>(CartController.new);

final cartTotalProvider = Provider<double>((ref) {
  return ref
      .watch(cartControllerProvider)
      .fold<double>(
        0,
        (total, item) => total + (item.unitPrice * item.quantity),
      );
});

final selectedItineraryProvider = StateProvider<Itinerary?>((ref) => null);
final paymentReceiptProvider = StateProvider<PaymentRecord?>((ref) => null);
final checkoutPromoCodeProvider = StateProvider<String>((ref) => '');

class SessionController extends AsyncNotifier<SessionState> {
  static const _authLogTag = '[AuthFlow]';

  bool _isSessionMutationInProgress = false;

  void _debugLog(String message) {
    if (!kDebugMode) {
      return;
    }
    debugPrint('$_authLogTag $message');
  }

  bool _isCycleError(Object error) {
    final type = error.runtimeType.toString().toLowerCase();
    final text = error.toString().toLowerCase();
    return type.contains('circular') ||
        type.contains('cycle') ||
        text.contains('circular') ||
        text.contains('cycle');
  }

  void _invalidateUserScopedProviders() {
    ref.invalidate(favoritesControllerProvider);
    ref.invalidate(itinerariesControllerProvider);
    ref.invalidate(bookingsControllerProvider);
  }

  Future<T> _guardSessionMutation<T>({
    required String action,
    required Future<T> Function() run,
  }) async {
    if (_isSessionMutationInProgress) {
      _debugLog('$action rejected: another auth mutation is already running.');
      throw StateError(
        'Another authentication action is running. Please wait and retry.',
      );
    }

    _isSessionMutationInProgress = true;
    _debugLog('$action started');
    try {
      return await run();
    } catch (error, stackTrace) {
      _debugLog('$action failed with ${error.runtimeType}: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (_isCycleError(error)) {
        _debugLog(
          '$action detected a cyclic provider dependency. '
          'Inspect providers that read sessionControllerProvider during auth writes.',
        );
      }
      rethrow;
    } finally {
      _isSessionMutationInProgress = false;
      _debugLog('$action finished');
    }
  }

  @override
  Future<SessionState> build() {
    _debugLog('restoreSession requested');
    final repository = ref.read(authRepositoryProvider);
    final isEnabled = ref.read(environmentProvider).isSupabaseConfigured;
    return repository.restoreSession(isSupabaseEnabled: isEnabled);
  }

  Future<SessionState> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return _guardSessionMutation(
      action: 'signUp',
      run: () async {
        state = const AsyncLoading();
        final result = await ref
            .read(authRepositoryProvider)
            .signUp(
              fullName: fullName,
              email: email,
              password: password,
              isSupabaseEnabled: ref
                  .read(environmentProvider)
                  .isSupabaseConfigured,
            );
        state = AsyncData(result);
        _invalidateUserScopedProviders();
        return result;
      },
    );
  }

  Future<SessionState> signIn({
    required String email,
    required String password,
  }) async {
    return _guardSessionMutation(
      action: 'signIn',
      run: () async {
        state = const AsyncLoading();
        final result = await ref
            .read(authRepositoryProvider)
            .signIn(
              email: email,
              password: password,
              isSupabaseEnabled: ref
                  .read(environmentProvider)
                  .isSupabaseConfigured,
            );
        state = AsyncData(result);
        _invalidateUserScopedProviders();
        return result;
      },
    );
  }

  Future<SessionState> signInAsGuest() async {
    return _guardSessionMutation(
      action: 'signInAsGuest',
      run: () async {
        state = const AsyncLoading();
        final result = await ref
            .read(authRepositoryProvider)
            .signInAsGuest(
              isSupabaseEnabled: ref
                  .read(environmentProvider)
                  .isSupabaseConfigured,
            );
        state = AsyncData(result);
        _invalidateUserScopedProviders();
        return result;
      },
    );
  }

  Future<void> sendResetPassword(String email) {
    return ref.read(authRepositoryProvider).sendResetPassword(email);
  }

  Future<SessionState> markOnboardingSeen() async {
    final current =
        state.valueOrNull ??
        SessionState(
          isSupabaseEnabled: ref.read(environmentProvider).isSupabaseConfigured,
        );
    final updated = await ref
        .read(authRepositoryProvider)
        .markOnboardingSeen(current);
    state = AsyncData(updated);
    return updated;
  }

  Future<SessionState> updateInterests(List<TravelTheme> interests) async {
    return _guardSessionMutation(
      action: 'updateInterests',
      run: () async {
        final current = state.valueOrNull ?? await future;
        final updated = await ref
            .read(authRepositoryProvider)
            .updateInterests(current, interests);
        state = AsyncData(updated);
        _invalidateUserScopedProviders();
        return updated;
      },
    );
  }

  Future<void> signOut() async {
    await _guardSessionMutation(
      action: 'signOut',
      run: () async {
        final updated = await ref
            .read(authRepositoryProvider)
            .signOut(
              isSupabaseEnabled: ref
                  .read(environmentProvider)
                  .isSupabaseConfigured,
            );
        ref.read(cartControllerProvider.notifier).clear();
        ref.read(paymentReceiptProvider.notifier).state = null;
        ref.read(selectedItineraryProvider.notifier).state = null;
        state = AsyncData(updated);
        _invalidateUserScopedProviders();
      },
    );
  }
}

class FavoritesController extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    final session = await ref.read(sessionControllerProvider.future);
    final user = session.user;
    if (user == null) {
      return {};
    }

    return ref.read(userDataRepositoryProvider).loadFavorites(user.id);
  }

  Future<void> toggle(String placeId) async {
    final session = await ref.read(sessionControllerProvider.future);
    final user = session.user;
    if (user == null) {
      return;
    }

    final current = state.valueOrNull ?? {};
    final updated = await ref
        .read(userDataRepositoryProvider)
        .toggleFavorite(userId: user.id, placeId: placeId, current: current);
    state = AsyncData(updated);
  }
}

class ItinerariesController extends AsyncNotifier<List<Itinerary>> {
  @override
  Future<List<Itinerary>> build() async {
    final session = await ref.read(sessionControllerProvider.future);
    final user = session.user;
    if (user == null) {
      return [];
    }

    return ref.read(userDataRepositoryProvider).loadItineraries(user.id);
  }

  Future<void> save(Itinerary itinerary) async {
    await ref.read(userDataRepositoryProvider).saveItinerary(itinerary);
    final current = state.valueOrNull ?? [];
    state = AsyncData([
      itinerary,
      ...current.where((item) => item.id != itinerary.id),
    ]);
    ref.read(selectedItineraryProvider.notifier).state = itinerary;
  }
}

class CheckoutResult {
  const CheckoutResult({
    required this.booking,
    required this.payment,
    required this.message,
  });

  final Booking booking;
  final PaymentRecord payment;
  final String message;
}

class BookingsController extends AsyncNotifier<List<Booking>> {
  final Uuid _uuid = const Uuid();

  @override
  Future<List<Booking>> build() async {
    final session = await ref.read(sessionControllerProvider.future);
    final user = session.user;
    if (user == null) {
      return [];
    }

    return ref.read(userDataRepositoryProvider).loadBookings(user.id);
  }

  Future<CheckoutResult> checkout({
    required List<BookingItem> cartItems,
    required PaymentMethod method,
    required String currency,
    String? promoCode,
    bool simulateFailure = false,
    String? itineraryId,
  }) async {
    final session = await ref.read(sessionControllerProvider.future);
    final userId = session.user?.id ?? 'guest';
    final total = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.unitPrice * item.quantity),
    );

    final pendingBooking = Booking(
      id: _uuid.v4(),
      userId: userId,
      status: BookingStatus.pendingPayment,
      totalAmount: total,
      currency: currency,
      paymentStatus: PaymentStatus.pending,
      bookedFromItineraryId: itineraryId,
      items: cartItems,
      createdAt: DateTime.now(),
    );

    await ref.read(userDataRepositoryProvider).saveBooking(pendingBooking);

    final paymentResult = await ref
        .read(paymentGatewayProvider)
        .charge(
          PaymentRequest(
            bookingId: pendingBooking.id,
            amount: total,
            currency: currency,
            method: method,
            promoCode: promoCode,
            simulateFailure: simulateFailure,
          ),
        );

    final finalized = pendingBooking.copyWith(
      totalAmount: paymentResult.record.amount,
      status: paymentResult.record.status == PaymentStatus.success
          ? BookingStatus.confirmed
          : BookingStatus.pendingPayment,
      paymentStatus: paymentResult.record.status,
    );

    await ref
        .read(userDataRepositoryProvider)
        .savePayment(userId, paymentResult.record);
    await ref.read(userDataRepositoryProvider).saveBooking(finalized);

    final current = state.valueOrNull ?? [];
    state = AsyncData([
      finalized,
      ...current.where((item) => item.id != finalized.id),
    ]);

    ref.read(paymentReceiptProvider.notifier).state = paymentResult.record;
    if (paymentResult.record.status == PaymentStatus.success) {
      ref.read(cartControllerProvider.notifier).clear();
      ref.read(checkoutPromoCodeProvider.notifier).state = '';
    }

    return CheckoutResult(
      booking: finalized,
      payment: paymentResult.record,
      message: paymentResult.message,
    );
  }
}

class CartController extends Notifier<List<BookingItem>> {
  final Uuid _uuid = const Uuid();

  @override
  List<BookingItem> build() => [];

  void addPlace(Place place) {
    final existing = state.firstWhereOrNull((item) => item.placeId == place.id);
    if (existing == null) {
      state = [
        ...state,
        BookingItem(
          id: _uuid.v4(),
          placeId: place.id,
          type: place.type,
          quantity: 1,
          unitPrice: (place.priceMin + place.priceMax) / 2,
        ),
      ];
      return;
    }

    state = [
      for (final item in state)
        if (item.placeId == place.id)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
    ];
  }

  void removePlace(String placeId) {
    state = state.where((item) => item.placeId != placeId).toList();
  }

  void changeQuantity(String placeId, int quantity) {
    if (quantity <= 0) {
      removePlace(placeId);
      return;
    }

    state = [
      for (final item in state)
        if (item.placeId == placeId)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  void fillFromItinerary(Itinerary itinerary) {
    state = itinerary.items
        .map(
          (item) => BookingItem(
            id: _uuid.v4(),
            placeId: item.placeId,
            type: item.itemType,
            quantity: 1,
            unitPrice: item.estimatedCost,
            scheduledFor: 'Day ${item.dayNumber}',
          ),
        )
        .toList();
  }

  void clear() {
    state = [];
  }
}
