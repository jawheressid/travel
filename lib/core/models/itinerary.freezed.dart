// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itinerary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Itinerary _$ItineraryFromJson(Map<String, dynamic> json) {
  return _Itinerary.fromJson(json);
}

/// @nodoc
mixin _$Itinerary {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  TravelTheme get theme => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'travelers_count')
  int get travelersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_impact_score')
  double get localImpactScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_estimated_cost')
  double get totalEstimatedCost => throw _privateConstructorUsedError;
  List<ItineraryItem> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'supported_partners_count')
  int get supportedPartnersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_budget_percent')
  int get localBudgetPercent => throw _privateConstructorUsedError;
  @JsonKey(name: 'artisans_included')
  int get artisansIncluded => throw _privateConstructorUsedError;

  /// Serializes this Itinerary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Itinerary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItineraryCopyWith<Itinerary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItineraryCopyWith<$Res> {
  factory $ItineraryCopyWith(Itinerary value, $Res Function(Itinerary) then) =
      _$ItineraryCopyWithImpl<$Res, Itinerary>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String? userId,
    String title,
    TravelTheme theme,
    double budget,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
    @JsonKey(name: 'travelers_count') int travelersCount,
    @JsonKey(name: 'local_impact_score') double localImpactScore,
    @JsonKey(name: 'total_estimated_cost') double totalEstimatedCost,
    List<ItineraryItem> items,
    @JsonKey(name: 'supported_partners_count') int supportedPartnersCount,
    @JsonKey(name: 'local_budget_percent') int localBudgetPercent,
    @JsonKey(name: 'artisans_included') int artisansIncluded,
  });
}

/// @nodoc
class _$ItineraryCopyWithImpl<$Res, $Val extends Itinerary>
    implements $ItineraryCopyWith<$Res> {
  _$ItineraryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Itinerary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? title = null,
    Object? theme = null,
    Object? budget = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? travelersCount = null,
    Object? localImpactScore = null,
    Object? totalEstimatedCost = null,
    Object? items = null,
    Object? supportedPartnersCount = null,
    Object? localBudgetPercent = null,
    Object? artisansIncluded = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            theme: null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as TravelTheme,
            budget: null == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as double,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            travelersCount: null == travelersCount
                ? _value.travelersCount
                : travelersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            localImpactScore: null == localImpactScore
                ? _value.localImpactScore
                : localImpactScore // ignore: cast_nullable_to_non_nullable
                      as double,
            totalEstimatedCost: null == totalEstimatedCost
                ? _value.totalEstimatedCost
                : totalEstimatedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ItineraryItem>,
            supportedPartnersCount: null == supportedPartnersCount
                ? _value.supportedPartnersCount
                : supportedPartnersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            localBudgetPercent: null == localBudgetPercent
                ? _value.localBudgetPercent
                : localBudgetPercent // ignore: cast_nullable_to_non_nullable
                      as int,
            artisansIncluded: null == artisansIncluded
                ? _value.artisansIncluded
                : artisansIncluded // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ItineraryImplCopyWith<$Res>
    implements $ItineraryCopyWith<$Res> {
  factory _$$ItineraryImplCopyWith(
    _$ItineraryImpl value,
    $Res Function(_$ItineraryImpl) then,
  ) = __$$ItineraryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String? userId,
    String title,
    TravelTheme theme,
    double budget,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
    @JsonKey(name: 'travelers_count') int travelersCount,
    @JsonKey(name: 'local_impact_score') double localImpactScore,
    @JsonKey(name: 'total_estimated_cost') double totalEstimatedCost,
    List<ItineraryItem> items,
    @JsonKey(name: 'supported_partners_count') int supportedPartnersCount,
    @JsonKey(name: 'local_budget_percent') int localBudgetPercent,
    @JsonKey(name: 'artisans_included') int artisansIncluded,
  });
}

