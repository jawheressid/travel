// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItineraryImpl _$$ItineraryImplFromJson(Map<String, dynamic> json) =>
    _$ItineraryImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      title: json['title'] as String,
      theme: $enumDecode(_$TravelThemeEnumMap, json['theme']),
      budget: (json['budget'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      travelersCount: (json['travelers_count'] as num).toInt(),
      localImpactScore: (json['local_impact_score'] as num).toDouble(),
      totalEstimatedCost: (json['total_estimated_cost'] as num).toDouble(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ItineraryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ItineraryItem>[],
      supportedPartnersCount:
          (json['supported_partners_count'] as num?)?.toInt() ?? 0,
      localBudgetPercent: (json['local_budget_percent'] as num?)?.toInt() ?? 0,
      artisansIncluded: (json['artisans_included'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ItineraryImplToJson(_$ItineraryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'theme': _$TravelThemeEnumMap[instance.theme]!,
      'budget': instance.budget,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'travelers_count': instance.travelersCount,
      'local_impact_score': instance.localImpactScore,
      'total_estimated_cost': instance.totalEstimatedCost,
      'items': instance.items,
      'supported_partners_count': instance.supportedPartnersCount,
      'local_budget_percent': instance.localBudgetPercent,
      'artisans_included': instance.artisansIncluded,
    };

const _$TravelThemeEnumMap = {
  TravelTheme.culinary: 'culinary',
  TravelTheme.nature: 'nature',
  TravelTheme.heritage: 'heritage',
  TravelTheme.artisan: 'artisan',
  TravelTheme.cycling: 'cycling',
  TravelTheme.adventure: 'adventure',
};

_$ItineraryItemImpl _$$ItineraryItemImplFromJson(Map<String, dynamic> json) =>
    _$ItineraryItemImpl(
      id: json['id'] as String,
      itineraryId: json['itinerary_id'] as String?,
      placeId: json['place_id'] as String,
      dayNumber: (json['day_number'] as num).toInt(),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      itemType: $enumDecode(_$PlaceTypeEnumMap, json['item_type']),
      estimatedCost: (json['estimated_cost'] as num).toDouble(),
      notes: json['notes'] as String,
      sortOrder: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$$ItineraryItemImplToJson(_$ItineraryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itinerary_id': instance.itineraryId,
      'place_id': instance.placeId,
      'day_number': instance.dayNumber,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'item_type': _$PlaceTypeEnumMap[instance.itemType]!,
      'estimated_cost': instance.estimatedCost,
      'notes': instance.notes,
      'sort_order': instance.sortOrder,
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
