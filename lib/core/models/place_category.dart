import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'place_category.freezed.dart';
part 'place_category.g.dart';

@freezed
class PlaceCategory with _$PlaceCategory {
  const factory PlaceCategory({
    required String id,
    required String slug,
    required String name,
    @JsonKey(name: 'icon_name') required String iconName,
    @JsonKey(name: 'color_hex') required String colorHex,
    @JsonKey(name: 'featured_theme') required TravelTheme featuredTheme,
  }) = _PlaceCategory;

  factory PlaceCategory.fromJson(Map<String, dynamic> json) =>
      _$PlaceCategoryFromJson(json);
}
