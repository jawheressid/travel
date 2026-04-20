import 'dart:convert';

import 'app_banner.dart';
import 'governorate.dart';
import 'place.dart';
import 'place_category.dart';

class TravelCatalog {
  const TravelCatalog({
    required this.governorates,
    required this.categories,
    required this.places,
    required this.banners,
  });

  factory TravelCatalog.fromSources({
    required String governoratesJson,
    required String categoriesJson,
    required String placesJson,
    required String bannersJson,
  }) {
    final governorates = (jsonDecode(governoratesJson) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Governorate.fromJson)
        .toList();
    final categories = (jsonDecode(categoriesJson) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PlaceCategory.fromJson)
        .toList();
    final places = (jsonDecode(placesJson) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Place.fromJson)
        .toList();
    final banners = (jsonDecode(bannersJson) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AppBanner.fromJson)
        .toList();

    return TravelCatalog(
      governorates: governorates,
      categories: categories,
      places: places,
      banners: banners,
    );
  }

  final List<Governorate> governorates;
  final List<PlaceCategory> categories;
  final List<Place> places;
  final List<AppBanner> banners;
}
