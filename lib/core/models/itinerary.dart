import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'itinerary.freezed.dart';
part 'itinerary.g.dart';

@freezed
class Itinerary with _$Itinerary {
  const factory Itinerary({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    required String title,
    required TravelTheme theme,
    required double budget,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    @JsonKey(name: 'travelers_count') required int travelersCount,
    @JsonKey(name: 'local_impact_score') required double localImpactScore,
    @JsonKey(name: 'total_estimated_cost') required double totalEstimatedCost,
    @Default(<ItineraryItem>[]) List<ItineraryItem> items,
    @JsonKey(name: 'supported_partners_count')
    @Default(0)
    int supportedPartnersCount,
    @JsonKey(name: 'local_budget_percent') @Default(0) int localBudgetPercent,
    @JsonKey(name: 'artisans_included') @Default(0) int artisansIncluded,
  }) = _Itinerary;

  factory Itinerary.fromJson(Map<String, dynamic> json) =>
      _$ItineraryFromJson(json);
}

@freezed
class ItineraryItem with _$ItineraryItem {
  const factory ItineraryItem({
    required String id,
    @JsonKey(name: 'itinerary_id') String? itineraryId,
    @JsonKey(name: 'place_id') required String placeId,
    @JsonKey(name: 'day_number') required int dayNumber,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'item_type') required PlaceType itemType,
    @JsonKey(name: 'estimated_cost') required double estimatedCost,
    required String notes,
    @JsonKey(name: 'sort_order') required int sortOrder,
  }) = _ItineraryItem;

  factory ItineraryItem.fromJson(Map<String, dynamic> json) =>
      _$ItineraryItemFromJson(json);
}
