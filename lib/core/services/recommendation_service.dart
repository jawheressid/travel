import 'dart:math';

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '../enums/app_enums.dart';
import '../models/itinerary.dart';
import '../models/planner_form.dart';
import '../models/place.dart';
import '../models/travel_catalog.dart';

class RecommendationService {
  RecommendationService() : _uuid = const Uuid();

  final Uuid _uuid;

  Itinerary generate({
    required PlannerForm form,
    required TravelCatalog catalog,
    required String? userId,
  }) {
    final stayLength = max(
      1,
      form.endDate.difference(form.startDate).inDays + 1,
    );

    final candidatePlaces =
        catalog.places.where((place) {
          final themeMatch =
              place.tags
                  .map((tag) => tag.toLowerCase())
                  .contains(form.travelTheme.label.toLowerCase()) ||
              _matchesTheme(place, form.travelTheme);
          final regionMatch =
              form.preferredRegions.isEmpty ||
              form.preferredRegions.contains(place.governorateId);
          final priceMatch = place.priceMin <= form.budget / stayLength;
          return place.isActive && themeMatch && regionMatch && priceMatch;
        }).toList()..sort(
          (a, b) => _scorePlace(b, form).compareTo(_scorePlace(a, form)),
        );

    final selected = candidatePlaces.take(stayLength * 3).toList();
    final items = <ItineraryItem>[];
    double total = 0;

    for (var day = 0; day < stayLength; day++) {
      final dayPlaces = selected.skip(day * 3).take(3).toList();
      final slots = ['09:00', '13:00', '17:00'];

      for (var index = 0; index < dayPlaces.length; index++) {
        final place = dayPlaces[index];
        final estimatedCost =
            ((place.priceMin + place.priceMax) / 2) * form.travelersCount;
        total += estimatedCost;
        items.add(
          ItineraryItem(
            id: _uuid.v4(),
            placeId: place.id,
            dayNumber: day + 1,
            startTime: slots[index],
            endTime: index == 2 ? '20:00' : slots[index + 1],
            itemType: place.type,
            estimatedCost: estimatedCost,
            notes:
                '${place.name} selected for ${form.travelTheme.label.toLowerCase()} travel.',
            sortOrder: index,
          ),
        );
      }
    }

    final localPartners = selected
        .where((place) => place.isLocalPartner)
        .length;
    final artisansIncluded = selected
        .where((place) => place.type == PlaceType.artisan)
        .length;
    final localBudget = selected
        .where((place) => place.isLocalPartner)
        .map((place) => (place.priceMin + place.priceMax) / 2)
        .sum;
    final localBudgetPercent = total == 0
        ? 0
        : ((localBudget * form.travelersCount / total) * 100).round();

    return Itinerary(
      id: _uuid.v4(),
      userId: userId,
      title: '${form.travelTheme.label} stay in Tunisia',
      theme: form.travelTheme,
      budget: form.budget,
      startDate: form.startDate,
      endDate: form.endDate,
      travelersCount: form.travelersCount,
      localImpactScore: min(
        100,
        50 + (localPartners * 6) + (artisansIncluded * 4),
      ).toDouble(),
      totalEstimatedCost: total,
      items: items,
      supportedPartnersCount: localPartners,
      localBudgetPercent: localBudgetPercent,
      artisansIncluded: artisansIncluded,
    );
  }

  bool _matchesTheme(Place place, TravelTheme theme) {
    return switch (theme) {
      TravelTheme.culinary => place.type == PlaceType.restaurant,
      TravelTheme.nature => place.type == PlaceType.natureSpot,
      TravelTheme.heritage => place.type == PlaceType.museum,
      TravelTheme.artisan => place.type == PlaceType.artisan,
      TravelTheme.cycling => place.tags.contains('Cycling'),
      TravelTheme.adventure => place.type == PlaceType.activity,
    };
  }

  double _scorePlace(Place place, PlannerForm form) {
    final priceMidpoint = (place.priceMin + place.priceMax) / 2;
    final budgetPenalty =
        (priceMidpoint - (form.budget / max(1, form.travelersCount))) * 0.02;
    final familyBonus =
        form.travelStyle == TravelStyle.family && place.isFamilyFriendly
        ? 6
        : 0;
    final activityBonus = switch (form.activityLevel) {
      ActivityLevel.low => place.type == PlaceType.museum ? 3 : 0,
      ActivityLevel.medium => place.type == PlaceType.activity ? 2 : 0,
      ActivityLevel.high => place.tags.contains('Adventure') ? 5 : 0,
    };

    return place.recommendationScore +
        place.rating * 8 +
        familyBonus +
        activityBonus -
        budgetPenalty;
  }
}
