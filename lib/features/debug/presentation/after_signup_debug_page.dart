import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';

class AfterSignupDebugPage extends ConsumerWidget {
  const AfterSignupDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Debug: After Signup')),
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Session provider error:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SelectableText(error.toString()),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go('/signup'),
                  child: const Text('Back to signup'),
                ),
              ),
            ],
          ),
        ),
        data: (session) {
          final jsonText = const JsonEncoder.withIndent(
            '  ',
          ).convert(session.toJson());
          final user = session.user;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signup succeeded. You are now on a minimal debug screen.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                _kv('Supabase enabled', session.isSupabaseEnabled.toString()),
                _kv(
                  'Has seen onboarding',
                  session.hasSeenOnboarding.toString(),
                ),
                _kv('User present', (user != null).toString()),
                if (user != null) ...[
                  const SizedBox(height: 10),
                  _kv('User ID', user.id),
                  _kv('Full name', user.fullName),
                  _kv('Email', user.email),
                  _kv('Interests', user.selectedInterests.length.toString()),
                  _kv(
                    'Completed onboarding',
                    user.hasCompletedOnboarding.toString(),
                  ),
                  _kv('Guest', user.isGuest.toString()),
                ],
                const SizedBox(height: 14),
                Text(
                  'Raw session JSON',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          jsonText,
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          await ref
                              .read(sessionControllerProvider.notifier)
                              .signOut();
                          if (context.mounted) {
                            context.go('/signup');
                          }
                        },
                        child: const Text('Sign out'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(k, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: SelectableText(v)),
        ],
      ),
    );
  }
}
