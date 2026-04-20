// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppBanner _$AppBannerFromJson(Map<String, dynamic> json) {
  return _AppBanner.fromJson(json);
}

/// @nodoc
mixin _$AppBanner {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_path')
  String get imagePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'cta_label')
  String get ctaLabel => throw _privateConstructorUsedError;

  /// Serializes this AppBanner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppBannerCopyWith<AppBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBannerCopyWith<$Res> {
  factory $AppBannerCopyWith(AppBanner value, $Res Function(AppBanner) then) =
      _$AppBannerCopyWithImpl<$Res, AppBanner>;
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    @JsonKey(name: 'image_path') String imagePath,
    @JsonKey(name: 'cta_label') String ctaLabel,
  });
}

/// @nodoc
class _$AppBannerCopyWithImpl<$Res, $Val extends AppBanner>
    implements $AppBannerCopyWith<$Res> {
  _$AppBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? imagePath = null,
    Object? ctaLabel = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            imagePath: null == imagePath
                ? _value.imagePath
                : imagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            ctaLabel: null == ctaLabel
                ? _value.ctaLabel
                : ctaLabel // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppBannerImplCopyWith<$Res>
    implements $AppBannerCopyWith<$Res> {
  factory _$$AppBannerImplCopyWith(
    _$AppBannerImpl value,
    $Res Function(_$AppBannerImpl) then,
  ) = __$$AppBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    @JsonKey(name: 'image_path') String imagePath,
    @JsonKey(name: 'cta_label') String ctaLabel,
  });
}

/// @nodoc
class __$$AppBannerImplCopyWithImpl<$Res>
    extends _$AppBannerCopyWithImpl<$Res, _$AppBannerImpl>
    implements _$$AppBannerImplCopyWith<$Res> {
  __$$AppBannerImplCopyWithImpl(
    _$AppBannerImpl _value,
    $Res Function(_$AppBannerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? imagePath = null,
    Object? ctaLabel = null,
  }) {
    return _then(
      _$AppBannerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        imagePath: null == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        ctaLabel: null == ctaLabel
            ? _value.ctaLabel
            : ctaLabel // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBannerImpl implements _AppBanner {
  const _$AppBannerImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    @JsonKey(name: 'image_path') required this.imagePath,
    @JsonKey(name: 'cta_label') required this.ctaLabel,
  });

  factory _$AppBannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBannerImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  @JsonKey(name: 'image_path')
  final String imagePath;
  @override
  @JsonKey(name: 'cta_label')
  final String ctaLabel;

  @override
  String toString() {
    return 'AppBanner(id: $id, title: $title, subtitle: $subtitle, imagePath: $imagePath, ctaLabel: $ctaLabel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBannerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.ctaLabel, ctaLabel) ||
                other.ctaLabel == ctaLabel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, subtitle, imagePath, ctaLabel);

  /// Create a copy of AppBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBannerImplCopyWith<_$AppBannerImpl> get copyWith =>
      __$$AppBannerImplCopyWithImpl<_$AppBannerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBannerImplToJson(this);
  }
}

abstract class _AppBanner implements AppBanner {
  const factory _AppBanner({
    required final String id,
    required final String title,
    required final String subtitle,
    @JsonKey(name: 'image_path') required final String imagePath,
    @JsonKey(name: 'cta_label') required final String ctaLabel,
  }) = _$AppBannerImpl;

  factory _AppBanner.fromJson(Map<String, dynamic> json) =
      _$AppBannerImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  @JsonKey(name: 'image_path')
  String get imagePath;
  @override
  @JsonKey(name: 'cta_label')
  String get ctaLabel;

  /// Create a copy of AppBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppBannerImplCopyWith<_$AppBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
