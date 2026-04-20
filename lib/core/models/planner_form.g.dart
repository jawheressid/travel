// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlannerFormImpl _$$PlannerFormImplFromJson(Map<String, dynamic> json) =>
    _$PlannerFormImpl(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      travelersCount: (json['travelersCount'] as num).toInt(),
      budget: (json['budget'] as num).toDouble(),
      travelStyle: $enumDecode(_$TravelStyleEnumMap, json['travelStyle']),
      travelTheme: $enumDecode(_$TravelThemeEnumMap, json['travelTheme']),
      preferredRegions:
          (json['preferred_regions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      activityLevel: $enumDecode(
        _$ActivityLevelEnumMap,
        json['activity_level'],
      ),
    );

Map<String, dynamic> _$$PlannerFormImplToJson(_$PlannerFormImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'travelersCount': instance.travelersCount,
      'budget': instance.budget,
      'travelStyle': _$TravelStyleEnumMap[instance.travelStyle]!,
      'travelTheme': _$TravelThemeEnumMap[instance.travelTheme]!,
      'preferred_regions': instance.preferredRegions,
      'activity_level': _$ActivityLevelEnumMap[instance.activityLevel]!,
    };

const _$TravelStyleEnumMap = {
  TravelStyle.solo: 'solo',
  TravelStyle.couple: 'couple',
  TravelStyle.family: 'family',
  TravelStyle.friends: 'friends',
};

const _$TravelThemeEnumMap = {
  TravelTheme.culinary: 'culinary',
  TravelTheme.nature: 'nature',
  TravelTheme.heritage: 'heritage',
  TravelTheme.artisan: 'artisan',
  TravelTheme.cycling: 'cycling',
  TravelTheme.adventure: 'adventure',
};

const _$ActivityLevelEnumMap = {
  ActivityLevel.low: 'low',
  ActivityLevel.medium: 'medium',
  ActivityLevel.high: 'high',
};
