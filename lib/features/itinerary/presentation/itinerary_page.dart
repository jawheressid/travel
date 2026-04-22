import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/models/itinerary.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class ItineraryPage extends ConsumerWidget {
  const ItineraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItineraryProvider);
    final catalogAsync = ref.watch(catalogProvider);
    final itinerariesAsync = ref.watch(itinerariesControllerProvider);

    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: SafeArea(
          child: AppAsyncValueWidget(
            value: catalogAsync,
            builder: (catalog) {
              return AppAsyncValueWidget(
                value: itinerariesAsync,
                loadingMessage: 'Loading your itinerary...',
                builder: (itineraries) {
                  final itinerary =
                      selected ??
                      (itineraries.isEmpty ? null : itineraries.first);
                  if (itinerary == null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: EmptyStateCard(
                        title: 'No itinerary yet',
                        message:
                            'Generate a custom stay to see your route, costs, and local impact here.',
                        actionLabel: 'Open planner',
                        onAction: () => context.push('/planner'),
                      ),
                    );
                  }
                  if (itinerary.items.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: EmptyStateCard(
                        title: 'No program generated',
                        message:
                            'The selected filters did not return enough places. Adjust the planner and try again.',
                        actionLabel: 'Open planner',
                        onAction: () => context.push('/planner'),
                      ),
                    );
                  }

                  final grouped = <int, List<ItineraryItem>>{};
                  for (final item in itinerary.items) {
                    grouped.putIfAbsent(item.dayNumber, () => []).add(item);
                  }

                  final firstPlace = catalog.places.firstWhere(
                    (place) => place.id == itinerary.items.first.placeId,
                  );
                  final heroGovernorate = catalog.governorates.firstWhere(
                    (governorate) => governorate.id == firstPlace.governorateId,
                  );
                  final routeGovernorates = itinerary.items
                      .map(
                        (item) => catalog.places.firstWhere(
                          (place) => place.id == item.placeId,
                        ),
                      )
                      .map(
                        (place) => catalog.governorates.firstWhere(
                          (governorate) =>
                              governorate.id == place.governorateId,
                        ),
                      )
                      .fold<List<String>>(<String>[], (names, governorate) {
                        if (!names.contains(governorate.name)) {
                          names.add(governorate.name);
                        }
                        return names;
                      });
                  final budgetByType = <PlaceType, double>{};
                  for (final item in itinerary.items) {
                    budgetByType.update(
                      item.itemType,
                      (value) => value + item.estimatedCost,
                      ifAbsent: () => item.estimatedCost,
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            const BrandWordmark(compact: true),
                            const Spacer(),
                            IconButton(
                              onPressed: () => context.push('/cart'),
                              icon: const Icon(
                                Icons.shopping_bag_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            SafeAssetImage(
                              path: heroGovernorate.coverImage,
                              title: itinerary.title,
                              height: 270,
                              borderRadius: 32,
                            ),
                            Positioned(
                              left: 20,
                              bottom: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    children: [
                                      ...routeGovernorates.map(
                                        (name) => Chip(label: Text(name)),
                                      ),
                                      Chip(label: Text(itinerary.theme.label)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    itinerary.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    formatDateRange(
                                      itinerary.startDate,
                                      itinerary.endDate,
                                    ),
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.94,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: _OverviewStat(
                                label: 'Travelers',
                                value: '${itinerary.travelersCount}',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _OverviewStat(
                                label: 'Impact score',
                                value:
                                    '${itinerary.localImpactScore.toStringAsFixed(0)}%',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _OverviewStat(
                                label: 'Budget',
                                value: formatCurrency(
                                  itinerary.totalEstimatedCost,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        BrandPanel(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trip overview',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _FactPill(
                                    label:
                                        'Supported local partners: ${itinerary.supportedPartnersCount}',
                                  ),
                                  _FactPill(
                                    label:
                                        'Local budget share: ${itinerary.localBudgetPercent}%',
                                  ),
                                  _FactPill(
                                    label:
                                        'Artisans included: ${itinerary.artisansIncluded}',
                                  ),
                                  _FactPill(
                                    label:
                                        'Regions in route: ${routeGovernorates.length}',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.14),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Route map',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Map integration is ready for real coordinates. This version keeps a clean route placeholder while the itinerary logic stays functional.',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        BrandPanel(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your itinerary',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 18),
                              ...grouped.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 22),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 28,
                                        alignment: Alignment.topCenter,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 12,
                                              height: 12,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    AppColors.mediterraneanBlue,
                                              ),
                                            ),
                                            if (entry.key != grouped.length)
                                              Container(
                                                width: 2,
                                                height: 140,
                                                color: Colors.white.withValues(
                                                  alpha: 0.18,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(18),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.08,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withValues(
                                                alpha: 0.14,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Day ${entry.key}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                              ),
                                              const SizedBox(height: 12),
                                              ...entry.value.map((item) {
                                                final place = catalog.places
                                                    .firstWhere(
                                                      (element) =>
                                                          element.id ==
                                                          item.placeId,
                                                    );
                                                final governorate = catalog
                                                    .governorates
                                                    .firstWhere(
                                                      (element) =>
                                                          element.id ==
                                                          place.governorateId,
                                                    );
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 12,
                                                      ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 70,
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 8,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withValues(
                                                                alpha: 0.12,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                18,
                                                              ),
                                                          border: Border.all(
                                                            color: Colors.white
                                                                .withValues(
                                                                  alpha: 0.14,
                                                                ),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          item.startTime,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                            context,
                                                          ).textTheme.bodyMedium
                                                              ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              place.name,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              governorate.name,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white
                                                                        .withValues(
                                                                          alpha:
                                                                              0.72,
                                                                        ),
                                                                  ),
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(item.notes),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              formatCurrency(
                                                                item.estimatedCost,
                                                              ),
                                                              style:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                        color: Colors
                                                                            .white
                                                                            .withValues(
                                                                          alpha:
                                                                              0.88,
                                                                        ),
                                                                      ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        BrandPanel(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Budget breakdown',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              ...budgetByType.entries.map(
                                (entry) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(entry.key.label),
                                      Text(
                                        formatCurrency(entry.value),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => context.push('/planner'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.24),
                                  ),
                                ),
                                child: const Text('Customize'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(cartControllerProvider.notifier)
                                      .fillFromItinerary(itinerary);
                                  context.push('/cart');
                                },
                                child: const Text('Book now'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OverviewStat extends StatelessWidget {
  const _OverviewStat({required this.label, required this.value});

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
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

class _FactPill extends StatelessWidget {
  const _FactPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
