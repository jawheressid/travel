// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentRecordImpl _$$PaymentRecordImplFromJson(Map<String, dynamic> json) =>
    _$PaymentRecordImpl(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      provider: json['provider'] as String,
      providerReference: json['provider_reference'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      rawResponse:
          json['raw_response'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$$PaymentRecordImplToJson(_$PaymentRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'provider': instance.provider,
      'provider_reference': instance.providerReference,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'paid_at': instance.paidAt?.toIso8601String(),
      'raw_response': instance.rawResponse,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.success: 'success',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};
