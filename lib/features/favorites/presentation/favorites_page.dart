import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/place_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(catalogProvider);
    final favoritesAsync = ref.watch(favoritesControllerProvider);

    return SafeArea(
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
                  padding: const EdgeInsets.all(20),
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                itemCount: places.length,
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final place = places[index];
                  return PlaceCard(
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
    );
  }
}