/// @nodoc
class __$$ItineraryImplCopyWithImpl<$Res>
    extends _$ItineraryCopyWithImpl<$Res, _$ItineraryImpl>
    implements _$$ItineraryImplCopyWith<$Res> {
  __$$ItineraryImplCopyWithImpl(
    _$ItineraryImpl _value,
    $Res Function(_$ItineraryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Itinerary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? title = null,
    Object? theme = null,
    Object? budget = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? travelersCount = null,
    Object? localImpactScore = null,
    Object? totalEstimatedCost = null,
    Object? items = null,
    Object? supportedPartnersCount = null,
    Object? localBudgetPercent = null,
    Object? artisansIncluded = null,
  }) {
    return _then(
      _$ItineraryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        theme: null == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as TravelTheme,
        budget: null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as double,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        travelersCount: null == travelersCount
            ? _value.travelersCount
            : travelersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        localImpactScore: null == localImpactScore
            ? _value.localImpactScore
            : localImpactScore // ignore: cast_nullable_to_non_nullable
                  as double,
        totalEstimatedCost: null == totalEstimatedCost
            ? _value.totalEstimatedCost
            : totalEstimatedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ItineraryItem>,
        supportedPartnersCount: null == supportedPartnersCount
            ? _value.supportedPartnersCount
            : supportedPartnersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        localBudgetPercent: null == localBudgetPercent
            ? _value.localBudgetPercent
            : localBudgetPercent // ignore: cast_nullable_to_non_nullable
                  as int,
        artisansIncluded: null == artisansIncluded
            ? _value.artisansIncluded
            : artisansIncluded // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ItineraryImpl implements _Itinerary {
  const _$ItineraryImpl({
    required this.id,
    @JsonKey(name: 'user_id') this.userId,
    required this.title,
    required this.theme,
    required this.budget,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') required this.endDate,
    @JsonKey(name: 'travelers_count') required this.travelersCount,
    @JsonKey(name: 'local_impact_score') required this.localImpactScore,
    @JsonKey(name: 'total_estimated_cost') required this.totalEstimatedCost,
    final List<ItineraryItem> items = const <ItineraryItem>[],
    @JsonKey(name: 'supported_partners_count') this.supportedPartnersCount = 0,
    @JsonKey(name: 'local_budget_percent') this.localBudgetPercent = 0,
    @JsonKey(name: 'artisans_included') this.artisansIncluded = 0,
  }) : _items = items;

  factory _$ItineraryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItineraryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final String title;
  @override
  final TravelTheme theme;
  @override
  final double budget;
  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @override
  @JsonKey(name: 'travelers_count')
  final int travelersCount;
  @override
  @JsonKey(name: 'local_impact_score')
  final double localImpactScore;
  @override
  @JsonKey(name: 'total_estimated_cost')
  final double totalEstimatedCost;
  final List<ItineraryItem> _items;
  @override
  @JsonKey()
  List<ItineraryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'supported_partners_count')
  final int supportedPartnersCount;
  @override
  @JsonKey(name: 'local_budget_percent')
  final int localBudgetPercent;
  @override
  @JsonKey(name: 'artisans_included')
  final int artisansIncluded;

  @override
  String toString() {
    return 'Itinerary(id: $id, userId: $userId, title: $title, theme: $theme, budget: $budget, startDate: $startDate, endDate: $endDate, travelersCount: $travelersCount, localImpactScore: $localImpactScore, totalEstimatedCost: $totalEstimatedCost, items: $items, supportedPartnersCount: $supportedPartnersCount, localBudgetPercent: $localBudgetPercent, artisansIncluded: $artisansIncluded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItineraryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.travelersCount, travelersCount) ||
                other.travelersCount == travelersCount) &&
            (identical(other.localImpactScore, localImpactScore) ||
                other.localImpactScore == localImpactScore) &&
            (identical(other.totalEstimatedCost, totalEstimatedCost) ||
                other.totalEstimatedCost == totalEstimatedCost) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.supportedPartnersCount, supportedPartnersCount) ||
                other.supportedPartnersCount == supportedPartnersCount) &&
            (identical(other.localBudgetPercent, localBudgetPercent) ||
                other.localBudgetPercent == localBudgetPercent) &&
            (identical(other.artisansIncluded, artisansIncluded) ||
                other.artisansIncluded == artisansIncluded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    title,
    theme,
    budget,
    startDate,
    endDate,
    travelersCount,
    localImpactScore,
    totalEstimatedCost,
    const DeepCollectionEquality().hash(_items),
    supportedPartnersCount,
    localBudgetPercent,
    artisansIncluded,
  );

  /// Create a copy of Itinerary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItineraryImplCopyWith<_$ItineraryImpl> get copyWith =>
      __$$ItineraryImplCopyWithImpl<_$ItineraryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItineraryImplToJson(this);
  }
}

