import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/providers/app_providers.dart';
import 'core/services/app_bootstrap.dart';
import 'features/auth/presentation/sign_up_page.dart';
import 'features/debug/presentation/after_signup_debug_page.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bootstrap = await AppBootstrap.create();

  final router = GoRouter(
    initialLocation: '/signup',
    routes: [
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpPage(redirectTo: '/debug'),
      ),
      GoRoute(
        path: '/debug',
        builder: (context, state) => const AfterSignupDebugPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Debug flow: login disabled')),
        ),
      ),
    ],
  );

  runApp(
    ProviderScope(
      overrides: [appBootstrapProvider.overrideWithValue(bootstrap)],
      child: MaterialApp.router(
        title: 'HKEYETNA Debug',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    ),
  );
}
