// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return _Place.fromJson(json);
}

/// @nodoc
mixin _$Place {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'governorate_id')
  String get governorateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  PlaceType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'short_description')
  String get shortDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'gallery_urls')
  List<String> get galleryUrls => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_min')
  double get priceMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_max')
  double get priceMax => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'recommendation_score')
  double get recommendationScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_family_friendly')
  bool get isFamilyFriendly => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_local_partner')
  bool get isLocalPartner => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_hours')
  String? get openingHours => throw _privateConstructorUsedError;

  /// Serializes this Place to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceCopyWith<Place> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCopyWith<$Res> {
  factory $PlaceCopyWith(Place value, $Res Function(Place) then) =
      _$PlaceCopyWithImpl<$Res, Place>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'governorate_id') String governorateId,
    @JsonKey(name: 'category_id') String categoryId,
    PlaceType type,
    String name,
    String description,
    @JsonKey(name: 'short_description') String shortDescription,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'gallery_urls') List<String> galleryUrls,
    String address,
    double latitude,
    double longitude,
    @JsonKey(name: 'price_min') double priceMin,
    @JsonKey(name: 'price_max') double priceMax,
    double rating,
    @JsonKey(name: 'recommendation_score') double recommendationScore,
    @JsonKey(name: 'is_family_friendly') bool isFamilyFriendly,
    @JsonKey(name: 'is_local_partner') bool isLocalPartner,
    @JsonKey(name: 'is_active') bool isActive,
    List<String> tags,
    @JsonKey(name: 'opening_hours') String? openingHours,
  });
}

/// @nodoc
class _$PlaceCopyWithImpl<$Res, $Val extends Place>
    implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? governorateId = null,
    Object? categoryId = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? shortDescription = null,
    Object? imageUrl = null,
    Object? galleryUrls = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? priceMin = null,
    Object? priceMax = null,
    Object? rating = null,
    Object? recommendationScore = null,
    Object? isFamilyFriendly = null,
    Object? isLocalPartner = null,
    Object? isActive = null,
    Object? tags = null,
    Object? openingHours = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            governorateId: null == governorateId
                ? _value.governorateId
                : governorateId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PlaceType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            shortDescription: null == shortDescription
                ? _value.shortDescription
                : shortDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            galleryUrls: null == galleryUrls
                ? _value.galleryUrls
                : galleryUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            priceMin: null == priceMin
                ? _value.priceMin
                : priceMin // ignore: cast_nullable_to_non_nullable
                      as double,
            priceMax: null == priceMax
                ? _value.priceMax
                : priceMax // ignore: cast_nullable_to_non_nullable
                      as double,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            recommendationScore: null == recommendationScore
                ? _value.recommendationScore
                : recommendationScore // ignore: cast_nullable_to_non_nullable
                      as double,
            isFamilyFriendly: null == isFamilyFriendly
                ? _value.isFamilyFriendly
                : isFamilyFriendly // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLocalPartner: null == isLocalPartner
                ? _value.isLocalPartner
                : isLocalPartner // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            openingHours: freezed == openingHours
                ? _value.openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaceImplCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$$PlaceImplCopyWith(
    _$PlaceImpl value,
    $Res Function(_$PlaceImpl) then,
  ) = __$$PlaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'governorate_id') String governorateId,
    @JsonKey(name: 'category_id') String categoryId,
    PlaceType type,
    String name,
    String description,
    @JsonKey(name: 'short_description') String shortDescription,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'gallery_urls') List<String> galleryUrls,
    String address,
    double latitude,
    double longitude,
    @JsonKey(name: 'price_min') double priceMin,
    @JsonKey(name: 'price_max') double priceMax,
    double rating,
    @JsonKey(name: 'recommendation_score') double recommendationScore,
    @JsonKey(name: 'is_family_friendly') bool isFamilyFriendly,
    @JsonKey(name: 'is_local_partner') bool isLocalPartner,
    @JsonKey(name: 'is_active') bool isActive,
    List<String> tags,
    @JsonKey(name: 'opening_hours') String? openingHours,
  });
}

