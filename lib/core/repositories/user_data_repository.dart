import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/booking.dart';
import '../models/itinerary.dart';
import '../models/payment_record.dart';

class UserDataRepository {
  const UserDataRepository({
    required SharedPreferences preferences,
    required SupabaseClient? supabaseClient,
  }) : _preferences = preferences,
       _supabaseClient = supabaseClient;

  final SharedPreferences _preferences;
  final SupabaseClient? _supabaseClient;

  String _favoritesKey(String userId) => 'favorites_$userId';
  String _bookingsKey(String userId) => 'bookings_$userId';
  String _itinerariesKey(String userId) => 'itineraries_$userId';
  String _paymentsKey(String userId) => 'payments_$userId';

  Future<Set<String>> loadFavorites(String userId) async {
    if (_supabaseClient != null && userId != 'guest') {
      final response = await _supabaseClient!
          .from('favorites')
          .select('place_id')
          .eq('user_id', userId);
      return response.map((item) => item['place_id'] as String).toSet();
    }

    return _preferences.getStringList(_favoritesKey(userId))?.toSet() ?? {};
  }

  Future<Set<String>> toggleFavorite({
    required String userId,
    required String placeId,
    required Set<String> current,
  }) async {
    final updated = current.toSet();
    if (updated.contains(placeId)) {
      updated.remove(placeId);
      if (_supabaseClient != null && userId != 'guest') {
        await _supabaseClient!
            .from('favorites')
            .delete()
            .eq('user_id', userId)
            .eq('place_id', placeId);
      }
    } else {
      updated.add(placeId);
      if (_supabaseClient != null && userId != 'guest') {
        await _supabaseClient!.from('favorites').upsert({
          'user_id': userId,
          'place_id': placeId,
        });
      }
    }

    await _preferences.setStringList(_favoritesKey(userId), updated.toList());
    return updated;
  }

  Future<List<Itinerary>> loadItineraries(String userId) async {
    if (_supabaseClient != null && userId != 'guest') {
      final itineraryRows = await _supabaseClient!
          .from('itineraries')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      final itemRows = await _supabaseClient!
          .from('itinerary_items')
          .select()
          .order('day_number');

      final groupedItems = itemRows.cast<Map<String, dynamic>>().groupListsBy(
        (row) => row['itinerary_id'] as String,
      );

      return itineraryRows.cast<Map<String, dynamic>>().map((row) {
        final items = (groupedItems[row['id']] ?? [])
            .map(ItineraryItem.fromJson)
            .toList();
        return Itinerary.fromJson({...row, 'items': items});
      }).toList();
    }

    final raw = _preferences.getString(_itinerariesKey(userId));
    if (raw == null || raw.isEmpty) {
      return [];
    }

    return (jsonDecode(raw) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Itinerary.fromJson)
        .toList();
  }

  Future<void> saveItinerary(Itinerary itinerary) async {
    final userId = itinerary.userId ?? 'guest';
    final list = await loadItineraries(userId);
    final updated = [
      itinerary,
      ...list.where((item) => item.id != itinerary.id),
    ].toList();

    if (_supabaseClient != null && userId != 'guest') {
      await _supabaseClient!.from('itineraries').upsert({
        'id': itinerary.id,
        'user_id': userId,
        'title': itinerary.title,
        'theme': itinerary.theme.name,
        'budget': itinerary.budget,
        'start_date': itinerary.startDate.toIso8601String(),
        'end_date': itinerary.endDate.toIso8601String(),
        'travelers_count': itinerary.travelersCount,
        'local_impact_score': itinerary.localImpactScore,
        'total_estimated_cost': itinerary.totalEstimatedCost,
      });

      await _supabaseClient!
          .from('itinerary_items')
          .delete()
          .eq('itinerary_id', itinerary.id);
      if (itinerary.items.isNotEmpty) {
        await _supabaseClient!
            .from('itinerary_items')
            .insert(
              itinerary.items
                  .map(
                    (item) => item.copyWith(itineraryId: itinerary.id).toJson(),
                  )
                  .toList(),
            );
      }
    }

    await _preferences.setString(
      _itinerariesKey(userId),
      jsonEncode(updated.map((item) => item.toJson()).toList()),
    );
  }

  Future<List<Booking>> loadBookings(String userId) async {
    if (_supabaseClient != null && userId != 'guest') {
      final bookingRows = await _supabaseClient!
          .from('bookings')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      final bookingIds = bookingRows
          .map((item) => item['id'] as String)
          .toList();
      final itemRows = bookingIds.isEmpty
          ? <dynamic>[]
          : await _supabaseClient!
                .from('booking_items')
                .select()
                .filter('booking_id', 'in', '(${bookingIds.join(',')})');
      final groupedItems = itemRows.cast<Map<String, dynamic>>().groupListsBy(
        (row) => row['booking_id'] as String,
      );

      return bookingRows.cast<Map<String, dynamic>>().map((row) {
        final items = (groupedItems[row['id']] ?? [])
            .map(BookingItem.fromJson)
            .toList();
        return Booking.fromJson({...row, 'items': items});
      }).toList();
    }

    final raw = _preferences.getString(_bookingsKey(userId));
    if (raw == null || raw.isEmpty) {
      return [];
    }

    return (jsonDecode(raw) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Booking.fromJson)
        .toList();
  }

  Future<void> saveBooking(Booking booking) async {
    final userId = booking.userId ?? 'guest';
    final bookings = await loadBookings(userId);
    final updated = [
      booking,
      ...bookings.where((item) => item.id != booking.id),
    ].toList();

    if (_supabaseClient != null && userId != 'guest') {
      await _supabaseClient!.from('bookings').upsert({
        'id': booking.id,
        'user_id': userId,
        'status': booking.status.name,
        'total_amount': booking.totalAmount,
        'currency': booking.currency,
        'payment_status': booking.paymentStatus.name,
        'booked_from_itinerary_id': booking.bookedFromItineraryId,
      });
      await _supabaseClient!
          .from('booking_items')
          .delete()
          .eq('booking_id', booking.id);
      if (booking.items.isNotEmpty) {
        await _supabaseClient!
            .from('booking_items')
            .insert(
              booking.items
                  .map((item) => item.copyWith(bookingId: booking.id).toJson())
                  .toList(),
            );
      }
    }

    await _preferences.setString(
      _bookingsKey(userId),
      jsonEncode(updated.map((item) => item.toJson()).toList()),
    );
  }

  Future<List<PaymentRecord>> loadPayments(String userId) async {
    final raw = _preferences.getString(_paymentsKey(userId));
    if (raw == null || raw.isEmpty) {
      return [];
    }

    return (jsonDecode(raw) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PaymentRecord.fromJson)
        .toList();
  }

  Future<void> savePayment(String userId, PaymentRecord payment) async {
    final payments = await loadPayments(userId);
    final updated = [
      payment,
      ...payments.where((item) => item.id != payment.id),
    ].toList();

    if (_supabaseClient != null && userId != 'guest') {
      await _supabaseClient!.from('payments').upsert(payment.toJson());
    }

    await _preferences.setString(
      _paymentsKey(userId),
      jsonEncode(updated.map((item) => item.toJson()).toList()),
    );
  }
}
