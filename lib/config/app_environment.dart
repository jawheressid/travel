import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  const AppEnvironment({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  factory AppEnvironment.fromDotEnv() {
    // Prefer values loaded from .env assets, then fall back to dart-define.
    // This keeps release builds working in CI/CD when .env is not bundled.
    final supabaseUrl =
        dotenv.env['SUPABASE_URL']?.trim() ??
        const String.fromEnvironment('SUPABASE_URL').trim();
    final supabaseAnonKey =
        dotenv.env['SUPABASE_ANON_KEY']?.trim() ??
        const String.fromEnvironment('SUPABASE_ANON_KEY').trim();

    return AppEnvironment(
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
    );
  }

  final String supabaseUrl;
  final String supabaseAnonKey;

  bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
