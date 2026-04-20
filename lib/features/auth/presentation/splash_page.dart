import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(_bootstrap);
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final session = await ref.read(sessionControllerProvider.future);
    if (!mounted) {
      return;
    }

    if (!session.hasSeenOnboarding) {
      context.go('/onboarding');
      return;
    }

    if (session.user == null) {
      context.go('/auth');
      return;
    }

    if (session.user!.selectedInterests.isEmpty) {
      context.go('/interests');
      return;
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.offWhite, AppColors.sand, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: const SafeAssetImage(
                    path: 'assets/images/onboarding/splash_cover.jpg',
                    title: 'HKEYETNA',
                    height: 280,
                    borderRadius: 36,
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'HKEYETNA',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.mediterraneanBlue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore the new to find good places',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: 28),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
