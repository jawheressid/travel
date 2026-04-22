import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/rating_badge.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class PlaceDetailsPage extends ConsumerStatefulWidget {
  const PlaceDetailsPage({required this.placeId, super.key});

  final String placeId;

  @override
  ConsumerState<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends ConsumerState<PlaceDetailsPage> {
  final PageController _galleryController = PageController();
  int _galleryIndex = 0;

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogProvider);
    final favorites = ref.watch(favoritesControllerProvider).valueOrNull ?? {};

    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.only(bottom: 20),
        child: SafeArea(
          child: AppAsyncValueWidget(
          value: catalogAsync,
          builder: (catalog) {
            final place = catalog.places.firstWhere(
              (item) => item.id == widget.placeId,
            );
            final governorate = catalog.governorates.firstWhere(
              (item) => item.id == place.governorateId,
            );
            final related = catalog.places
                .where(
                  (item) =>
                      item.id != place.id &&
                      item.governorateId == place.governorateId &&
                      item.type == place.type,
                )
                .take(4)
                .toList();
            final gallery = <String>{
              place.imageUrl,
              ...place.galleryUrls,
            }.toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _ModernGalleryHero(
                      title: place.name,
                      subtitle: '${place.type.label} - ${governorate.name}',
                      rating: place.rating,
                      isFavorite: favorites.contains(place.id),
                      images: gallery,
                      currentIndex: _galleryIndex,
                      controller: _galleryController,
                      onPageChanged: (index) {
                        if (_galleryIndex != index) {
                          setState(() => _galleryIndex = index);
                        }
                      },
                      onBack: () => context.pop(),
                      onFavoriteToggle: () => ref
                          .read(favoritesControllerProvider.notifier)
                          .toggle(place.id),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        place.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.86),
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 20),
                      BrandPanel(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            _DetailRow(
                              label: 'Price',
                              value:
                                  '${formatCurrency(place.priceMin)} - ${formatCurrency(place.priceMax)}',
                            ),
                            _DetailRow(label: 'Address', value: place.address),
                            _DetailRow(
                              label: 'Opening hours',
                              value: place.openingHours ?? 'Check with partner',
                            ),
                            _DetailRow(
                              label: 'Coordinates',
                              value: '${place.latitude}, ${place.longitude}',
                            ),
                            _DetailRow(
                              label: 'Local partner',
                              value: place.isLocalPartner ? 'Yes' : 'No',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: place.tags
                            .map(
                              (tag) => Chip(
                                label: Text(tag),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.12),
                                side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.16),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.deepBlue,
                              AppColors.mediterraneanBlue,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recommended for',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              place.isFamilyFriendly
                                  ? 'Families, slow travelers, and culture-first stays.'
                                  : 'Curious explorers, couples, and locally minded travelers.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.92),
                                    height: 1.45,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .addPlace(place);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to booking cart.'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_bag_rounded),
                              label: const Text('Book now'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.push('/planner'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.24),
                                ),
                              ),
                              icon: const Icon(Icons.auto_awesome_rounded),
                              label: const Text('Add to trip'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      if (related.isNotEmpty) ...[
                        Text(
                          'More in ${governorate.name}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 320,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: related.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 14),
                            itemBuilder: (context, index) {
                              final relatedPlace = related[index];
                              return PlaceCard(
                                place: relatedPlace,
                                isFavorite: favorites.contains(relatedPlace.id),
                                onFavoriteToggle: () => ref
                                    .read(favoritesControllerProvider.notifier)
                                    .toggle(relatedPlace.id),
                                onTap: () =>
                                    context.push('/place/${relatedPlace.id}'),
                              );
                            },
                          ),
                        ),
                      ],
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
        ),
      ),
    );
  }
}

class _ModernGalleryHero extends StatelessWidget {
  const _ModernGalleryHero({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.isFavorite,
    required this.images,
    required this.currentIndex,
    required this.controller,
    required this.onPageChanged,
    required this.onBack,
    required this.onFavoriteToggle,
  });

  final String title;
  final String subtitle;
  final double rating;
  final bool isFavorite;
  final List<String> images;
  final int currentIndex;
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onBack;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              fit: StackFit.expand,
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: images.length,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) => SafeAssetImage(
                    path: images[index],
                    title: title,
                    fit: BoxFit.cover,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.12),
                        Colors.black.withValues(alpha: 0.18),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _GlassCircleButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: onBack,
                ),
                const Spacer(),
                RatingBadge(rating: rating),
                const SizedBox(width: 8),
                _GlassCircleButton(
                  icon: isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: isFavorite ? AppColors.danger : Colors.white,
                  onTap: onFavoriteToggle,
                ),
              ],
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                    ),
                  ),
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.02,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: List.generate(
                    images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: EdgeInsets.only(
                        right: index == images.length - 1 ? 0 : 6,
                      ),
                      height: 6,
                      width: currentIndex == index ? 24 : 6,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.38),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCircleButton extends StatelessWidget {
  const _GlassCircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.14),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
