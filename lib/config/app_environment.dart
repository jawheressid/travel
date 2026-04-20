import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  const AppEnvironment({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  factory AppEnvironment.fromDotEnv() {
    return AppEnvironment(
      supabaseUrl: dotenv.env['SUPABASE_URL']?.trim() ?? '',
      supabaseAnonKey: dotenv.env['SUPABASE_ANON_KEY']?.trim() ?? '',
    );
  }

  final String supabaseUrl;
  final String supabaseAnonKey;

  bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
