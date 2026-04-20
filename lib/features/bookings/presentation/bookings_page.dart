import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/empty_state_card.dart';

class BookingsPage extends ConsumerWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(bookingsControllerProvider);

    return SafeArea(
      child: AppAsyncValueWidget(
        value: bookingsAsync,
        loadingMessage: 'Loading bookings...',
        builder: (bookings) {
          if (bookings.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: EmptyStateCard(
                title: 'No bookings yet',
                message:
                    'Confirmed and pending reservations will appear here after checkout.',
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            itemCount: bookings.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
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
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Chip(label: Text(booking.paymentStatus.name)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Items: ${booking.items.length}'),
                    Text('Total: ${formatCurrency(booking.totalAmount)}'),
                    Text(
                      booking.createdAt == null
                          ? 'Created recently'
                          : formatLongDate(booking.createdAt!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
