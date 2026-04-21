import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/curated_content.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_badge.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../shared/widgets/section_header.dart';

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

    return SafeArea(
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
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Explore the 3 launch regions',
                  subtitle:
                      'Interactive discovery is currently focused on Bizerte, Le Kef, and Tozeur.',
                ),
                const SizedBox(height: 18),
                const SafeAssetImage(
                  path: 'assets/images/mockups/tunisia_map.jpg',
                  title: 'Curated map view',
                  height: 210,
                  borderRadius: 30,
                ),
                const SizedBox(height: 18),
                TextField(
                  onChanged: (value) => setState(() => _query = value.trim()),
                  decoration: const InputDecoration(
                    hintText: 'Search launch regions',
                    prefixIcon: Icon(Icons.search_rounded),
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
                    childAspectRatio: 0.82,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
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
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    governorate.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
          Positioned(
            left: 16,
            top: 16,
            child: BrandBadge(
              label: 'Photo only',
              background: Colors.white.withValues(alpha: 0.92),
              foreground: Colors.black87,
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
    );
  }
}
