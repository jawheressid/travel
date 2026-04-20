import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    @JsonKey(name: 'governorate_id') required String governorateId,
    @JsonKey(name: 'category_id') required String categoryId,
    required PlaceType type,
    required String name,
    required String description,
    @JsonKey(name: 'short_description') required String shortDescription,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'gallery_urls')
    @Default(<String>[])
    List<String> galleryUrls,
    required String address,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'price_min') required double priceMin,
    @JsonKey(name: 'price_max') required double priceMax,
    required double rating,
    @JsonKey(name: 'recommendation_score') required double recommendationScore,
    @JsonKey(name: 'is_family_friendly') @Default(false) bool isFamilyFriendly,
    @JsonKey(name: 'is_local_partner') @Default(false) bool isLocalPartner,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @Default(<String>[]) List<String> tags,
    @JsonKey(name: 'opening_hours') String? openingHours,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
