// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionStateImpl _$$SessionStateImplFromJson(Map<String, dynamic> json) =>
    _$SessionStateImpl(
      hasSeenOnboarding: json['has_seen_onboarding'] as bool? ?? false,
      user: json['user'] == null
          ? null
          : UserProfile.fromJson(json['user'] as Map<String, dynamic>),
      isSupabaseEnabled: json['is_supabase_enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$SessionStateImplToJson(_$SessionStateImpl instance) =>
    <String, dynamic>{
      'has_seen_onboarding': instance.hasSeenOnboarding,
      'user': instance.user,
      'is_supabase_enabled': instance.isSupabaseEnabled,
    };
