import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../enums/app_enums.dart';
import '../models/session_state.dart';
import '../models/user_profile.dart';

class AuthRepository {
  AuthRepository({
    required SharedPreferences preferences,
    required SupabaseClient? supabaseClient,
  }) : _preferences = preferences,
       _supabaseClient = supabaseClient;

  static const _sessionKey = 'auth_session_state';
  static const _demoPasswordKey = 'auth_demo_password';

  final SharedPreferences _preferences;
  final SupabaseClient? _supabaseClient;
  final Uuid _uuid = const Uuid();

  Future<SessionState> restoreSession({required bool isSupabaseEnabled}) async {
    if (_supabaseClient != null && _supabaseClient!.auth.currentUser != null) {
      final user = _supabaseClient!.auth.currentUser!;
      final profileData = await _supabaseClient!
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      final hasSeenOnboarding =
          _preferences.getBool('has_seen_onboarding') ?? false;

      return SessionState(
        hasSeenOnboarding: hasSeenOnboarding,
        isSupabaseEnabled: isSupabaseEnabled,
        user: profileData == null
            ? UserProfile(
                id: user.id,
                fullName:
                    user.userMetadata?['full_name']?.toString() ?? 'Traveler',
                email: user.email ?? '',
              )
            : UserProfile.fromJson(profileData),
      );
    }

    final raw = _preferences.getString(_sessionKey);
    if (raw == null || raw.isEmpty) {
      return SessionState(
        hasSeenOnboarding: _preferences.getBool('has_seen_onboarding') ?? false,
        isSupabaseEnabled: isSupabaseEnabled,
      );
    }

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final user = decoded['user'];
    if (user is Map<String, dynamic>) {
      user['full_name'] ??= user['fullName'];
    } else if (user is Map) {
      final normalized = Map<String, dynamic>.from(user);
      normalized['full_name'] ??= normalized['fullName'];
      decoded['user'] = normalized;
    }

    return SessionState.fromJson(
      decoded,
    ).copyWith(isSupabaseEnabled: isSupabaseEnabled);
  }

  Future<SessionState> signUp({
    required String fullName,
    required String email,
    required String password,
    required bool isSupabaseEnabled,
  }) async {
    if (_supabaseClient != null) {
      final response = await _supabaseClient!.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
      final userId = response.user?.id ?? _uuid.v4();

      final profile = UserProfile(id: userId, fullName: fullName, email: email);

      final state = SessionState(
        hasSeenOnboarding: true,
        isSupabaseEnabled: isSupabaseEnabled,
        user: profile,
      );
      await _persistSession(state);
      return state;
    }

    final state = SessionState(
      hasSeenOnboarding: true,
      isSupabaseEnabled: isSupabaseEnabled,
      user: UserProfile(id: _uuid.v4(), fullName: fullName, email: email),
    );

    await _preferences.setString(_demoPasswordKey, password);
    await _persistSession(state);
    return state;
  }

  Future<SessionState> signIn({
    required String email,
    required String password,
    required bool isSupabaseEnabled,
  }) async {
    if (_supabaseClient != null) {
      await _supabaseClient!.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return restoreSession(isSupabaseEnabled: isSupabaseEnabled);
    }

    final raw = _preferences.getString(_sessionKey);
    final savedPassword = _preferences.getString(_demoPasswordKey) ?? '';
    if (raw == null || savedPassword != password) {
      throw const AuthException('Invalid credentials for demo mode.');
    }

    final state = SessionState.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    ).copyWith(isSupabaseEnabled: isSupabaseEnabled);
    await _persistSession(state);
    return state;
  }

  Future<void> sendResetPassword(String email) async {
    if (_supabaseClient != null) {
      await _supabaseClient!.auth.resetPasswordForEmail(email);
      return;
    }
  }

  Future<SessionState> signInAsGuest({required bool isSupabaseEnabled}) async {
    final state = SessionState(
      hasSeenOnboarding: true,
      isSupabaseEnabled: isSupabaseEnabled,
      user: UserProfile(
        id: 'guest',
        fullName: 'Guest Explorer',
        email: 'guest@hkeyetna.app',
        isGuest: true,
        hasCompletedOnboarding: true,
      ),
    );
    await _persistSession(state);
    return state;
  }

  Future<SessionState> updateInterests(
    SessionState state,
    List<TravelTheme> interests,
  ) async {
    final user = state.user;
    if (user == null) {
      return state;
    }

    final updatedUser = user.copyWith(
      selectedInterests: interests,
      hasCompletedOnboarding: true,
    );
    final updatedState = state.copyWith(
      user: updatedUser,
      hasSeenOnboarding: true,
    );

    if (_supabaseClient != null &&
        !updatedUser.isGuest &&
        _supabaseClient!.auth.currentUser != null) {
      await _supabaseClient!
          .from('profiles')
          .upsert(updatedUser.toDatabaseJson());
    }

    await _persistSession(updatedState);
    return updatedState;
  }

  Future<SessionState> markOnboardingSeen(SessionState state) async {
    final updated = state.copyWith(hasSeenOnboarding: true);
    await _preferences.setBool('has_seen_onboarding', true);
    await _persistSession(updated);
    return updated;
  }

  Future<SessionState> signOut({required bool isSupabaseEnabled}) async {
    if (_supabaseClient != null) {
      await _supabaseClient!.auth.signOut();
    }

    await _preferences.remove(_sessionKey);
    return SessionState(
      hasSeenOnboarding: _preferences.getBool('has_seen_onboarding') ?? true,
      isSupabaseEnabled: isSupabaseEnabled,
    );
  }

  Future<void> _persistSession(SessionState state) async {
    await _preferences.setBool('has_seen_onboarding', state.hasSeenOnboarding);
    await _preferences.setString(_sessionKey, jsonEncode(state.toJson()));
  }
}
