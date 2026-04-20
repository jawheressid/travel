// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GovernorateImpl _$$GovernorateImplFromJson(Map<String, dynamic> json) =>
    _$GovernorateImpl(
      id: json['id'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      heroImage: json['hero_image'] as String,
      coverImage: json['cover_image'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      featuredTags:
          (json['featured_tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$GovernorateImplToJson(_$GovernorateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'description': instance.description,
      'hero_image': instance.heroImage,
      'cover_image': instance.coverImage,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'featured_tags': instance.featuredTags,
    };
