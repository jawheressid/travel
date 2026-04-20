// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      status: $enumDecode(_$BookingStatusEnumMap, json['status']),
      totalAmount: (json['total_amount'] as num).toDouble(),
      currency: json['currency'] as String,
      paymentStatus: $enumDecode(
        _$PaymentStatusEnumMap,
        json['payment_status'],
      ),
      bookedFromItineraryId: json['booked_from_itinerary_id'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BookingItem>[],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'total_amount': instance.totalAmount,
      'currency': instance.currency,
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'booked_from_itinerary_id': instance.bookedFromItineraryId,
      'items': instance.items,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$BookingStatusEnumMap = {
  BookingStatus.draft: 'draft',
  BookingStatus.pendingPayment: 'pendingPayment',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.cancelled: 'cancelled',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.success: 'success',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};

_$BookingItemImpl _$$BookingItemImplFromJson(Map<String, dynamic> json) =>
    _$BookingItemImpl(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String?,
      placeId: json['place_id'] as String,
      type: $enumDecode(_$PlaceTypeEnumMap, json['type']),
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      scheduledFor: json['scheduled_for'] as String?,
    );

Map<String, dynamic> _$$BookingItemImplToJson(_$BookingItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'place_id': instance.placeId,
      'type': _$PlaceTypeEnumMap[instance.type]!,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'scheduled_for': instance.scheduledFor,
    };

const _$PlaceTypeEnumMap = {
  PlaceType.accommodation: 'accommodation',
  PlaceType.restaurant: 'restaurant',
  PlaceType.artisan: 'artisan',
  PlaceType.activity: 'activity',
  PlaceType.museum: 'museum',
  PlaceType.transport: 'transport',
  PlaceType.natureSpot: 'natureSpot',
  PlaceType.experience: 'experience',
};
