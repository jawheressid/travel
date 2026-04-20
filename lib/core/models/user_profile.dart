import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'selected_interests')
    @Default(<TravelTheme>[])
    List<TravelTheme> selectedInterests,
    @JsonKey(name: 'has_completed_onboarding')
    @Default(false)
    bool hasCompletedOnboarding,
    @Default(false) bool isGuest,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

extension UserProfileDatabaseX on UserProfile {
  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'avatar_url': avatarUrl,
      'selected_interests': selectedInterests.map((item) => item.name).toList(),
      'has_completed_onboarding': hasCompletedOnboarding,
    };
  }
}
