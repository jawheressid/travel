import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/app_environment.dart';

class AppBootstrap {
  const AppBootstrap({
    required this.environment,
    required this.sharedPreferences,
    required this.supabaseClient,
  });

  final AppEnvironment environment;
  final SharedPreferences sharedPreferences;
  final SupabaseClient? supabaseClient;

  static Future<AppBootstrap> create() async {
    await dotenv.load(fileName: '.env');
    final environment = AppEnvironment.fromDotEnv();
    final sharedPreferences = await SharedPreferences.getInstance();

    SupabaseClient? client;
    if (environment.isSupabaseConfigured) {
      await Supabase.initialize(
        url: environment.supabaseUrl,
        anonKey: environment.supabaseAnonKey,
      );
      client = Supabase.instance.client;
    }

    return AppBootstrap(
      environment: environment,
      sharedPreferences: sharedPreferences,
      supabaseClient: client,
    );
  }
}
