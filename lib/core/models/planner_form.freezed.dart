// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlannerForm _$PlannerFormFromJson(Map<String, dynamic> json) {
  return _PlannerForm.fromJson(json);
}

/// @nodoc
mixin _$PlannerForm {
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get travelersCount => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  TravelStyle get travelStyle => throw _privateConstructorUsedError;
  TravelTheme get travelTheme => throw _privateConstructorUsedError;
  @JsonKey(name: 'preferred_regions')
  List<String> get preferredRegions => throw _privateConstructorUsedError;
  @JsonKey(name: 'activity_level')
  ActivityLevel get activityLevel => throw _privateConstructorUsedError;

  /// Serializes this PlannerForm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlannerForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlannerFormCopyWith<PlannerForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlannerFormCopyWith<$Res> {
  factory $PlannerFormCopyWith(
    PlannerForm value,
    $Res Function(PlannerForm) then,
  ) = _$PlannerFormCopyWithImpl<$Res, PlannerForm>;
  @useResult
  $Res call({
    DateTime startDate,
    DateTime endDate,
    int travelersCount,
    double budget,
    TravelStyle travelStyle,
    TravelTheme travelTheme,
    @JsonKey(name: 'preferred_regions') List<String> preferredRegions,
    @JsonKey(name: 'activity_level') ActivityLevel activityLevel,
  });
}

/// @nodoc
class _$PlannerFormCopyWithImpl<$Res, $Val extends PlannerForm>
    implements $PlannerFormCopyWith<$Res> {
  _$PlannerFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlannerForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? travelersCount = null,
    Object? budget = null,
    Object? travelStyle = null,
    Object? travelTheme = null,
    Object? preferredRegions = null,
    Object? activityLevel = null,
  }) {
    return _then(
      _value.copyWith(
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
            budget: null == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as double,
            travelStyle: null == travelStyle
                ? _value.travelStyle
                : travelStyle // ignore: cast_nullable_to_non_nullable
                      as TravelStyle,
            travelTheme: null == travelTheme
                ? _value.travelTheme
                : travelTheme // ignore: cast_nullable_to_non_nullable
                      as TravelTheme,
            preferredRegions: null == preferredRegions
                ? _value.preferredRegions
                : preferredRegions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            activityLevel: null == activityLevel
                ? _value.activityLevel
                : activityLevel // ignore: cast_nullable_to_non_nullable
                      as ActivityLevel,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlannerFormImplCopyWith<$Res>
    implements $PlannerFormCopyWith<$Res> {
  factory _$$PlannerFormImplCopyWith(
    _$PlannerFormImpl value,
    $Res Function(_$PlannerFormImpl) then,
  ) = __$$PlannerFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime startDate,
    DateTime endDate,
    int travelersCount,
    double budget,
    TravelStyle travelStyle,
    TravelTheme travelTheme,
    @JsonKey(name: 'preferred_regions') List<String> preferredRegions,
    @JsonKey(name: 'activity_level') ActivityLevel activityLevel,
  });
}

/// @nodoc
class __$$PlannerFormImplCopyWithImpl<$Res>
    extends _$PlannerFormCopyWithImpl<$Res, _$PlannerFormImpl>
    implements _$$PlannerFormImplCopyWith<$Res> {
  __$$PlannerFormImplCopyWithImpl(
    _$PlannerFormImpl _value,
    $Res Function(_$PlannerFormImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlannerForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? travelersCount = null,
    Object? budget = null,
    Object? travelStyle = null,
    Object? travelTheme = null,
    Object? preferredRegions = null,
    Object? activityLevel = null,
  }) {
    return _then(
      _$PlannerFormImpl(
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
        budget: null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as double,
        travelStyle: null == travelStyle
            ? _value.travelStyle
            : travelStyle // ignore: cast_nullable_to_non_nullable
                  as TravelStyle,
        travelTheme: null == travelTheme
            ? _value.travelTheme
            : travelTheme // ignore: cast_nullable_to_non_nullable
                  as TravelTheme,
        preferredRegions: null == preferredRegions
            ? _value._preferredRegions
            : preferredRegions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        activityLevel: null == activityLevel
            ? _value.activityLevel
            : activityLevel // ignore: cast_nullable_to_non_nullable
                  as ActivityLevel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlannerFormImpl implements _PlannerForm {
  const _$PlannerFormImpl({
    required this.startDate,
    required this.endDate,
    required this.travelersCount,
    required this.budget,
    required this.travelStyle,
    required this.travelTheme,
    @JsonKey(name: 'preferred_regions')
    final List<String> preferredRegions = const <String>[],
    @JsonKey(name: 'activity_level') required this.activityLevel,
  }) : _preferredRegions = preferredRegions;

  factory _$PlannerFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlannerFormImplFromJson(json);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int travelersCount;
  @override
  final double budget;
  @override
  final TravelStyle travelStyle;
  @override
  final TravelTheme travelTheme;
  final List<String> _preferredRegions;
  @override
  @JsonKey(name: 'preferred_regions')
  List<String> get preferredRegions {
    if (_preferredRegions is EqualUnmodifiableListView)
      return _preferredRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredRegions);
  }

  @override
  @JsonKey(name: 'activity_level')
  final ActivityLevel activityLevel;

  @override
  String toString() {
    return 'PlannerForm(startDate: $startDate, endDate: $endDate, travelersCount: $travelersCount, budget: $budget, travelStyle: $travelStyle, travelTheme: $travelTheme, preferredRegions: $preferredRegions, activityLevel: $activityLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlannerFormImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.travelersCount, travelersCount) ||
                other.travelersCount == travelersCount) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.travelStyle, travelStyle) ||
                other.travelStyle == travelStyle) &&
            (identical(other.travelTheme, travelTheme) ||
                other.travelTheme == travelTheme) &&
            const DeepCollectionEquality().equals(
              other._preferredRegions,
              _preferredRegions,
            ) &&
            (identical(other.activityLevel, activityLevel) ||
                other.activityLevel == activityLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startDate,
    endDate,
    travelersCount,
    budget,
    travelStyle,
    travelTheme,
    const DeepCollectionEquality().hash(_preferredRegions),
    activityLevel,
  );

  /// Create a copy of PlannerForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlannerFormImplCopyWith<_$PlannerFormImpl> get copyWith =>
      __$$PlannerFormImplCopyWithImpl<_$PlannerFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlannerFormImplToJson(this);
  }
}

abstract class _PlannerForm implements PlannerForm {
  const factory _PlannerForm({
    required final DateTime startDate,
    required final DateTime endDate,
    required final int travelersCount,
    required final double budget,
    required final TravelStyle travelStyle,
    required final TravelTheme travelTheme,
    @JsonKey(name: 'preferred_regions') final List<String> preferredRegions,
    @JsonKey(name: 'activity_level') required final ActivityLevel activityLevel,
  }) = _$PlannerFormImpl;

  factory _PlannerForm.fromJson(Map<String, dynamic> json) =
      _$PlannerFormImpl.fromJson;

  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get travelersCount;
  @override
  double get budget;
  @override
  TravelStyle get travelStyle;
  @override
  TravelTheme get travelTheme;
  @override
  @JsonKey(name: 'preferred_regions')
  List<String> get preferredRegions;
  @override
  @JsonKey(name: 'activity_level')
  ActivityLevel get activityLevel;

  /// Create a copy of PlannerForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlannerFormImplCopyWith<_$PlannerFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
