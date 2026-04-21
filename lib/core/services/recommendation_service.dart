import 'dart:math';

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '../data/curated_content.dart';
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
    List<String> selectedActivities = const <String>[],
  }) {
    final stayLength = max(
      1,
      form.endDate.difference(form.startDate).inDays + 1,
    );

    final selectedRegionIds = form.preferredRegions.isEmpty
        ? catalog.curatedGovernorateIds
        : form.preferredRegions;
    final priceCeiling = max(60, form.budget / stayLength);
    final normalizedActivities = selectedActivities
        .map(_normalize)
        .where((tag) => tag.isNotEmpty)
        .toList(growable: false);
    final candidatePlaces =
        catalog.places
            .where(
              (place) =>
                  place.isActive &&
                  selectedRegionIds.contains(place.governorateId) &&
                  place.priceMin <= priceCeiling,
            )
            .toList()
          ..sort(
            (left, right) => _scorePlace(
              right,
              form,
              normalizedActivities,
            ).compareTo(_scorePlace(left, form, normalizedActivities)),
          );

    final placesByRegion = <String, List<Place>>{
      for (final governorateId in selectedRegionIds)
        governorateId: candidatePlaces
            .where((place) => place.governorateId == governorateId)
            .toList(growable: false),
    };
    final items = <ItineraryItem>[];
    final selected = <Place>[];
    final usedPlaceIds = <String>{};
    double total = 0;

    for (var day = 0; day < stayLength; day++) {
      final regionId = selectedRegionIds[day % selectedRegionIds.length];
      final regionPlaces = placesByRegion[regionId] ?? const <Place>[];
      final slots = ['09:00', '13:00', '17:00'];

      for (var index = 0; index < slots.length; index++) {
        final place = _pickPlaceForSlot(
          regionPlaces: regionPlaces,
          fallbackPlaces: candidatePlaces,
          usedPlaceIds: usedPlaceIds,
          preferredTypes: _preferredTypesForSlot(form.travelTheme, index),
        );
        if (place == null) {
          continue;
        }

        usedPlaceIds.add(place.id);
        selected.add(place);
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
            notes: _buildItemNote(
              place: place,
              governorateName: catalog.governorates
                  .firstWhere((item) => item.id == place.governorateId)
                  .name,
              selectedActivities: normalizedActivities,
              theme: form.travelTheme,
            ),
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

    final selectedGovernorates = selected
        .map(
          (place) => catalog.governorates.firstWhere(
            (governorate) => governorate.id == place.governorateId,
          ),
        )
        .map((governorate) => governorate.name)
        .toSet()
        .toList(growable: false);

    return Itinerary(
      id: _uuid.v4(),
      userId: userId,
      title: _buildItineraryTitle(
        theme: form.travelTheme,
        governorateNames: selectedGovernorates,
      ),
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

  Place? _pickPlaceForSlot({
    required List<Place> regionPlaces,
    required List<Place> fallbackPlaces,
    required Set<String> usedPlaceIds,
    required List<PlaceType> preferredTypes,
  }) {
    final typeMatches = <Place>[
      ..._findCandidates(regionPlaces, preferredTypes, usedPlaceIds),
      ..._findCandidates(fallbackPlaces, preferredTypes, usedPlaceIds),
    ];

    if (typeMatches.isNotEmpty) {
      return typeMatches.first;
    }

    return regionPlaces.firstWhereOrNull(
          (place) => !usedPlaceIds.contains(place.id),
        ) ??
        fallbackPlaces.firstWhereOrNull(
          (place) => !usedPlaceIds.contains(place.id),
        ) ??
        regionPlaces.firstOrNull ??
        fallbackPlaces.firstOrNull;
  }

  Iterable<Place> _findCandidates(
    List<Place> places,
    List<PlaceType> preferredTypes,
    Set<String> usedPlaceIds,
  ) sync* {
    for (final type in preferredTypes) {
      for (final place in places) {
        if (place.type == type && !usedPlaceIds.contains(place.id)) {
          yield place;
        }
      }
    }
  }

  List<PlaceType> _preferredTypesForSlot(TravelTheme theme, int slotIndex) {
    final themedType = switch (theme) {
      TravelTheme.culinary => PlaceType.restaurant,
      TravelTheme.nature => PlaceType.natureSpot,
      TravelTheme.heritage => PlaceType.museum,
      TravelTheme.artisan => PlaceType.artisan,
      TravelTheme.cycling => PlaceType.activity,
      TravelTheme.adventure => PlaceType.activity,
    };

    final defaults = switch (slotIndex) {
      0 => [
        themedType,
        PlaceType.natureSpot,
        PlaceType.museum,
        PlaceType.activity,
        PlaceType.artisan,
        PlaceType.restaurant,
      ],
      1 => [
        PlaceType.activity,
        themedType,
        PlaceType.museum,
        PlaceType.artisan,
        PlaceType.restaurant,
        PlaceType.natureSpot,
      ],
      _ => [
        PlaceType.accommodation,
        PlaceType.restaurant,
        themedType,
        PlaceType.activity,
        PlaceType.transport,
      ],
    };

    return defaults.fold<List<PlaceType>>(<PlaceType>[], (types, type) {
      if (!types.contains(type)) {
        types.add(type);
      }
      return types;
    });
  }

  String _buildItemNote({
    required Place place,
    required String governorateName,
    required List<String> selectedActivities,
    required TravelTheme theme,
  }) {
    final matchedActivities = place.tags
        .where((tag) => selectedActivities.contains(_normalize(tag)))
        .take(2)
        .join(', ');
    if (matchedActivities.isNotEmpty) {
      return '$governorateName - ${place.type.label.toLowerCase()} focused on $matchedActivities.';
    }

    return '$governorateName - selected for ${theme.label.toLowerCase()} travel.';
  }

  String _buildItineraryTitle({
    required TravelTheme theme,
    required List<String> governorateNames,
  }) {
    if (governorateNames.isEmpty) {
      return '${theme.label} route in Tunisia';
    }
    if (governorateNames.length == 1) {
      return '${governorateNames.first} ${theme.label.toLowerCase()} escape';
    }
    return '${theme.label} route across ${governorateNames.join(' + ')}';
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

  double _scorePlace(
    Place place,
    PlannerForm form,
    List<String> selectedActivities,
  ) {
    final priceMidpoint = (place.priceMin + place.priceMax) / 2;
    final budgetPenalty =
        (priceMidpoint - (form.budget / max(1, form.travelersCount))) * 0.02;
    final themeBonus = _matchesTheme(place, form.travelTheme) ? 16 : 0;
    final familyBonus =
        form.travelStyle == TravelStyle.family && place.isFamilyFriendly
        ? 6
        : 0;
    final selectedActivityBonus = selectedActivities.fold<double>(
      0,
      (sum, tag) => sum + (_placeMatchesActivity(place, tag) ? 7 : 0),
    );
    final activityBonus = switch (form.activityLevel) {
      ActivityLevel.low =>
        place.type == PlaceType.museum ||
                place.type == PlaceType.restaurant ||
                place.type == PlaceType.accommodation
            ? 4
            : 0,
      ActivityLevel.medium =>
        place.type == PlaceType.activity || place.type == PlaceType.natureSpot
            ? 3
            : 0,
      ActivityLevel.high =>
        _placeMatchesActivity(place, 'adventure') ||
                _placeMatchesActivity(place, 'horse riding') ||
                _placeMatchesActivity(place, 'cycling')
            ? 6
            : 0,
    };

    return place.recommendationScore +
        place.rating * 6 +
        themeBonus +
        familyBonus +
        selectedActivityBonus +
        (place.isLocalPartner ? 6 : 0) +
        activityBonus -
        budgetPenalty;
  }

  bool _placeMatchesActivity(Place place, String activity) {
    final normalizedActivity = _normalize(activity);
    if (normalizedActivity == 'family friendly') {
      return place.isFamilyFriendly;
    }

    return place.tags.any((tag) => _normalize(tag) == normalizedActivity);
  }

  String _normalize(String value) {
    return value.trim().toLowerCase();
  }
}
