import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/ui_helpers.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class InterestsPage extends ConsumerStatefulWidget {
  const InterestsPage({super.key});

  @override
  ConsumerState<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends ConsumerState<InterestsPage> {
  final Set<TravelTheme> _selected = {};

  final _cards = const [
    (
      TravelTheme.adventure,
      'Horse Riding',
      'assets/images/mockups/horse_riding.jpg',
      1.28,
    ),
    (TravelTheme.cycling, 'Cycling', 'assets/images/mockups/cycling.jpg', 1.0),
    (TravelTheme.nature, 'Nature', 'assets/images/mockups/nature.jpg', 1.0),
    (
      TravelTheme.heritage,
      'Local Crafts',
      'assets/images/mockups/crafts.jpg',
      1.55,
    ),
    (
      TravelTheme.culinary,
      'Traditional Cuisine',
      'assets/images/mockups/cuisine.jpg',
      1.0,
    ),
    (
      TravelTheme.artisan,
      'Handcrafted',
      'assets/images/mockups/artisan.jpg',
      1.0,
    ),
  ];

  Future<void> _continue() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one interest.')),
      );
      return;
    }

    await ref
        .read(sessionControllerProvider.notifier)
        .updateInterests(_selected.toList());
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                children: [
                  const BrandWordmark(compact: true),
                  const Spacer(),
                  TextButton(
                    onPressed: _selected.isEmpty ? null : _continue,
                    child: const Text('Continue'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Personalize Your Journey',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.mediterraneanBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the activities that call to you. We will tailor a unique Tunisian story inspired by your passions.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: _InterestTile(
                      label: _cards[0].$2,
                      imagePath: _cards[0].$3,
                      selected: _selected.contains(_cards[0].$1),
                      accent: themeColor(_cards[0].$1),
                      height: 292,
                      onTap: () => _toggle(_cards[0].$1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        _InterestTile(
                          label: _cards[1].$2,
                          imagePath: _cards[1].$3,
                          selected: _selected.contains(_cards[1].$1),
                          accent: themeColor(_cards[1].$1),
                          height: 140,
                          onTap: () => _toggle(_cards[1].$1),
                        ),
                        const SizedBox(height: 12),
                        _InterestTile(
                          label: _cards[2].$2,
                          imagePath: _cards[2].$3,
                          selected: _selected.contains(_cards[2].$1),
                          accent: themeColor(_cards[2].$1),
                          height: 140,
                          onTap: () => _toggle(_cards[2].$1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InterestTile(
                label: _cards[3].$2,
                imagePath: _cards[3].$3,
                selected: _selected.contains(_cards[3].$1),
                accent: themeColor(_cards[3].$1),
                height: 150,
                onTap: () => _toggle(_cards[3].$1),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _InterestTile(
                      label: _cards[4].$2,
                      imagePath: _cards[4].$3,
                      selected: _selected.contains(_cards[4].$1),
                      accent: themeColor(_cards[4].$1),
                      height: 132,
                      onTap: () => _toggle(_cards[4].$1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InterestTile(
                      label: _cards[5].$2,
                      imagePath: _cards[5].$3,
                      selected: _selected.contains(_cards[5].$1),
                      accent: themeColor(_cards[5].$1),
                      height: 132,
                      onTap: () => _toggle(_cards[5].$1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_selected.length} activities selected - tell us your passion.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _continue,
                    child: const Text('Continue'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle(TravelTheme theme) {
    setState(() {
      _selected.contains(theme)
          ? _selected.remove(theme)
          : _selected.add(theme);
    });
  }
}

class _InterestTile extends StatelessWidget {
  const _InterestTile({
    required this.label,
    required this.imagePath,
    required this.selected,
    required this.accent,
    required this.height,
    required this.onTap,
  });

  final String label;
  final String imagePath;
  final bool selected;
  final Color accent;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Ink(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: selected
                ? accent
                : AppColors.sandDark.withValues(alpha: 0.85),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: selected ? 0.16 : 0.05),
              blurRadius: 18,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SafeAssetImage(
                  path: imagePath,
                  title: label,
                  borderRadius: 22,
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      selected ? Icons.check_rounded : Icons.add_rounded,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
