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

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  final _slides = const [
    (
      'assets/images/onboarding/discover_tunisia.jpg',
      'Discover Tunisia\ndifferently.',
      'Build personalized stays across coastlines, medinas, mountains, and desert gateways.',
      'L\'art de voyager',
    ),
    (
      'assets/images/onboarding/support_locals.jpg',
      'Support local\ncommunities.',
      'Book artisans, guest houses, restaurants, activities, and transport in one curated flow.',
      'Local impact',
    ),
    (
      'assets/images/onboarding/travel_smart.jpg',
      'Travel smart\nwith impact.',
      'Save favorites, create day-by-day routes, and move from inspiration to real booking in one app.',
      'Plan with intention',
    ),
  ];

  Future<void> _finish() async {
    await ref.read(sessionControllerProvider.notifier).markOnboardingSeen();
    if (!mounted) {
      return;
    }
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const BrandWordmark(),
                  const Spacer(),
                  TextButton(onPressed: _finish, child: const Text('Skip')),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _slides.length,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemBuilder: (context, index) {
                    final item = _slides[index];
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: BrandPanel(
                          radius: 34,
                          padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  SafeAssetImage(
                                    path: item.$1,
                                    title: 'Discover Tunisia',
                                    height: 380,
                                    borderRadius: 28,
                                  ),
                                  const Positioned(
                                    top: 18,
                                    left: 18,
                                    child: BrandWordmark(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              BrandBadge(label: item.$4),
                              const SizedBox(height: 18),
                              Text(
                                item.$2,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item.$3,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: index == _slides.length - 1
                                    ? _finish
                                    : () => _controller.nextPage(
                                        duration: const Duration(
                                          milliseconds: 280,
                                        ),
                                        curve: Curves.easeOutCubic,
                                      ),
                                child: Text(
                                  index == _slides.length - 1
                                      ? 'Start now'
                                      : 'Continue',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(right: 8),
                    height: 8,
                    width: _index == index ? 30 : 8,
                    decoration: BoxDecoration(
                      color: _index == index
                          ? AppColors.mediterraneanBlue
                          : AppColors.sandDark,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
