import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/curated_content.dart';
import '../../../core/enums/app_enums.dart';
import '../../../core/models/planner_form.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/ui_helpers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_badge.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class PlannerPage extends ConsumerStatefulWidget {
  const PlannerPage({super.key});

  @override
  ConsumerState<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends ConsumerState<PlannerPage> {
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now().add(const Duration(days: 20)),
    end: DateTime.now().add(const Duration(days: 24)),
  );
  double _budget = 1800;
  int _travelers = 2;
  TravelStyle _travelStyle = TravelStyle.couple;
  TravelTheme _travelTheme = TravelTheme.heritage;
  ActivityLevel _activityLevel = ActivityLevel.medium;
  final Set<String> _selectedRegions = {};
  final Set<String> _selectedActivities = {};
  bool _isGenerating = false;

  Future<void> _pickDates() async {
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _dateRange,
    );
    if (selected != null) {
      setState(() => _dateRange = selected);
    }
  }

  Future<void> _generate() async {
    final catalog = await ref.read(catalogProvider.future);
    final session = await ref.read(sessionControllerProvider.future);
    final plannerForm = PlannerForm(
      startDate: _dateRange.start,
      endDate: _dateRange.end,
      travelersCount: _travelers,
      budget: _budget,
      travelStyle: _travelStyle,
      travelTheme: _travelTheme,
      preferredRegions: _selectedRegions.toList(),
      activityLevel: _activityLevel,
    );

    setState(() => _isGenerating = true);
    try {
      final itinerary = ref
          .read(recommendationServiceProvider)
          .generate(
            form: plannerForm,
            catalog: catalog,
            userId: session.user?.id,
            selectedActivities: _selectedActivities.toList(),
          );

      if (itinerary.items.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No matching program was found. Increase the budget or add another region/leisure.',
              ),
            ),
          );
        }
        return;
      }

      await ref.read(itinerariesControllerProvider.notifier).save(itinerary);
      if (mounted) {
        context.go('/itinerary');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Trip generation failed: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogProvider);

    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: SafeArea(
          child: AppAsyncValueWidget(
            value: catalogAsync,
            builder: (catalog) {
              final curatedGovernorates = catalog.curatedGovernorates;
              final selectedRegionNames = curatedGovernorates
                  .where(
                    (governorate) => _selectedRegions.contains(governorate.id),
                  )
                  .map((governorate) => governorate.name)
                  .toList(growable: false);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const Spacer(),
                        const BrandWordmark(compact: true),
                        const Spacer(),
                        IconButton(
                          onPressed: () => context.go('/home'),
                          icon: const Icon(Icons.home_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BrandPanel(
                      radius: 32,
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SafeAssetImage(
                            path: 'assets/images/mockups/planner_cover.jpg',
                            title: 'Create My Dream Stay',
                            height: 225,
                            borderRadius: 26,
                          ),
                          const SizedBox(height: 16),
                          const BrandBadge(label: 'Curated route builder'),
                          const SizedBox(height: 14),
                          Text(
                            'Create My Dream Stay',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: AppColors.mediterraneanBlue),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Build an adapted program across Bizerte, Le Kef, and Tozeur with realistic prices, local impact, and multi-region routing.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _MetricCard(
                                  label: 'Travel dates',
                                  value: formatDateRange(
                                    _dateRange.start,
                                    _dateRange.end,
                                  ),
                                  icon: Icons.calendar_month_rounded,
                                  onTap: _pickDates,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _MetricCard(
                                  label: 'Travelers',
                                  value: '$_travelers guests',
                                  icon: Icons.group_rounded,
                                ),
                              ),
                            ],
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
                            'Budget',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatCurrency(_budget),
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: AppColors.deepBlue),
                          ),
                          Slider(
                            value: _budget,
                            min: 400,
                            max: 6000,
                            divisions: 28,
                            label: formatCurrency(_budget),
                            onChanged: (value) =>
                                setState(() => _budget = value),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton.filledTonal(
                                onPressed: _travelers > 1
                                    ? () => setState(() => _travelers--)
                                    : null,
                                icon: const Icon(Icons.remove_rounded),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '$_travelers',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              const SizedBox(width: 12),
                              IconButton.filled(
                                onPressed: () => setState(() => _travelers++),
                                icon: const Icon(Icons.add_rounded),
                              ),
                            ],
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
                            'Travel style',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: TravelStyle.values.map((style) {
                              return ChoiceChip(
                                label: Text(style.label),
                                selected: _travelStyle == style,
                                onSelected: (_) =>
                                    setState(() => _travelStyle = style),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Travel theme',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: TravelTheme.values.map((theme) {
                              return ChoiceChip(
                                label: Text(theme.label),
                                selected: _travelTheme == theme,
                                selectedColor: themeColor(
                                  theme,
                                ).withValues(alpha: 0.16),
                                onSelected: (_) =>
                                    setState(() => _travelTheme = theme),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Add another leisure',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Mix more than one leisure so the generated program can combine desert, sea, heritage, birdwatching, wellness, or other specific interests.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: curatedLeisureTags.map((activity) {
                              final selected = _selectedActivities.contains(
                                activity,
                              );
                              return FilterChip(
                                label: Text(activity),
                                selected: selected,
                                selectedColor: AppColors.mistBlue,
                                onSelected: (_) {
                                  setState(() {
                                    selected
                                        ? _selectedActivities.remove(activity)
                                        : _selectedActivities.add(activity);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Activity level',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: ActivityLevel.values.map((level) {
                              return ChoiceChip(
                                label: Text(level.label),
                                selected: _activityLevel == level,
                                onSelected: (_) =>
                                    setState(() => _activityLevel = level),
                              );
                            }).toList(),
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
                            'Preferred regions',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Select one or several regions. The planner can now build the same program across more than one curated region.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: curatedGovernorates.map((governorate) {
                              final selected = _selectedRegions.contains(
                                governorate.id,
                              );
                              return FilterChip(
                                label: Text(governorate.name),
                                selected: selected,
                                onSelected: (_) {
                                  setState(() {
                                    selected
                                        ? _selectedRegions.remove(
                                            governorate.id,
                                          )
                                        : _selectedRegions.add(governorate.id);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Sensitive motorized offers and hunting-style activities stay off-catalog until partner validation and insurance checks are confirmed.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: AppColors.deepBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick summary',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_travelStyle.label} trip - ${_travelTheme.label} theme - ${formatCurrency(_budget)} - ${_dateRange.duration.inDays + 1} days',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.94),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedRegionNames.isEmpty
                                ? 'Route mode: auto across Bizerte, Le Kef, and Tozeur.'
                                : 'Route mode: ${selectedRegionNames.join(', ')}.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                          ),
                          if (_selectedActivities.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              'Extra leisure: ${_selectedActivities.join(', ')}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.88),
                                  ),
                            ),
                          ],
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: _isGenerating ? null : _generate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.deepBlue,
                            ),
                            child: Text(
                              _isGenerating
                                  ? 'Generating...'
                                  : 'Generate Trip Plan',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.sandDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.deepBlue),
            const SizedBox(height: 12),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
