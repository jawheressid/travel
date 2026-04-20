import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/ui_helpers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_badge.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../theme/app_colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _bannerController = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _bannerIndex = 0;
  String _query = '';
  int _bannerCount = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _startCarousel() {
    _timer ??= Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_bannerController.hasClients || _bannerCount == 0) {
        return;
      }
      _bannerIndex = (_bannerIndex + 1) % _bannerCount;
      _bannerController.animateToPage(
        _bannerIndex,
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogProvider);
    final favorites = ref.watch(favoritesControllerProvider).valueOrNull ?? {};
    final session = ref.watch(sessionControllerProvider).valueOrNull;

    return BrandBackground(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 120),
      child: SafeArea(
        child: AppAsyncValueWidget(
          value: catalogAsync,
          loadingMessage: 'Loading Tunisia highlights...',
          builder: (catalog) {
            final featuredGovernorates = catalog.governorates.take(4).toList();
            final stays = catalog.places
                .where((place) => place.type == PlaceType.accommodation)
                .take(6)
                .toList();
            final localExperiences = catalog.places
                .where(
                  (place) =>
                      place.isLocalPartner &&
                      place.type != PlaceType.transport &&
                      place.type != PlaceType.accommodation,
                )
                .take(8)
                .toList();
            final artisans = catalog.places
                .where((place) => place.type == PlaceType.artisan)
                .take(6)
                .toList();
            final interests = session?.user?.selectedInterests ?? [];
            final highlightedThemes = interests.isEmpty
                ? TravelTheme.values.take(4).toList()
                : interests.take(4).toList();
            final searchResults = _query.isEmpty
                ? <dynamic>[]
                : catalog.places
                      .where(
                        (place) =>
                            place.name.toLowerCase().contains(
                              _query.toLowerCase(),
                            ) ||
                            place.tags.any(
                              (tag) => tag.toLowerCase().contains(
                                _query.toLowerCase(),
                              ),
                            ),
                      )
                      .take(6)
                      .toList();

            _bannerCount = catalog.banners.length;
            _startCarousel();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BrandWordmark(),
                      const Spacer(),
                      _TopTab(
                        label: 'Explore',
                        onTap: () => context.go('/explore'),
                      ),
                      const SizedBox(width: 8),
                      _TopTab(
                        label: 'Interests',
                        onTap: () => context.push('/interests'),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.deepBlue,
                        child: Text(
                          (session?.user?.fullName ?? 'Guest')
                              .substring(0, 1)
                              .toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  BrandPanel(
                    radius: 30,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 270,
                              child: PageView.builder(
                                controller: _bannerController,
                                itemCount: catalog.banners.length,
                                onPageChanged: (value) =>
                                    setState(() => _bannerIndex = value),
                                itemBuilder: (context, index) {
                                  final banner = catalog.banners[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        SafeAssetImage(
                                          path: banner.imagePath,
                                          title: banner.title,
                                          height: 270,
                                          borderRadius: 26,
                                        ),
                                        Positioned(
                                          left: 16,
                                          top: 16,
                                          child: BrandBadge(
                                            label:
                                                featuredGovernorates[index %
                                                        featuredGovernorates
                                                            .length]
                                                    .name,
                                            background: Colors.white.withValues(
                                              alpha: 0.88,
                                            ),
                                            foreground: AppColors.deepBlue,
                                          ),
                                        ),
                                        Positioned(
                                          left: 18,
                                          right: 18,
                                          bottom: 18,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                banner.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                banner.subtitle,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.94,
                                                          ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              left: 18,
                              right: 18,
                              bottom: 18,
                              child: IgnorePointer(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: List.generate(
                                    catalog.banners.length,
                                    (index) => AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 240,
                                      ),
                                      margin: const EdgeInsets.only(left: 6),
                                      height: 7,
                                      width: _bannerIndex == index ? 24 : 7,
                                      decoration: BoxDecoration(
                                        color: _bannerIndex == index
                                            ? Colors.white
                                            : Colors.white.withValues(
                                                alpha: 0.42,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          onChanged: (value) =>
                              setState(() => _query = value.trim()),
                          decoration: const InputDecoration(
                            hintText:
                                'Search stays, artisans, restaurants, or experiences',
                            prefixIcon: Icon(Icons.search_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: highlightedThemes
                        .map(
                          (theme) => ActionChip(
                            label: Text(theme.label),
                            onPressed: () => context.push('/planner'),
                            avatar: Icon(
                              switch (theme) {
                                TravelTheme.culinary =>
                                  Icons.restaurant_rounded,
                                TravelTheme.nature => Icons.landscape_rounded,
                                TravelTheme.heritage => Icons.museum_rounded,
                                TravelTheme.artisan => Icons.storefront_rounded,
                                TravelTheme.cycling =>
                                  Icons.directions_bike_rounded,
                                TravelTheme.adventure => Icons.hiking_rounded,
                              },
                              size: 18,
                              color: themeColor(theme),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 26),
                  if (searchResults.isNotEmpty) ...[
                    const SectionHeader(
                      title: 'Search results',
                      subtitle: 'Quick matches across the HKEYETNA catalog.',
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 330,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: searchResults.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final place = searchResults[index];
                          return PlaceCard(
                            place: place,
                            isFavorite: favorites.contains(place.id),
                            onFavoriteToggle: () => ref
                                .read(favoritesControllerProvider.notifier)
                                .toggle(place.id),
                            onTap: () => context.push('/place/${place.id}'),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  SectionHeader(
                    title: 'Recommended stays',
                    subtitle:
                        'Boutique stays, guest lodges, and premium local bases.',
                    actionLabel: 'View all',
                    onAction: () => context.go('/explore'),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 330,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: stays.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final place = stays[index];
                        return PlaceCard(
                          place: place,
                          subtitle:
                              'Recommended stay in ${catalog.governorates.firstWhere((g) => g.id == place.governorateId).name}',
                          isFavorite: favorites.contains(place.id),
                          onFavoriteToggle: () => ref
                              .read(favoritesControllerProvider.notifier)
                              .toggle(place.id),
                          onTap: () => context.push('/place/${place.id}'),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                  _BlueCalloutCard(onTap: () => context.push('/planner')),
                  const SizedBox(height: 26),
                  SectionHeader(
                    title: 'Featured governorates',
                    subtitle:
                        'Explore Tunisia through curated regions and local moods.',
                    actionLabel: 'See all',
                    onAction: () => context.go('/explore'),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 184,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredGovernorates.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final governorate = featuredGovernorates[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: () => context.push(
                            '/explore/governorate/${governorate.slug}',
                          ),
                          child: Ink(
                            width: 230,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Stack(
                              children: [
                                SafeAssetImage(
                                  path: governorate.heroImage,
                                  title: governorate.name,
                                  height: 184,
                                  borderRadius: 26,
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 16,
                                  right: 16,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        governorate.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        governorate.featuredTags
                                            .take(2)
                                            .join(' - '),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 26),
                  const SectionHeader(
                    title: 'Local experiences',
                    subtitle:
                        'Handpicked partner-led experiences with strong recommendation scores.',
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 330,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: localExperiences.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final place = localExperiences[index];
                        return PlaceCard(
                          place: place,
                          isFavorite: favorites.contains(place.id),
                          onFavoriteToggle: () => ref
                              .read(favoritesControllerProvider.notifier)
                              .toggle(place.id),
                          onTap: () => context.push('/place/${place.id}'),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 26),
                  const SectionHeader(
                    title: 'Artisans spotlight',
                    subtitle:
                        'Ateliers, workshops, and local makers worth including in your route.',
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 330,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: artisans.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final artisan = artisans[index];
                        return PlaceCard(
                          place: artisan,
                          isFavorite: favorites.contains(artisan.id),
                          onFavoriteToggle: () => ref
                              .read(favoritesControllerProvider.notifier)
                              .toggle(artisan.id),
                          onTap: () => context.push('/place/${artisan.id}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: Colors.white.withValues(alpha: 0.72),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.deepBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _BlueCalloutCard extends StatelessWidget {
  const _BlueCalloutCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.mediterraneanBlue,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _CardGridPainter()),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ready to design your\nbespoke Tunisian escape?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Build a stay that balances local value, scenery, and specific activities you care about.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.94),
                  ),
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.deepBlue,
                    side: BorderSide.none,
                  ),
                  child: const Text('Create My Dream Stay'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CardGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.14)
      ..strokeWidth = 1;

    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
