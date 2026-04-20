// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppBannerImpl _$$AppBannerImplFromJson(Map<String, dynamic> json) =>
    _$AppBannerImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imagePath: json['image_path'] as String,
      ctaLabel: json['cta_label'] as String,
    );

Map<String, dynamic> _$$AppBannerImplToJson(_$AppBannerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'image_path': instance.imagePath,
      'cta_label': instance.ctaLabel,
    };
