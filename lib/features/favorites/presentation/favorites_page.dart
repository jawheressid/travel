import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/place_card.dart';
import '../../../shared/widgets/section_header.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(catalogProvider);
    final favoritesAsync = ref.watch(favoritesControllerProvider);

    return BrandBackground(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: SafeArea(
        child: AppAsyncValueWidget(
          value: catalogAsync,
          builder: (catalog) {
            return AppAsyncValueWidget(
              value: favoritesAsync,
              loadingMessage: 'Loading favorites...',
              builder: (favorites) {
                final places = catalog.places
                    .where((place) => favorites.contains(place.id))
                    .toList();
                if (places.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: EmptyStateCard(
                      title: 'No favorites yet',
                      message:
                          'Tap the heart icon on stays, restaurants, artisans, or activities to save them here.',
                      actionLabel: 'Explore places',
                      onAction: () => context.go('/explore'),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                  itemCount: places.length + 1,
                  separatorBuilder: (_, index) =>
                      SizedBox(height: index == 0 ? 18 : 14),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SectionHeader(
                        title: 'Saved places',
                        subtitle:
                            'Keep your favorite stays, artisans, restaurants, and activities ready for later.',
                      );
                    }

                    final place = places[index - 1];
                    return PlaceCard(
                      width: double.infinity,
                      place: place,
                      isFavorite: true,
                      onFavoriteToggle: () => ref
                          .read(favoritesControllerProvider.notifier)
                          .toggle(place.id),
                      onTap: () => context.push('/place/${place.id}'),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
