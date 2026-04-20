import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_badge.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class AuthLandingPage extends ConsumerWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSupabaseEnabled = ref.watch(
      environmentProvider.select((value) => value.isSupabaseConfigured),
    );

    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: BrandPanel(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                radius: 34,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: const SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            SafeAssetImage(
                              path: 'assets/images/onboarding/auth_cover.jpg',
                              title: 'HKEYETNA',
                              borderRadius: 28,
                            ),
                            Positioned(
                              top: 18,
                              left: 18,
                              child: BrandWordmark(light: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const BrandBadge(label: 'Travel differently'),
                    const SizedBox(height: 16),
                    Text(
                      'HKEYETNA',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppColors.mediterraneanBlue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore the new to find good places',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: isSupabaseEnabled
                            ? AppColors.success.withValues(alpha: 0.10)
                            : AppColors.mistBlue,
                      ),
                      child: Text(
                        isSupabaseEnabled
                            ? 'Supabase is connected and live sync is enabled.'
                            : 'Demo mode is enabled. Add Supabase keys later without changing the UI flow.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () => context.push('/login'),
                      child: const Text('Get Started'),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () => context.push('/signup'),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(sessionControllerProvider.notifier)
                            .signInAsGuest();
                        if (context.mounted) {
                          context.go('/home');
                        }
                      },
                      child: const Text('Continue as guest'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
