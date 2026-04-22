import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../theme/app_colors.dart';

class BookingsPage extends ConsumerWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(bookingsControllerProvider);

    return BrandBackground(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: SafeArea(
        child: AppAsyncValueWidget(
          value: bookingsAsync,
          loadingMessage: 'Loading bookings...',
          builder: (bookings) {
            if (bookings.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 8),
                child: EmptyStateCard(
                  title: 'No bookings yet',
                  message:
                      'Confirmed and pending reservations will appear here after checkout.',
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
              itemCount: bookings.length + 1,
              separatorBuilder: (_, index) =>
                  SizedBox(height: index == 0 ? 18 : 14),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SectionHeader(
                    title: 'Your bookings',
                    subtitle:
                        'Track every confirmed or pending reservation in one elegant timeline.',
                  );
                }

                final booking = bookings[index - 1];
                final accent = booking.status == BookingStatus.confirmed
                    ? AppColors.success
                    : AppColors.warning;

                return BrandPanel(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              booking.status == BookingStatus.confirmed
                                  ? 'Confirmed booking'
                                  : 'Pending booking',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: accent.withValues(alpha: 0.34),
                              ),
                            ),
                            child: Text(
                              booking.paymentStatus.name
                                  .replaceAll('_', ' ')
                                  .toUpperCase(),
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.4,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Items: ${booking.items.length}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.86),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total: ${formatCurrency(booking.totalAmount)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.86),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.createdAt == null
                            ? 'Created recently'
                            : formatLongDate(booking.createdAt!),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
