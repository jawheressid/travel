import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/curated_content.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_badge.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../theme/app_colors.dart';
import 'widgets/tunisia_leaflet_map.dart';

class GovernoratesPage extends ConsumerStatefulWidget {
  const GovernoratesPage({super.key});

  @override
  ConsumerState<GovernoratesPage> createState() => _GovernoratesPageState();
}

class _GovernoratesPageState extends ConsumerState<GovernoratesPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogProvider);

    return BrandBackground(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: SafeArea(
        child: AppAsyncValueWidget(
          value: catalogAsync,
          loadingMessage: 'Loading launch regions...',
          builder: (catalog) {
            final governorates = catalog.curatedGovernorates.where((governorate) {
              return governorate.name.toLowerCase().contains(
                    _query.toLowerCase(),
                  ) ||
                  governorate.description.toLowerCase().contains(
                    _query.toLowerCase(),
                  );
            }).toList();
            final inspirationGovernorates = catalog.inspirationGovernorates
                .take(12)
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Explore the 3 launch regions',
                    subtitle:
                        'Interactive discovery is currently focused on Bizerte, Le Kef, and Tozeur.',
                  ),
                  const SizedBox(height: 18),
                  BrandPanel(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TunisiaLeafletMap(
                          activeGovernorates: governorates,
                          photoOnlyGovernorates: inspirationGovernorates,
                          onGovernorateTap: (governorate) => context.push(
                            '/explore/governorate/${governorate.slug}',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _MapLegendChip(
                              color: const Color(0xFF1390A0),
                              label: 'Active regions',
                            ),
                            _MapLegendChip(
                              color: Colors.white.withValues(alpha: 0.72),
                              label: 'Photo-only regions',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          governorates.isEmpty
                              ? 'No active region matches this search yet.'
                              : 'Tap a highlighted marker to open an active region.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.82),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => setState(() => _query = value.trim()),
                    decoration: InputDecoration(
                      hintText: 'Search launch regions',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.64),
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.16),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(
                          color: AppColors.mediterraneanBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: governorates.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final governorate = governorates[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: () => context.push(
                          '/explore/governorate/${governorate.slug}',
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.22),
                                blurRadius: 22,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SafeAssetImage(
                                path: governorate.heroImage,
                                title: governorate.name,
                                height: 150,
                                borderRadius: 26,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      governorate.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      governorate.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
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
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const SectionHeader(
                    title: 'Photo-only regions',
                    subtitle:
                        'The rest of Tunisia stays visible as inspiration photos while the active catalog remains limited to the launch regions.',
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 184,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: inspirationGovernorates.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final governorate = inspirationGovernorates[index];
                        return _PhotoOnlyGovernorateCard(
                          name: governorate.name,
                          imagePath: governorate.heroImage,
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

class _MapLegendChip extends StatelessWidget {
  const _MapLegendChip({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            SafeAssetImage(
              path: imagePath,
              title: name,
              height: 184,
              borderRadius: 26,
            ),
            Positioned(
              left: 16,
              top: 16,
              child: BrandBadge(
                label: 'Photo only',
                background: Colors.black.withValues(alpha: 0.22),
                foreground: Colors.white,
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
