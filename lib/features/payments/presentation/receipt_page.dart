import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../theme/app_colors.dart';

class ReceiptPage extends ConsumerWidget {
  const ReceiptPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(bookingsControllerProvider);
    final payment = ref.watch(paymentReceiptProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Invoice / receipt')),
      body: SafeArea(
        child: AppAsyncValueWidget(
          value: bookingsAsync,
          builder: (bookings) {
            final booking = bookings.firstWhere((item) => item.id == bookingId);
            final success = booking.paymentStatus == PaymentStatus.success;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: success
                          ? AppColors.success.withValues(alpha: 0.12)
                          : AppColors.danger.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          success ? 'Payment successful' : 'Payment failed',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          success
                              ? 'Your booking is confirmed and ready for follow-up.'
                              : 'Your booking remains pending. Retry payment from the cart or payment screen.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _ReceiptRow(label: 'Booking ID', value: booking.id),
                  _ReceiptRow(label: 'Status', value: booking.status.name),
                  _ReceiptRow(
                    label: 'Payment status',
                    value: booking.paymentStatus.name,
                  ),
                  _ReceiptRow(
                    label: 'Amount',
                    value: formatCurrency(booking.totalAmount),
                  ),
                  if (payment != null) ...[
                    _ReceiptRow(label: 'Provider', value: payment.provider),
                    _ReceiptRow(
                      label: 'Reference',
                      value: payment.providerReference,
                    ),
                    _ReceiptRow(
                      label: 'Paid at',
                      value: payment.paidAt == null
                          ? 'Not captured'
                          : formatLongDate(payment.paidAt!),
                    ),
                  ],
                  const SizedBox(height: 22),
                  Text(
                    'Booked items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...booking.items.map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.type.label),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Text(
                        formatCurrency(item.unitPrice * item.quantity),
                      ),
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

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
