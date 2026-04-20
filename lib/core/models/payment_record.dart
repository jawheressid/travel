import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'payment_record.freezed.dart';
part 'payment_record.g.dart';

@freezed
class PaymentRecord with _$PaymentRecord {
  const factory PaymentRecord({
    required String id,
    @JsonKey(name: 'booking_id') required String bookingId,
    required String provider,
    @JsonKey(name: 'provider_reference') required String providerReference,
    required double amount,
    required String currency,
    required PaymentStatus status,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
    @JsonKey(name: 'raw_response')
    @Default(<String, dynamic>{})
    Map<String, dynamic> rawResponse,
  }) = _PaymentRecord;

  factory PaymentRecord.fromJson(Map<String, dynamic> json) =>
      _$PaymentRecordFromJson(json);
}
