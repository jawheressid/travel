import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../theme/app_colors.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionControllerProvider);
    final favorites = ref.watch(favoritesControllerProvider).valueOrNull ?? {};
    final bookings = ref.watch(bookingsControllerProvider).valueOrNull ?? [];
    final isSupabaseEnabled = ref.watch(
      environmentProvider.select((value) => value.isSupabaseConfigured),
    );

    return SafeArea(
      child: AppAsyncValueWidget(
        value: sessionAsync,
        loadingMessage: 'Loading profile...',
        builder: (session) {
          final user = session.user;
          if (user == null) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.sand,
                        child: Text(
                          user.fullName.substring(0, 1).toUpperCase(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        user.fullName,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(user.email),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: isSupabaseEnabled
                              ? AppColors.success.withValues(alpha: 0.12)
                              : AppColors.warning.withValues(alpha: 0.12),
                        ),
                        child: Text(
                          isSupabaseEnabled
                              ? 'Supabase sync is enabled.'
                              : 'Demo data mode is enabled until Supabase keys are added.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _ProfileStat(
                        label: 'Favorites',
                        value: '${favorites.length}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ProfileStat(
                        label: 'Bookings',
                        value: '${bookings.length}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Selected interests',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: user.selectedInterests
                      .map((interest) => Chip(label: Text(interest.label)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(sessionControllerProvider.notifier)
                        .signOut();
                    if (context.mounted) {
                      context.go('/auth');
                    }
                  },
                  child: const Text('Sign out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}
