// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlaceCategory _$PlaceCategoryFromJson(Map<String, dynamic> json) {
  return _PlaceCategory.fromJson(json);
}

/// @nodoc
mixin _$PlaceCategory {
  String get id => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon_name')
  String get iconName => throw _privateConstructorUsedError;
  @JsonKey(name: 'color_hex')
  String get colorHex => throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_theme')
  TravelTheme get featuredTheme => throw _privateConstructorUsedError;

  /// Serializes this PlaceCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaceCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceCategoryCopyWith<PlaceCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCategoryCopyWith<$Res> {
  factory $PlaceCategoryCopyWith(
    PlaceCategory value,
    $Res Function(PlaceCategory) then,
  ) = _$PlaceCategoryCopyWithImpl<$Res, PlaceCategory>;
  @useResult
  $Res call({
    String id,
    String slug,
    String name,
    @JsonKey(name: 'icon_name') String iconName,
    @JsonKey(name: 'color_hex') String colorHex,
    @JsonKey(name: 'featured_theme') TravelTheme featuredTheme,
  });
}

/// @nodoc
class _$PlaceCategoryCopyWithImpl<$Res, $Val extends PlaceCategory>
    implements $PlaceCategoryCopyWith<$Res> {
  _$PlaceCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaceCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? name = null,
    Object? iconName = null,
    Object? colorHex = null,
    Object? featuredTheme = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            iconName: null == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                      as String,
            colorHex: null == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String,
            featuredTheme: null == featuredTheme
                ? _value.featuredTheme
                : featuredTheme // ignore: cast_nullable_to_non_nullable
                      as TravelTheme,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaceCategoryImplCopyWith<$Res>
    implements $PlaceCategoryCopyWith<$Res> {
  factory _$$PlaceCategoryImplCopyWith(
    _$PlaceCategoryImpl value,
    $Res Function(_$PlaceCategoryImpl) then,
  ) = __$$PlaceCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String slug,
    String name,
    @JsonKey(name: 'icon_name') String iconName,
    @JsonKey(name: 'color_hex') String colorHex,
    @JsonKey(name: 'featured_theme') TravelTheme featuredTheme,
  });
}

/// @nodoc
class __$$PlaceCategoryImplCopyWithImpl<$Res>
    extends _$PlaceCategoryCopyWithImpl<$Res, _$PlaceCategoryImpl>
    implements _$$PlaceCategoryImplCopyWith<$Res> {
  __$$PlaceCategoryImplCopyWithImpl(
    _$PlaceCategoryImpl _value,
    $Res Function(_$PlaceCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaceCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? name = null,
    Object? iconName = null,
    Object? colorHex = null,
    Object? featuredTheme = null,
  }) {
    return _then(
      _$PlaceCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        iconName: null == iconName
            ? _value.iconName
            : iconName // ignore: cast_nullable_to_non_nullable
                  as String,
        colorHex: null == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String,
        featuredTheme: null == featuredTheme
            ? _value.featuredTheme
            : featuredTheme // ignore: cast_nullable_to_non_nullable
                  as TravelTheme,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceCategoryImpl implements _PlaceCategory {
  const _$PlaceCategoryImpl({
    required this.id,
    required this.slug,
    required this.name,
    @JsonKey(name: 'icon_name') required this.iconName,
    @JsonKey(name: 'color_hex') required this.colorHex,
    @JsonKey(name: 'featured_theme') required this.featuredTheme,
  });

  factory _$PlaceCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String slug;
  @override
  final String name;
  @override
  @JsonKey(name: 'icon_name')
  final String iconName;
  @override
  @JsonKey(name: 'color_hex')
  final String colorHex;
  @override
  @JsonKey(name: 'featured_theme')
  final TravelTheme featuredTheme;

  @override
  String toString() {
    return 'PlaceCategory(id: $id, slug: $slug, name: $name, iconName: $iconName, colorHex: $colorHex, featuredTheme: $featuredTheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.featuredTheme, featuredTheme) ||
                other.featuredTheme == featuredTheme));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    slug,
    name,
    iconName,
    colorHex,
    featuredTheme,
  );

  /// Create a copy of PlaceCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceCategoryImplCopyWith<_$PlaceCategoryImpl> get copyWith =>
      __$$PlaceCategoryImplCopyWithImpl<_$PlaceCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceCategoryImplToJson(this);
  }
}

abstract class _PlaceCategory implements PlaceCategory {
  const factory _PlaceCategory({
    required final String id,
    required final String slug,
    required final String name,
    @JsonKey(name: 'icon_name') required final String iconName,
    @JsonKey(name: 'color_hex') required final String colorHex,
    @JsonKey(name: 'featured_theme') required final TravelTheme featuredTheme,
  }) = _$PlaceCategoryImpl;

  factory _PlaceCategory.fromJson(Map<String, dynamic> json) =
      _$PlaceCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get slug;
  @override
  String get name;
  @override
  @JsonKey(name: 'icon_name')
  String get iconName;
  @override
  @JsonKey(name: 'color_hex')
  String get colorHex;
  @override
  @JsonKey(name: 'featured_theme')
  TravelTheme get featuredTheme;

  /// Create a copy of PlaceCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceCategoryImplCopyWith<_$PlaceCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
