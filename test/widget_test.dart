import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hkeyetna/config/app_environment.dart';
import 'package:hkeyetna/core/providers/app_providers.dart';
import 'package:hkeyetna/core/services/app_bootstrap.dart';
import 'package:hkeyetna/features/interests/presentation/interests_page.dart';

void main() {
  test('session signup does not throw', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final bootstrap = AppBootstrap(
      environment: const AppEnvironment(supabaseUrl: '', supabaseAnonKey: ''),
      sharedPreferences: preferences,
      supabaseClient: null,
    );

    final container = ProviderContainer(
      overrides: [appBootstrapProvider.overrideWithValue(bootstrap)],
    );
    addTearDown(container.dispose);

    Object? error;
    StackTrace? stackTrace;

    try {
      await container.read(sessionControllerProvider.notifier).signUp(
        fullName: 'Alya Ben Salem',
        email: 'alya@example.com',
        password: 'password123',
      );
    } catch (exception, trace) {
      error = exception;
      stackTrace = trace;
    }

    expect(error, isNull, reason: '$error\n$stackTrace');
  });

  testWidgets('interests page lays out and continues to home', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final bootstrap = AppBootstrap(
      environment: const AppEnvironment(supabaseUrl: '', supabaseAnonKey: ''),
      sharedPreferences: preferences,
      supabaseClient: null,
    );

    final router = GoRouter(
      initialLocation: '/interests',
      routes: [
        GoRoute(
          path: '/interests',
          builder: (context, state) => const InterestsPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home'))),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appBootstrapProvider.overrideWithValue(bootstrap)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Personalize Your Journey'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Horse Riding').last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.scrollUntilVisible(find.text('Continue').last, 200);
    await tester.tap(find.text('Continue').last);
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
