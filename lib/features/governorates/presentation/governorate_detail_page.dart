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
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../shared/widgets/section_header.dart';

class GovernorateDetailPage extends ConsumerWidget {
  const GovernorateDetailPage({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(catalogProvider);
    final favorites = ref.watch(favoritesControllerProvider).valueOrNull ?? {};

    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.only(bottom: 20),
        child: SafeArea(
          child: AppAsyncValueWidget(
          value: catalogAsync,
          builder: (catalog) {
            final governorate = catalog.governorates.firstWhere(
              (item) => item.slug == slug,
            );
            final places = catalog.places
                .where((place) => place.governorateId == governorate.id)
                .toList();

            if (places.isEmpty) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeAssetImage(
                      path: governorate.coverImage,
                      title: governorate.name,
                      height: 260,
                      borderRadius: 30,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      governorate.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      governorate.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.84),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const BrandPanel(
                      child: Text(
                        'This governorate is currently shown as photo-only inspiration. Interactive content is active only for Bizerte, Le Kef, and Tozeur.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            List<Widget> buildSection(String title, PlaceType type) {
              final items = places
                  .where((place) => place.type == type)
                  .toList();
              if (items.isEmpty) {
                return [];
              }

              return [
                SectionHeader(
                  title: title,
                  subtitle:
                      '${items.length} curated options available in ${governorate.name}.',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final place = items[index];
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
              ];
            }

            final averageRating = places.isEmpty
                ? 0.0
                : places.map((place) => place.rating).reduce((a, b) => a + b) /
                      places.length;
            final averageBudget = places.isEmpty
                ? 0.0
                : places
                          .map((place) => (place.priceMin + place.priceMax) / 2)
                          .reduce((a, b) => a + b) /
                      places.length.toDouble();
            final localPartners = places
                .where((place) => place.isLocalPartner)
                .length;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  expandedHeight: 290,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        SafeAssetImage(
                          path: governorate.coverImage,
                          title: governorate.name,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.0),
                                Colors.black.withValues(alpha: 0.56),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                governorate.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                governorate.description,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.92,
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              label: 'Average rating',
                              value: averageRating.toStringAsFixed(1),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              label: 'Typical price',
                              value: formatCurrency(averageBudget),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              label: 'Local partners',
                              value: localPartners.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: governorate.featuredTags
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
                      const SizedBox(height: 24),
                      ...buildSection('Stays', PlaceType.accommodation),
                      ...buildSection('Restaurants', PlaceType.restaurant),
                      ...buildSection('Artisans', PlaceType.artisan),
                      ...buildSection('Museums & heritage', PlaceType.museum),
                      ...buildSection('Nature spots', PlaceType.natureSpot),
                      ...buildSection('Activities', PlaceType.activity),
                      ...buildSection('Transport', PlaceType.transport),
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

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return BrandPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
