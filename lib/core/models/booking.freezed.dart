// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  BookingStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_from_itinerary_id')
  String? get bookedFromItineraryId => throw _privateConstructorUsedError;
  List<BookingItem> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String? userId,
    BookingStatus status,
    @JsonKey(name: 'total_amount') double totalAmount,
    String currency,
    @JsonKey(name: 'payment_status') PaymentStatus paymentStatus,
    @JsonKey(name: 'booked_from_itinerary_id') String? bookedFromItineraryId,
    List<BookingItem> items,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? status = null,
    Object? totalAmount = null,
    Object? currency = null,
    Object? paymentStatus = null,
    Object? bookedFromItineraryId = freezed,
    Object? items = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BookingStatus,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentStatus: null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
            bookedFromItineraryId: freezed == bookedFromItineraryId
                ? _value.bookedFromItineraryId
                : bookedFromItineraryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<BookingItem>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(
    _$BookingImpl value,
    $Res Function(_$BookingImpl) then,
  ) = __$$BookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String? userId,
    BookingStatus status,
    @JsonKey(name: 'total_amount') double totalAmount,
    String currency,
    @JsonKey(name: 'payment_status') PaymentStatus paymentStatus,
    @JsonKey(name: 'booked_from_itinerary_id') String? bookedFromItineraryId,
    List<BookingItem> items,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(
    _$BookingImpl _value,
    $Res Function(_$BookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? status = null,
    Object? totalAmount = null,
    Object? currency = null,
    Object? paymentStatus = null,
    Object? bookedFromItineraryId = freezed,
    Object? items = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BookingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BookingStatus,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentStatus: null == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        bookedFromItineraryId: freezed == bookedFromItineraryId
            ? _value.bookedFromItineraryId
            : bookedFromItineraryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<BookingItem>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingImpl implements _Booking {
  const _$BookingImpl({
    required this.id,
    @JsonKey(name: 'user_id') this.userId,
    required this.status,
    @JsonKey(name: 'total_amount') required this.totalAmount,
    required this.currency,
    @JsonKey(name: 'payment_status') required this.paymentStatus,
    @JsonKey(name: 'booked_from_itinerary_id') this.bookedFromItineraryId,
    final List<BookingItem> items = const <BookingItem>[],
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _items = items;

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final BookingStatus status;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  final String currency;
  @override
  @JsonKey(name: 'payment_status')
  final PaymentStatus paymentStatus;
  @override
  @JsonKey(name: 'booked_from_itinerary_id')
  final String? bookedFromItineraryId;
  final List<BookingItem> _items;
  @override
  @JsonKey()
  List<BookingItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Booking(id: $id, userId: $userId, status: $status, totalAmount: $totalAmount, currency: $currency, paymentStatus: $paymentStatus, bookedFromItineraryId: $bookedFromItineraryId, items: $items, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.bookedFromItineraryId, bookedFromItineraryId) ||
                other.bookedFromItineraryId == bookedFromItineraryId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    status,
    totalAmount,
    currency,
    paymentStatus,
    bookedFromItineraryId,
    const DeepCollectionEquality().hash(_items),
    createdAt,
  );

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingImplToJson(this);
  }
}

abstract class _Booking implements Booking {
  const factory _Booking({
    required final String id,
    @JsonKey(name: 'user_id') final String? userId,
    required final BookingStatus status,
    @JsonKey(name: 'total_amount') required final double totalAmount,
    required final String currency,
    @JsonKey(name: 'payment_status') required final PaymentStatus paymentStatus,
    @JsonKey(name: 'booked_from_itinerary_id')
    final String? bookedFromItineraryId,
    final List<BookingItem> items,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  BookingStatus get status;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  String get currency;
  @override
  @JsonKey(name: 'payment_status')
  PaymentStatus get paymentStatus;
  @override
  @JsonKey(name: 'booked_from_itinerary_id')
  String? get bookedFromItineraryId;
  @override
  List<BookingItem> get items;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingItem _$BookingItemFromJson(Map<String, dynamic> json) {
  return _BookingItem.fromJson(json);
}

/// @nodoc
mixin _$BookingItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_id')
  String? get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_id')
  String get placeId => throw _privateConstructorUsedError;
  PlaceType get type => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  double get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_for')
  String? get scheduledFor => throw _privateConstructorUsedError;

  /// Serializes this BookingItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingItemCopyWith<BookingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingItemCopyWith<$Res> {
  factory $BookingItemCopyWith(
    BookingItem value,
    $Res Function(BookingItem) then,
  ) = _$BookingItemCopyWithImpl<$Res, BookingItem>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'booking_id') String? bookingId,
    @JsonKey(name: 'place_id') String placeId,
    PlaceType type,
    int quantity,
    @JsonKey(name: 'unit_price') double unitPrice,
    @JsonKey(name: 'scheduled_for') String? scheduledFor,
  });
}

/// @nodoc
class _$BookingItemCopyWithImpl<$Res, $Val extends BookingItem>
    implements $BookingItemCopyWith<$Res> {
  _$BookingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = freezed,
    Object? placeId = null,
    Object? type = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingId: freezed == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeId: null == placeId
                ? _value.placeId
                : placeId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PlaceType,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            scheduledFor: freezed == scheduledFor
                ? _value.scheduledFor
                : scheduledFor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingItemImplCopyWith<$Res>
    implements $BookingItemCopyWith<$Res> {
  factory _$$BookingItemImplCopyWith(
    _$BookingItemImpl value,
    $Res Function(_$BookingItemImpl) then,
  ) = __$$BookingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'booking_id') String? bookingId,
    @JsonKey(name: 'place_id') String placeId,
    PlaceType type,
    int quantity,
    @JsonKey(name: 'unit_price') double unitPrice,
    @JsonKey(name: 'scheduled_for') String? scheduledFor,
  });
}

