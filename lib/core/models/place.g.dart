// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceImpl _$$PlaceImplFromJson(Map<String, dynamic> json) => _$PlaceImpl(
  id: json['id'] as String,
  governorateId: json['governorate_id'] as String,
  categoryId: json['category_id'] as String,
  type: $enumDecode(_$PlaceTypeEnumMap, json['type']),
  name: json['name'] as String,
  description: json['description'] as String,
  shortDescription: json['short_description'] as String,
  imageUrl: json['image_url'] as String,
  galleryUrls:
      (json['gallery_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  address: json['address'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  priceMin: (json['price_min'] as num).toDouble(),
  priceMax: (json['price_max'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
  recommendationScore: (json['recommendation_score'] as num).toDouble(),
  isFamilyFriendly: json['is_family_friendly'] as bool? ?? false,
  isLocalPartner: json['is_local_partner'] as bool? ?? false,
  isActive: json['is_active'] as bool? ?? true,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  openingHours: json['opening_hours'] as String?,
);

Map<String, dynamic> _$$PlaceImplToJson(_$PlaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'governorate_id': instance.governorateId,
      'category_id': instance.categoryId,
      'type': _$PlaceTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'image_url': instance.imageUrl,
      'gallery_urls': instance.galleryUrls,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'price_min': instance.priceMin,
      'price_max': instance.priceMax,
      'rating': instance.rating,
      'recommendation_score': instance.recommendationScore,
      'is_family_friendly': instance.isFamilyFriendly,
      'is_local_partner': instance.isLocalPartner,
      'is_active': instance.isActive,
      'tags': instance.tags,
      'opening_hours': instance.openingHours,
    };

const _$PlaceTypeEnumMap = {
  PlaceType.accommodation: 'accommodation',
  PlaceType.restaurant: 'restaurant',
  PlaceType.artisan: 'artisan',
  PlaceType.activity: 'activity',
  PlaceType.museum: 'museum',
  PlaceType.transport: 'transport',
  PlaceType.natureSpot: 'natureSpot',
  PlaceType.experience: 'experience',
};
