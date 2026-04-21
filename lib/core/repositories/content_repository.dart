import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/curated_content.dart';
import '../models/app_banner.dart';
import '../models/governorate.dart';
import '../models/place.dart';
import '../models/place_category.dart';
import '../models/travel_catalog.dart';
import '../services/local_cache_service.dart';

class ContentRepository {
  const ContentRepository({
    required LocalCacheService cacheService,
    required SupabaseClient? supabaseClient,
  }) : _cacheService = cacheService,
       _supabaseClient = supabaseClient;

  final LocalCacheService _cacheService;
  final SupabaseClient? _supabaseClient;

  Future<TravelCatalog> loadCatalog() async {
    try {
      if (_supabaseClient != null) {
        final catalog = await _loadFromSupabase();
        if (catalog.places.isNotEmpty && catalog.governorates.isNotEmpty) {
          await _cacheService.storeJson(
            'catalog_governorates',
            jsonEncode(
              catalog.governorates.map((item) => item.toJson()).toList(),
            ),
          );
          await _cacheService.storeJson(
            'catalog_categories',
            jsonEncode(
              catalog.categories.map((item) => item.toJson()).toList(),
            ),
          );
          await _cacheService.storeJson(
            'catalog_places',
            jsonEncode(catalog.places.map((item) => item.toJson()).toList()),
          );
          await _cacheService.storeJson(
            'catalog_banners',
            jsonEncode(catalog.banners.map((item) => item.toJson()).toList()),
          );
          return applyCuratedContent(catalog);
        }
      }
    } catch (_) {
      // Local fallback is the primary offline path for the MVP.
    }

    final catalog = TravelCatalog.fromSources(
      governoratesJson: await _cacheService.loadJson(
        cacheKey: 'catalog_governorates',
        assetPath: 'assets/data/governorates.json',
      ),
      categoriesJson: await _cacheService.loadJson(
        cacheKey: 'catalog_categories',
        assetPath: 'assets/data/categories.json',
      ),
      placesJson: await _cacheService.loadJson(
        cacheKey: 'catalog_places',
        assetPath: 'assets/data/places.json',
      ),
      bannersJson: await _cacheService.loadJson(
        cacheKey: 'catalog_banners',
        assetPath: 'assets/data/banners.json',
      ),
    );
    return applyCuratedContent(catalog);
  }

  Future<TravelCatalog> _loadFromSupabase() async {
    final governoratesResponse = await _supabaseClient!
        .from('governorates')
        .select()
        .order('name');
    final categoriesResponse = await _supabaseClient!
        .from('categories')
        .select()
        .order('name');
    final placesResponse = await _supabaseClient!
        .from('places')
        .select()
        .eq('is_active', true)
        .order('recommendation_score', ascending: false);
    final bannersResponse = await _supabaseClient!
        .from('app_banners')
        .select()
        .order('created_at');

    return TravelCatalog(
      governorates: governoratesResponse
          .cast<Map<String, dynamic>>()
          .map(Governorate.fromJson)
          .toList(),
      categories: categoriesResponse
          .cast<Map<String, dynamic>>()
          .map(PlaceCategory.fromJson)
          .toList(),
      places: placesResponse
          .cast<Map<String, dynamic>>()
          .map(Place.fromJson)
          .toList(),
      banners: bannersResponse
          .cast<Map<String, dynamic>>()
          .map(AppBanner.fromJson)
          .toList(),
    );
  }

  List<Place> byGovernorate(String governorateId, List<Place> places) {
    return places
        .where((place) => place.governorateId == governorateId)
        .toList();
  }

  Governorate? findGovernorateBySlug(TravelCatalog catalog, String slug) {
    return catalog.governorates.firstWhereOrNull((item) => item.slug == slug);
  }

  Place? findPlaceById(TravelCatalog catalog, String id) {
    return catalog.places.firstWhereOrNull((item) => item.id == id);
  }

  List<Place> searchPlaces(TravelCatalog catalog, String query) {
    if (query.trim().isEmpty) {
      return catalog.places;
    }

    final normalized = query.toLowerCase();
    return catalog.places.where((place) {
      return place.name.toLowerCase().contains(normalized) ||
          place.tags.any((tag) => tag.toLowerCase().contains(normalized)) ||
          place.shortDescription.toLowerCase().contains(normalized);
    }).toList();
  }
}