/// @nodoc
class __$$BookingItemImplCopyWithImpl<$Res>
    extends _$BookingItemCopyWithImpl<$Res, _$BookingItemImpl>
    implements _$$BookingItemImplCopyWith<$Res> {
  __$$BookingItemImplCopyWithImpl(
    _$BookingItemImpl _value,
    $Res Function(_$BookingItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = freezed,
    Object? placeId = null,
    Object? type = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(
      _$BookingItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: freezed == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeId: null == placeId
            ? _value.placeId
            : placeId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PlaceType,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        scheduledFor: freezed == scheduledFor
            ? _value.scheduledFor
            : scheduledFor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingItemImpl implements _BookingItem {
  const _$BookingItemImpl({
    required this.id,
    @JsonKey(name: 'booking_id') this.bookingId,
    @JsonKey(name: 'place_id') required this.placeId,
    required this.type,
    required this.quantity,
    @JsonKey(name: 'unit_price') required this.unitPrice,
    @JsonKey(name: 'scheduled_for') this.scheduledFor,
  });

  factory _$BookingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'booking_id')
  final String? bookingId;
  @override
  @JsonKey(name: 'place_id')
  final String placeId;
  @override
  final PlaceType type;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'unit_price')
  final double unitPrice;
  @override
  @JsonKey(name: 'scheduled_for')
  final String? scheduledFor;

  @override
  String toString() {
    return 'BookingItem(id: $id, bookingId: $bookingId, placeId: $placeId, type: $type, quantity: $quantity, unitPrice: $unitPrice, scheduledFor: $scheduledFor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    bookingId,
    placeId,
    type,
    quantity,
    unitPrice,
    scheduledFor,
  );

  /// Create a copy of BookingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingItemImplCopyWith<_$BookingItemImpl> get copyWith =>
      __$$BookingItemImplCopyWithImpl<_$BookingItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingItemImplToJson(this);
  }
}

abstract class _BookingItem implements BookingItem {
  const factory _BookingItem({
    required final String id,
    @JsonKey(name: 'booking_id') final String? bookingId,
    @JsonKey(name: 'place_id') required final String placeId,
    required final PlaceType type,
    required final int quantity,
    @JsonKey(name: 'unit_price') required final double unitPrice,
    @JsonKey(name: 'scheduled_for') final String? scheduledFor,
  }) = _$BookingItemImpl;

  factory _BookingItem.fromJson(Map<String, dynamic> json) =
      _$BookingItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'booking_id')
  String? get bookingId;
  @override
  @JsonKey(name: 'place_id')
  String get placeId;
  @override
  PlaceType get type;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unit_price')
  double get unitPrice;
  @override
  @JsonKey(name: 'scheduled_for')
  String? get scheduledFor;

  /// Create a copy of BookingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingItemImplCopyWith<_$BookingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
