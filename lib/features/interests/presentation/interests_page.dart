import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/ui_helpers.dart';
import '../../../shared/widgets/safe_asset_image.dart';

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

  void _toggle(TravelTheme theme) {
    setState(() {
      _selected.contains(theme)
          ? _selected.remove(theme)
          : _selected.add(theme);
    });
  }

  Widget _buildSelectionBadge() {
    final hasSelection = _selected.isNotEmpty;
    final label = hasSelection
        ? '${_selected.length} interests selected'
        : 'Select at least one interest';

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: hasSelection
              ? const Color(0xFF006B7D).withOpacity(0.95)
              : Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.22)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboarding/onboarding_cover.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (_, _, _) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5E2D1E), Color(0xFF281B19)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.58),
                  Colors.black.withOpacity(0.24),
                  Colors.black.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/hkeyetna1.png',
                                  height: 98,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) =>
                                      const SizedBox(height: 98),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Choose Your Interests',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  height: 1.05,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Select the experiences that inspire you. We will shape your Tunisian story around what you love most.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.88),
                                  fontSize: 15.5,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSelectionBadge(),
                              const SizedBox(height: 22),
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
                                          selected: _selected.contains(
                                            _cards[1].$1,
                                          ),
                                          accent: themeColor(_cards[1].$1),
                                          height: 140,
                                          onTap: () => _toggle(_cards[1].$1),
                                        ),
                                        const SizedBox(height: 12),
                                        _InterestTile(
                                          label: _cards[2].$2,
                                          imagePath: _cards[2].$3,
                                          selected: _selected.contains(
                                            _cards[2].$1,
                                          ),
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
                              const SizedBox(height: 18),
                              Text(
                                'Tap any card to add it to your travel profile.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.76),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _continue,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF006B7D),
                                    minimumSize: const Size(0, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 8,
                                  ),
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: selected ? accent : Colors.white.withOpacity(0.24),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(selected ? 0.22 : 0.14),
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
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.08),
                      Colors.black.withOpacity(0.18),
                      Colors.black.withOpacity(0.64),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: selected
                      ? accent.withOpacity(0.95)
                      : Colors.black.withOpacity(0.26),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.34)),
                ),
                child: Icon(
                  selected ? Icons.check_rounded : Icons.add_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
