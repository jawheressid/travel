import 'package:freezed_annotation/freezed_annotation.dart';

part 'governorate.freezed.dart';
part 'governorate.g.dart';

@freezed
class Governorate with _$Governorate {
  const factory Governorate({
    required String id,
    required String slug,
    required String name,
    required String description,
    @JsonKey(name: 'hero_image') required String heroImage,
    @JsonKey(name: 'cover_image') required String coverImage,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'featured_tags')
    @Default(<String>[])
    List<String> featuredTags,
  }) = _Governorate;

  factory Governorate.fromJson(Map<String, dynamic> json) =>
      _$GovernorateFromJson(json);
}
