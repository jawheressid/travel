import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    required BookingStatus status,
    @JsonKey(name: 'total_amount') required double totalAmount,
    required String currency,
    @JsonKey(name: 'payment_status') required PaymentStatus paymentStatus,
    @JsonKey(name: 'booked_from_itinerary_id') String? bookedFromItineraryId,
    @Default(<BookingItem>[]) List<BookingItem> items,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}

@freezed
class BookingItem with _$BookingItem {
  const factory BookingItem({
    required String id,
    @JsonKey(name: 'booking_id') String? bookingId,
    @JsonKey(name: 'place_id') required String placeId,
    required PlaceType type,
    required int quantity,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'scheduled_for') String? scheduledFor,
  }) = _BookingItem;

  factory BookingItem.fromJson(Map<String, dynamic> json) =>
      _$BookingItemFromJson(json);
}
