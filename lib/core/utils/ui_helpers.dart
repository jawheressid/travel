import 'package:flutter/material.dart';

import '../enums/app_enums.dart';
import '../../theme/app_colors.dart';

Color colorFromHex(String hex) {
  final value = hex.replaceAll('#', '');
  return Color(int.parse('FF$value', radix: 16));
}

Color themeColor(TravelTheme theme) {
  return switch (theme) {
    TravelTheme.culinary => AppColors.terracotta,
    TravelTheme.nature => AppColors.olive,
    TravelTheme.heritage => AppColors.deepBlue,
    TravelTheme.artisan => const Color(0xFF9D6A3E),
    TravelTheme.cycling => const Color(0xFF2B8FA3),
    TravelTheme.adventure => const Color(0xFF8D4FD3),
  };
}

IconData iconFromName(String iconName) {
  return switch (iconName) {
    'restaurant' => Icons.restaurant_rounded,
    'landscape' => Icons.landscape_rounded,
    'museum' => Icons.museum_rounded,
    'directions_bike' => Icons.directions_bike_rounded,
    'hotel' => Icons.hotel_rounded,
    'directions_car' => Icons.directions_car_rounded,
    'storefront' => Icons.storefront_rounded,
    _ => Icons.place_rounded,
  };
}