/// @nodoc
class __$$PlaceImplCopyWithImpl<$Res>
    extends _$PlaceCopyWithImpl<$Res, _$PlaceImpl>
    implements _$$PlaceImplCopyWith<$Res> {
  __$$PlaceImplCopyWithImpl(
    _$PlaceImpl _value,
    $Res Function(_$PlaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? governorateId = null,
    Object? categoryId = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? shortDescription = null,
    Object? imageUrl = null,
    Object? galleryUrls = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? priceMin = null,
    Object? priceMax = null,
    Object? rating = null,
    Object? recommendationScore = null,
    Object? isFamilyFriendly = null,
    Object? isLocalPartner = null,
    Object? isActive = null,
    Object? tags = null,
    Object? openingHours = freezed,
  }) {
    return _then(
      _$PlaceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        governorateId: null == governorateId
            ? _value.governorateId
            : governorateId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PlaceType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        shortDescription: null == shortDescription
            ? _value.shortDescription
            : shortDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        galleryUrls: null == galleryUrls
            ? _value._galleryUrls
            : galleryUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        priceMin: null == priceMin
            ? _value.priceMin
            : priceMin // ignore: cast_nullable_to_non_nullable
                  as double,
        priceMax: null == priceMax
            ? _value.priceMax
            : priceMax // ignore: cast_nullable_to_non_nullable
                  as double,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        recommendationScore: null == recommendationScore
            ? _value.recommendationScore
            : recommendationScore // ignore: cast_nullable_to_non_nullable
                  as double,
        isFamilyFriendly: null == isFamilyFriendly
            ? _value.isFamilyFriendly
            : isFamilyFriendly // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLocalPartner: null == isLocalPartner
            ? _value.isLocalPartner
            : isLocalPartner // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        openingHours: freezed == openingHours
            ? _value.openingHours
            : openingHours // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceImpl implements _Place {
  const _$PlaceImpl({
    required this.id,
    @JsonKey(name: 'governorate_id') required this.governorateId,
    @JsonKey(name: 'category_id') required this.categoryId,
    required this.type,
    required this.name,
    required this.description,
    @JsonKey(name: 'short_description') required this.shortDescription,
    @JsonKey(name: 'image_url') required this.imageUrl,
    @JsonKey(name: 'gallery_urls')
    final List<String> galleryUrls = const <String>[],
    required this.address,
    required this.latitude,
    required this.longitude,
    @JsonKey(name: 'price_min') required this.priceMin,
    @JsonKey(name: 'price_max') required this.priceMax,
    required this.rating,
    @JsonKey(name: 'recommendation_score') required this.recommendationScore,
    @JsonKey(name: 'is_family_friendly') this.isFamilyFriendly = false,
    @JsonKey(name: 'is_local_partner') this.isLocalPartner = false,
    @JsonKey(name: 'is_active') this.isActive = true,
    final List<String> tags = const <String>[],
    @JsonKey(name: 'opening_hours') this.openingHours,
  }) : _galleryUrls = galleryUrls,
       _tags = tags;

  factory _$PlaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'governorate_id')
  final String governorateId;
  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  final PlaceType type;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'short_description')
  final String shortDescription;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final List<String> _galleryUrls;
  @override
  @JsonKey(name: 'gallery_urls')
  List<String> get galleryUrls {
    if (_galleryUrls is EqualUnmodifiableListView) return _galleryUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryUrls);
  }

  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey(name: 'price_min')
  final double priceMin;
  @override
  @JsonKey(name: 'price_max')
  final double priceMax;
  @override
  final double rating;
  @override
  @JsonKey(name: 'recommendation_score')
  final double recommendationScore;
  @override
  @JsonKey(name: 'is_family_friendly')
  final bool isFamilyFriendly;
  @override
  @JsonKey(name: 'is_local_partner')
  final bool isLocalPartner;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'opening_hours')
  final String? openingHours;

  @override
  String toString() {
    return 'Place(id: $id, governorateId: $governorateId, categoryId: $categoryId, type: $type, name: $name, description: $description, shortDescription: $shortDescription, imageUrl: $imageUrl, galleryUrls: $galleryUrls, address: $address, latitude: $latitude, longitude: $longitude, priceMin: $priceMin, priceMax: $priceMax, rating: $rating, recommendationScore: $recommendationScore, isFamilyFriendly: $isFamilyFriendly, isLocalPartner: $isLocalPartner, isActive: $isActive, tags: $tags, openingHours: $openingHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.governorateId, governorateId) ||
                other.governorateId == governorateId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._galleryUrls,
              _galleryUrls,
            ) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.priceMin, priceMin) ||
                other.priceMin == priceMin) &&
            (identical(other.priceMax, priceMax) ||
                other.priceMax == priceMax) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.recommendationScore, recommendationScore) ||
                other.recommendationScore == recommendationScore) &&
            (identical(other.isFamilyFriendly, isFamilyFriendly) ||
                other.isFamilyFriendly == isFamilyFriendly) &&
            (identical(other.isLocalPartner, isLocalPartner) ||
                other.isLocalPartner == isLocalPartner) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.openingHours, openingHours) ||
                other.openingHours == openingHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    governorateId,
    categoryId,
    type,
    name,
    description,
    shortDescription,
    imageUrl,
    const DeepCollectionEquality().hash(_galleryUrls),
    address,
    latitude,
    longitude,
    priceMin,
    priceMax,
    rating,
    recommendationScore,
    isFamilyFriendly,
    isLocalPartner,
    isActive,
    const DeepCollectionEquality().hash(_tags),
    openingHours,
  ]);

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      __$$PlaceImplCopyWithImpl<_$PlaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceImplToJson(this);
  }
}

