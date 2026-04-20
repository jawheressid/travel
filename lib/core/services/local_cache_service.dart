import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCacheService {
  const LocalCacheService(this._prefs);

  final SharedPreferences _prefs;

  Future<String> loadJson({
    required String cacheKey,
    required String assetPath,
  }) async {
    final cached = _prefs.getString(cacheKey);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final source = await rootBundle.loadString(assetPath);
    await _prefs.setString(cacheKey, source);
    return source;
  }

  Future<void> storeJson(String cacheKey, String payload) {
    return _prefs.setString(cacheKey, payload);
  }
}