abstract class _Itinerary implements Itinerary {
  const factory _Itinerary({
    required final String id,
    @JsonKey(name: 'user_id') final String? userId,
    required final String title,
    required final TravelTheme theme,
    required final double budget,
    @JsonKey(name: 'start_date') required final DateTime startDate,
    @JsonKey(name: 'end_date') required final DateTime endDate,
    @JsonKey(name: 'travelers_count') required final int travelersCount,
    @JsonKey(name: 'local_impact_score') required final double localImpactScore,
    @JsonKey(name: 'total_estimated_cost')
    required final double totalEstimatedCost,
    final List<ItineraryItem> items,
    @JsonKey(name: 'supported_partners_count') final int supportedPartnersCount,
    @JsonKey(name: 'local_budget_percent') final int localBudgetPercent,
    @JsonKey(name: 'artisans_included') final int artisansIncluded,
  }) = _$ItineraryImpl;

  factory _Itinerary.fromJson(Map<String, dynamic> json) =
      _$ItineraryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  String get title;
  @override
  TravelTheme get theme;
  @override
  double get budget;
  @override
  @JsonKey(name: 'start_date')
  DateTime get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime get endDate;
  @override
  @JsonKey(name: 'travelers_count')
  int get travelersCount;
  @override
  @JsonKey(name: 'local_impact_score')
  double get localImpactScore;
  @override
  @JsonKey(name: 'total_estimated_cost')
  double get totalEstimatedCost;
  @override
  List<ItineraryItem> get items;
  @override
  @JsonKey(name: 'supported_partners_count')
  int get supportedPartnersCount;
  @override
  @JsonKey(name: 'local_budget_percent')
  int get localBudgetPercent;
  @override
  @JsonKey(name: 'artisans_included')
  int get artisansIncluded;

  /// Create a copy of Itinerary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItineraryImplCopyWith<_$ItineraryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItineraryItem _$ItineraryItemFromJson(Map<String, dynamic> json) {
  return _ItineraryItem.fromJson(json);
}

