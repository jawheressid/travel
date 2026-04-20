// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaymentRecord _$PaymentRecordFromJson(Map<String, dynamic> json) {
  return _PaymentRecord.fromJson(json);
}

/// @nodoc
mixin _$PaymentRecord {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_id')
  String get bookingId => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_reference')
  String get providerReference => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_at')
  DateTime? get paidAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'raw_response')
  Map<String, dynamic> get rawResponse => throw _privateConstructorUsedError;

  /// Serializes this PaymentRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentRecordCopyWith<PaymentRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentRecordCopyWith<$Res> {
  factory $PaymentRecordCopyWith(
    PaymentRecord value,
    $Res Function(PaymentRecord) then,
  ) = _$PaymentRecordCopyWithImpl<$Res, PaymentRecord>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'booking_id') String bookingId,
    String provider,
    @JsonKey(name: 'provider_reference') String providerReference,
    double amount,
    String currency,
    PaymentStatus status,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
    @JsonKey(name: 'raw_response') Map<String, dynamic> rawResponse,
  });
}

/// @nodoc
class _$PaymentRecordCopyWithImpl<$Res, $Val extends PaymentRecord>
    implements $PaymentRecordCopyWith<$Res> {
  _$PaymentRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? provider = null,
    Object? providerReference = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? paidAt = freezed,
    Object? rawResponse = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingId: null == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as String,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String,
            providerReference: null == providerReference
                ? _value.providerReference
                : providerReference // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
            paidAt: freezed == paidAt
                ? _value.paidAt
                : paidAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            rawResponse: null == rawResponse
                ? _value.rawResponse
                : rawResponse // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentRecordImplCopyWith<$Res>
    implements $PaymentRecordCopyWith<$Res> {
  factory _$$PaymentRecordImplCopyWith(
    _$PaymentRecordImpl value,
    $Res Function(_$PaymentRecordImpl) then,
  ) = __$$PaymentRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'booking_id') String bookingId,
    String provider,
    @JsonKey(name: 'provider_reference') String providerReference,
    double amount,
    String currency,
    PaymentStatus status,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
    @JsonKey(name: 'raw_response') Map<String, dynamic> rawResponse,
  });
}

/// @nodoc
class __$$PaymentRecordImplCopyWithImpl<$Res>
    extends _$PaymentRecordCopyWithImpl<$Res, _$PaymentRecordImpl>
    implements _$$PaymentRecordImplCopyWith<$Res> {
  __$$PaymentRecordImplCopyWithImpl(
    _$PaymentRecordImpl _value,
    $Res Function(_$PaymentRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? provider = null,
    Object? providerReference = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? paidAt = freezed,
    Object? rawResponse = null,
  }) {
    return _then(
      _$PaymentRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
        providerReference: null == providerReference
            ? _value.providerReference
            : providerReference // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        paidAt: freezed == paidAt
            ? _value.paidAt
            : paidAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rawResponse: null == rawResponse
            ? _value._rawResponse
            : rawResponse // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentRecordImpl implements _PaymentRecord {
  const _$PaymentRecordImpl({
    required this.id,
    @JsonKey(name: 'booking_id') required this.bookingId,
    required this.provider,
    @JsonKey(name: 'provider_reference') required this.providerReference,
    required this.amount,
    required this.currency,
    required this.status,
    @JsonKey(name: 'paid_at') this.paidAt,
    @JsonKey(name: 'raw_response')
    final Map<String, dynamic> rawResponse = const <String, dynamic>{},
  }) : _rawResponse = rawResponse;

  factory _$PaymentRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentRecordImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'booking_id')
  final String bookingId;
  @override
  final String provider;
  @override
  @JsonKey(name: 'provider_reference')
  final String providerReference;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final PaymentStatus status;
  @override
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;
  final Map<String, dynamic> _rawResponse;
  @override
  @JsonKey(name: 'raw_response')
  Map<String, dynamic> get rawResponse {
    if (_rawResponse is EqualUnmodifiableMapView) return _rawResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rawResponse);
  }

  @override
  String toString() {
    return 'PaymentRecord(id: $id, bookingId: $bookingId, provider: $provider, providerReference: $providerReference, amount: $amount, currency: $currency, status: $status, paidAt: $paidAt, rawResponse: $rawResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.providerReference, providerReference) ||
                other.providerReference == providerReference) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            const DeepCollectionEquality().equals(
              other._rawResponse,
              _rawResponse,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    bookingId,
    provider,
    providerReference,
    amount,
    currency,
    status,
    paidAt,
    const DeepCollectionEquality().hash(_rawResponse),
  );

  /// Create a copy of PaymentRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentRecordImplCopyWith<_$PaymentRecordImpl> get copyWith =>
      __$$PaymentRecordImplCopyWithImpl<_$PaymentRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentRecordImplToJson(this);
  }
}

abstract class _PaymentRecord implements PaymentRecord {
  const factory _PaymentRecord({
    required final String id,
    @JsonKey(name: 'booking_id') required final String bookingId,
    required final String provider,
    @JsonKey(name: 'provider_reference')
    required final String providerReference,
    required final double amount,
    required final String currency,
    required final PaymentStatus status,
    @JsonKey(name: 'paid_at') final DateTime? paidAt,
    @JsonKey(name: 'raw_response') final Map<String, dynamic> rawResponse,
  }) = _$PaymentRecordImpl;

  factory _PaymentRecord.fromJson(Map<String, dynamic> json) =
      _$PaymentRecordImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'booking_id')
  String get bookingId;
  @override
  String get provider;
  @override
  @JsonKey(name: 'provider_reference')
  String get providerReference;
  @override
  double get amount;
  @override
  String get currency;
  @override
  PaymentStatus get status;
  @override
  @JsonKey(name: 'paid_at')
  DateTime? get paidAt;
  @override
  @JsonKey(name: 'raw_response')
  Map<String, dynamic> get rawResponse;

  /// Create a copy of PaymentRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentRecordImplCopyWith<_$PaymentRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