abstract class _Place implements Place {
  const factory _Place({
    required final String id,
    @JsonKey(name: 'governorate_id') required final String governorateId,
    @JsonKey(name: 'category_id') required final String categoryId,
    required final PlaceType type,
    required final String name,
    required final String description,
    @JsonKey(name: 'short_description') required final String shortDescription,
    @JsonKey(name: 'image_url') required final String imageUrl,
    @JsonKey(name: 'gallery_urls') final List<String> galleryUrls,
    required final String address,
    required final double latitude,
    required final double longitude,
    @JsonKey(name: 'price_min') required final double priceMin,
    @JsonKey(name: 'price_max') required final double priceMax,
    required final double rating,
    @JsonKey(name: 'recommendation_score')
    required final double recommendationScore,
    @JsonKey(name: 'is_family_friendly') final bool isFamilyFriendly,
    @JsonKey(name: 'is_local_partner') final bool isLocalPartner,
    @JsonKey(name: 'is_active') final bool isActive,
    final List<String> tags,
    @JsonKey(name: 'opening_hours') final String? openingHours,
  }) = _$PlaceImpl;

  factory _Place.fromJson(Map<String, dynamic> json) = _$PlaceImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'governorate_id')
  String get governorateId;
  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  PlaceType get type;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'short_description')
  String get shortDescription;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'gallery_urls')
  List<String> get galleryUrls;
  @override
  String get address;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(name: 'price_min')
  double get priceMin;
  @override
  @JsonKey(name: 'price_max')
  double get priceMax;
  @override
  double get rating;
  @override
  @JsonKey(name: 'recommendation_score')
  double get recommendationScore;
  @override
  @JsonKey(name: 'is_family_friendly')
  bool get isFamilyFriendly;
  @override
  @JsonKey(name: 'is_local_partner')
  bool get isLocalPartner;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'opening_hours')
  String? get openingHours;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