/// @nodoc
mixin _$ItineraryItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'itinerary_id')
  String? get itineraryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_id')
  String get placeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_number')
  int get dayNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_type')
  PlaceType get itemType => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_cost')
  double get estimatedCost => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this ItineraryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItineraryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItineraryItemCopyWith<ItineraryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItineraryItemCopyWith<$Res> {
  factory $ItineraryItemCopyWith(
    ItineraryItem value,
    $Res Function(ItineraryItem) then,
  ) = _$ItineraryItemCopyWithImpl<$Res, ItineraryItem>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'itinerary_id') String? itineraryId,
    @JsonKey(name: 'place_id') String placeId,
    @JsonKey(name: 'day_number') int dayNumber,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'item_type') PlaceType itemType,
    @JsonKey(name: 'estimated_cost') double estimatedCost,
    String notes,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$ItineraryItemCopyWithImpl<$Res, $Val extends ItineraryItem>
    implements $ItineraryItemCopyWith<$Res> {
  _$ItineraryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItineraryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itineraryId = freezed,
    Object? placeId = null,
    Object? dayNumber = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? itemType = null,
    Object? estimatedCost = null,
    Object? notes = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            itineraryId: freezed == itineraryId
                ? _value.itineraryId
                : itineraryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeId: null == placeId
                ? _value.placeId
                : placeId // ignore: cast_nullable_to_non_nullable
                      as String,
            dayNumber: null == dayNumber
                ? _value.dayNumber
                : dayNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            itemType: null == itemType
                ? _value.itemType
                : itemType // ignore: cast_nullable_to_non_nullable
                      as PlaceType,
            estimatedCost: null == estimatedCost
                ? _value.estimatedCost
                : estimatedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ItineraryItemImplCopyWith<$Res>
    implements $ItineraryItemCopyWith<$Res> {
  factory _$$ItineraryItemImplCopyWith(
    _$ItineraryItemImpl value,
    $Res Function(_$ItineraryItemImpl) then,
  ) = __$$ItineraryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'itinerary_id') String? itineraryId,
    @JsonKey(name: 'place_id') String placeId,
    @JsonKey(name: 'day_number') int dayNumber,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'item_type') PlaceType itemType,
    @JsonKey(name: 'estimated_cost') double estimatedCost,
    String notes,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$ItineraryItemImplCopyWithImpl<$Res>
    extends _$ItineraryItemCopyWithImpl<$Res, _$ItineraryItemImpl>
    implements _$$ItineraryItemImplCopyWith<$Res> {
  __$$ItineraryItemImplCopyWithImpl(
    _$ItineraryItemImpl _value,
    $Res Function(_$ItineraryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ItineraryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itineraryId = freezed,
    Object? placeId = null,
    Object? dayNumber = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? itemType = null,
    Object? estimatedCost = null,
    Object? notes = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$ItineraryItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        itineraryId: freezed == itineraryId
            ? _value.itineraryId
            : itineraryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeId: null == placeId
            ? _value.placeId
            : placeId // ignore: cast_nullable_to_non_nullable
                  as String,
        dayNumber: null == dayNumber
            ? _value.dayNumber
            : dayNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        itemType: null == itemType
            ? _value.itemType
            : itemType // ignore: cast_nullable_to_non_nullable
                  as PlaceType,
        estimatedCost: null == estimatedCost
            ? _value.estimatedCost
            : estimatedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ItineraryItemImpl implements _ItineraryItem {
  const _$ItineraryItemImpl({
    required this.id,
    @JsonKey(name: 'itinerary_id') this.itineraryId,
    @JsonKey(name: 'place_id') required this.placeId,
    @JsonKey(name: 'day_number') required this.dayNumber,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    @JsonKey(name: 'item_type') required this.itemType,
    @JsonKey(name: 'estimated_cost') required this.estimatedCost,
    required this.notes,
    @JsonKey(name: 'sort_order') required this.sortOrder,
  });

  factory _$ItineraryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItineraryItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'itinerary_id')
  final String? itineraryId;
  @override
  @JsonKey(name: 'place_id')
  final String placeId;
  @override
  @JsonKey(name: 'day_number')
  final int dayNumber;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  @JsonKey(name: 'item_type')
  final PlaceType itemType;
  @override
  @JsonKey(name: 'estimated_cost')
  final double estimatedCost;
  @override
  final String notes;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'ItineraryItem(id: $id, itineraryId: $itineraryId, placeId: $placeId, dayNumber: $dayNumber, startTime: $startTime, endTime: $endTime, itemType: $itemType, estimatedCost: $estimatedCost, notes: $notes, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItineraryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itineraryId, itineraryId) ||
                other.itineraryId == itineraryId) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itineraryId,
    placeId,
    dayNumber,
    startTime,
    endTime,
    itemType,
    estimatedCost,
    notes,
    sortOrder,
  );

  /// Create a copy of ItineraryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItineraryItemImplCopyWith<_$ItineraryItemImpl> get copyWith =>
      __$$ItineraryItemImplCopyWithImpl<_$ItineraryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItineraryItemImplToJson(this);
  }
}

abstract class _ItineraryItem implements ItineraryItem {
  const factory _ItineraryItem({
    required final String id,
    @JsonKey(name: 'itinerary_id') final String? itineraryId,
    @JsonKey(name: 'place_id') required final String placeId,
    @JsonKey(name: 'day_number') required final int dayNumber,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    @JsonKey(name: 'item_type') required final PlaceType itemType,
    @JsonKey(name: 'estimated_cost') required final double estimatedCost,
    required final String notes,
    @JsonKey(name: 'sort_order') required final int sortOrder,
  }) = _$ItineraryItemImpl;

  factory _ItineraryItem.fromJson(Map<String, dynamic> json) =
      _$ItineraryItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'itinerary_id')
  String? get itineraryId;
  @override
  @JsonKey(name: 'place_id')
  String get placeId;
  @override
  @JsonKey(name: 'day_number')
  int get dayNumber;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  @JsonKey(name: 'item_type')
  PlaceType get itemType;
  @override
  @JsonKey(name: 'estimated_cost')
  double get estimatedCost;
  @override
  String get notes;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of ItineraryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItineraryItemImplCopyWith<_$ItineraryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
