import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/rating_badge.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class PlaceDetailsPage extends ConsumerWidget {
  const PlaceDetailsPage({required this.placeId, super.key});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(catalogProvider);
    final favorites = ref.watch(favoritesControllerProvider).valueOrNull ?? {};

    return Scaffold(
      body: SafeArea(
        child: AppAsyncValueWidget(
          value: catalogAsync,
          builder: (catalog) {
            final place = catalog.places.firstWhere(
              (item) => item.id == placeId,
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
            final gallery = [place.imageUrl, ...place.galleryUrls];

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 320,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        PageView.builder(
                          itemCount: gallery.length,
                          itemBuilder: (context, index) => SafeAssetImage(
                            path: gallery[index],
                            title: place.name,
                          ),
                        ),
                        Positioned(
                          top: 18,
                          right: 18,
                          child: Row(
                            children: [
                              RatingBadge(rating: place.rating),
                              const SizedBox(width: 8),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () => ref
                                      .read(
                                        favoritesControllerProvider.notifier,
                                      )
                                      .toggle(place.id),
                                  icon: Icon(
                                    favorites.contains(place.id)
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        place.name,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${place.type.label} · ${governorate.name}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.mediterraneanBlue),
                      ),
                      const SizedBox(height: 12),
                      Text(place.description),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.sand),
                        ),
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
                            .map((tag) => Chip(label: Text(tag)))
                            .toList(),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        height: 160,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: AppColors.deepBlue,
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
                          style: Theme.of(context).textTheme.titleLarge,
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
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
