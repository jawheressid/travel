import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_profile.dart';

part 'session_state.freezed.dart';
part 'session_state.g.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    @JsonKey(name: 'has_seen_onboarding')
    @Default(false)
    bool hasSeenOnboarding,
    UserProfile? user,
    @JsonKey(name: 'is_supabase_enabled')
    @Default(false)
    bool isSupabaseEnabled,
  }) = _SessionState;

  factory SessionState.fromJson(Map<String, dynamic> json) =>
      _$SessionStateFromJson(json);
}
