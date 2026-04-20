import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
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
        loadingMessage: 'Loading all Tunisian governorates...',
        builder: (catalog) {
          final governorates = catalog.governorates.where((governorate) {
            return governorate.name.toLowerCase().contains(
                  _query.toLowerCase(),
                ) ||
                governorate.description.toLowerCase().contains(
                  _query.toLowerCase(),
                );
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Explore Tunisia by governorate',
                  subtitle:
                      '24 regions, each with stays, restaurants, artisans, museums, nature, and transport.',
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
                    hintText: 'Search governorates',
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
              ],
            ),
          );
        },
      ),
    );
  }
}
