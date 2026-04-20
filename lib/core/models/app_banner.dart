import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_banner.freezed.dart';
part 'app_banner.g.dart';

@freezed
class AppBanner with _$AppBanner {
  const factory AppBanner({
    required String id,
    required String title,
    required String subtitle,
    @JsonKey(name: 'image_path') required String imagePath,
    @JsonKey(name: 'cta_label') required String ctaLabel,
  }) = _AppBanner;

  factory AppBanner.fromJson(Map<String, dynamic> json) =>
      _$AppBannerFromJson(json);
}
