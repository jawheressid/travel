import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/curated_content.dart';
import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/ui_helpers.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/safe_asset_image.dart';
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

  IconData _themeIcon(TravelTheme theme) {
    return switch (theme) {
      TravelTheme.culinary => Icons.restaurant_rounded,
      TravelTheme.nature => Icons.landscape_rounded,
      TravelTheme.heritage => Icons.museum_rounded,
      TravelTheme.artisan => Icons.storefront_rounded,
      TravelTheme.cycling => Icons.directions_bike_rounded,
      TravelTheme.adventure => Icons.hiking_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogProvider);
    final favorites = ref.watch(favoritesControllerProvider).valueOrNull ?? {};
    final session = ref.watch(sessionControllerProvider).valueOrNull;
    final fullName = session?.user?.fullName?.trim() ?? '';
    final firstName = fullName.isNotEmpty ? fullName.split(' ').first : 'Guest';

    return Stack(
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
                Colors.black.withOpacity(0.56),
                Colors.black.withOpacity(0.24),
                Colors.black.withOpacity(0.52),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: catalogAsync.when(
            loading: () => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    'Loading Tunisia highlights...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.92),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            error: (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Something went wrong.\n$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            data: (catalog) {
              final featuredGovernorates = catalog.curatedGovernorates;
              final inspirationGovernorates = catalog.inspirationGovernorates
                  .take(8)
                  .toList();
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: _GlassPanel(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 150,
                                    ),
                                    child: Image.asset(
                                      'assets/images/hkeyetna1.png',
                                      height: 40,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, _, _) =>
                                          const SizedBox(height: 40),
                                    ),
                                  ),
                                ),
                              ),
                              _TopPillButton(
                                label: 'Explore',
                                onTap: () => context.go('/explore'),
                              ),
                              const SizedBox(width: 8),
                              _TopPillButton(
                                label: 'Interests',
                                onTap: () => context.push('/interests'),
                              ),
                              const SizedBox(width: 10),
                              _AvatarBubble(
                                name: fullName.isEmpty ? 'Guest' : fullName,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _GlassPanel(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back, $firstName',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Discover curated stays, local makers, and routes designed to feel personal from the very first tap.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.88),
                              fontSize: 15.5,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Stack(
                            children: [
                              SizedBox(
                                height: 286,
                                child: PageView.builder(
                                  controller: _bannerController,
                                  itemCount: catalog.banners.length,
                                  onPageChanged: (value) =>
                                      setState(() => _bannerIndex = value),
                                  itemBuilder: (context, index) {
                                    final banner = catalog.banners[index];
                                    final region =
                                        featuredGovernorates[index %
                                            featuredGovernorates.length];

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            SafeAssetImage(
                                              path: banner.imagePath,
                                              title: banner.title,
                                              height: 286,
                                              borderRadius: 24,
                                            ),
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black.withOpacity(
                                                      0.08,
                                                    ),
                                                    Colors.black.withOpacity(
                                                      0.24,
                                                    ),
                                                    Colors.black.withOpacity(
                                                      0.72,
                                                    ),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 16,
                                              top: 16,
                                              child: _OverlayPill(
                                                label: region.name,
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
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 31,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      height: 1.04,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    banner.subtitle,
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.92),
                                                      fontSize: 15.5,
                                                      height: 1.4,
                                                    ),
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
                              Positioned(
                                right: 18,
                                bottom: 18,
                                child: IgnorePointer(
                                  child: Row(
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
                                              : Colors.white.withOpacity(0.42),
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
                          const SizedBox(height: 14),
                          TextField(
                            onChanged: (value) =>
                                setState(() => _query = value.trim()),
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText:
                                  'Search stays, artisans, restaurants, or experiences',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.68),
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.white.withOpacity(0.78),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.22),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF006B7D),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _HomeSection(
                      title: 'Tailored for you',
                      subtitle:
                          'A quick mix of themes based on your current travel preferences.',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: highlightedThemes
                            .map(
                              (theme) => _ThemeGlassChip(
                                label: theme.label,
                                icon: _themeIcon(theme),
                                color: themeColor(theme),
                                onTap: () => context.push('/planner'),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (searchResults.isNotEmpty) ...[
                      _HomeSection(
                        title: 'Search results',
                        subtitle: 'Quick matches across the HKEYETNA catalog.',
                        child: SizedBox(
                          height: 330,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: searchResults.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 14),
                            itemBuilder: (context, index) {
                              final place = searchResults[index];
                              return PlaceCard(
                                place: place,
                                isFavorite: favorites.contains(place.id),
                                onFavoriteToggle: () => ref
                                    .read(favoritesControllerProvider.notifier)
                                    .toggle(place.id),
                                onTap: () =>
                                    context.push('/place/${place.id}'),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                    _HomeSection(
                      title: 'Recommended stays',
                      subtitle:
                          'Boutique stays, guest lodges, and premium local bases.',
                      actionLabel: 'View all',
                      onAction: () => context.go('/explore'),
                      child: SizedBox(
                        height: 330,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: stays.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 14),
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
                    ),
                    const SizedBox(height: 18),
                    _BlueCalloutCard(onTap: () => context.push('/planner')),
                    const SizedBox(height: 18),
                    _HomeSection(
                      title: 'Launch regions',
                      subtitle:
                          'Interactive exploration is focused on Bizerte, Le Kef, and Tozeur for this phase.',
                      actionLabel: 'See all',
                      onAction: () => context.go('/explore'),
                      child: SizedBox(
                        height: 184,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: featuredGovernorates.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final governorate = featuredGovernorates[index];
                            return _GovernorateGlassCard(
                              name: governorate.name,
                              imagePath: governorate.heroImage,
                              tag: governorate.featuredTags.take(2).join(' - '),
                              onTap: () => context.push(
                                '/explore/governorate/${governorate.slug}',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _HomeSection(
                      title: 'Photo-only inspiration',
                      subtitle:
                          'Other Tunisian regions stay visible as inspiration photos while the launch stays focused on three regions.',
                      child: SizedBox(
                        height: 184,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: inspirationGovernorates.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final governorate = inspirationGovernorates[index];
                            return _PhotoOnlyGovernorateCard(
                              name: governorate.name,
                              imagePath: governorate.heroImage,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _HomeSection(
                      title: 'Local experiences',
                      subtitle:
                          'Handpicked partner-led experiences with strong recommendation scores.',
                      child: SizedBox(
                        height: 330,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: localExperiences.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 14),
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
                    ),
                    const SizedBox(height: 18),
                    _HomeSection(
                      title: 'Artisans spotlight',
                      subtitle:
                          'Ateliers, workshops, and local makers worth including in your route.',
                      child: SizedBox(
                        height: 330,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: artisans.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 14),
                          itemBuilder: (context, index) {
                            final artisan = artisans[index];
                            return PlaceCard(
                              place: artisan,
                              isFavorite: favorites.contains(artisan.id),
                              onFavoriteToggle: () => ref
                                  .read(favoritesControllerProvider.notifier)
                                  .toggle(artisan.id),
                              onTap: () =>
                                  context.push('/place/${artisan.id}'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 24,
    this.opacity = 0.2,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _HomeSection extends StatelessWidget {
  const _HomeSection({
    required this.title,
    required this.subtitle,
    required this.child,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.82),
                        fontSize: 14.5,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(width: 12),
                _TopPillButton(label: actionLabel!, onTap: onAction!),
              ],
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TopPillButton extends StatelessWidget {
  const _TopPillButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: Colors.white.withOpacity(0.14),
          border: Border.all(color: Colors.white.withOpacity(0.24)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ThemeGlassChip extends StatelessWidget {
  const _ThemeGlassChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color.withOpacity(0.22),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverlayPill extends StatelessWidget {
  const _OverlayPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.22)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isEmpty ? 'G' : name.trim()[0].toUpperCase();

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.deepBlue.withOpacity(0.8),
        border: Border.all(color: Colors.white.withOpacity(0.28)),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
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
    return _GlassPanel(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 28,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const SafeAssetImage(
                path: 'assets/images/regions/tozeur_hero.jpg',
                title: 'Custom travel planner',
                borderRadius: 24,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.12),
                      AppColors.deepBlue.withOpacity(0.56),
                      Colors.black.withOpacity(0.82),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              const Positioned(
                top: 18,
                left: 18,
                child: _OverlayPill(label: 'Multi-region planner'),
              ),
              Positioned(
                left: 22,
                right: 22,
                bottom: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Design a modern Tunisia program',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        height: 1.04,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Combine Bizerte, Le Kef, and Tozeur in one route with the exact leisure mix you want.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.92),
                        fontSize: 15.5,
                        height: 1.42,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                          backgroundColor: const Color(0xFF006B7D),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: const Text('Build My Program'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GovernorateGlassCard extends StatelessWidget {
  const _GovernorateGlassCard({
    required this.name,
    required this.imagePath,
    required this.tag,
    required this.onTap,
  });

  final String name;
  final String imagePath;
  final String tag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: onTap,
      child: Ink(
        width: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeAssetImage(
              path: imagePath,
              title: name,
              height: 184,
              borderRadius: 26,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.08),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.68),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tag,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
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

class _PhotoOnlyGovernorateCard extends StatelessWidget {
  const _PhotoOnlyGovernorateCard({
    required this.name,
    required this.imagePath,
  });

  final String name;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Stack(
        children: [
          SafeAssetImage(
            path: imagePath,
            title: name,
            height: 184,
            borderRadius: 26,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.08),
                  Colors.black.withOpacity(0.18),
                  Colors.black.withOpacity(0.62),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const Positioned(
            left: 16,
            top: 16,
            child: _OverlayPill(label: 'Photo only'),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
