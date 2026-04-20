// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceCategoryImpl _$$PlaceCategoryImplFromJson(Map<String, dynamic> json) =>
    _$PlaceCategoryImpl(
      id: json['id'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      iconName: json['icon_name'] as String,
      colorHex: json['color_hex'] as String,
      featuredTheme: $enumDecode(_$TravelThemeEnumMap, json['featured_theme']),
    );

Map<String, dynamic> _$$PlaceCategoryImplToJson(_$PlaceCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'icon_name': instance.iconName,
      'color_hex': instance.colorHex,
      'featured_theme': _$TravelThemeEnumMap[instance.featuredTheme]!,
    };

const _$TravelThemeEnumMap = {
  TravelTheme.culinary: 'culinary',
  TravelTheme.nature: 'nature',
  TravelTheme.heritage: 'heritage',
  TravelTheme.artisan: 'artisan',
  TravelTheme.cycling: 'cycling',
  TravelTheme.adventure: 'adventure',
};
