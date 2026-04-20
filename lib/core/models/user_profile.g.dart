// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      selectedInterests:
          (json['selected_interests'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$TravelThemeEnumMap, e))
              .toList() ??
          const <TravelTheme>[],
      hasCompletedOnboarding:
          json['has_completed_onboarding'] as bool? ?? false,
      isGuest: json['isGuest'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'selected_interests': instance.selectedInterests
          .map((e) => _$TravelThemeEnumMap[e]!)
          .toList(),
      'has_completed_onboarding': instance.hasCompletedOnboarding,
      'isGuest': instance.isGuest,
    };

const _$TravelThemeEnumMap = {
  TravelTheme.culinary: 'culinary',
  TravelTheme.nature: 'nature',
  TravelTheme.heritage: 'heritage',
  TravelTheme.artisan: 'artisan',
  TravelTheme.cycling: 'cycling',
  TravelTheme.adventure: 'adventure',
};
