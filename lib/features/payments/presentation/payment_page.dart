import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../theme/app_colors.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  PaymentMethod _method = PaymentMethod.card;
  bool _simulateFailure = false;
  bool _isPaying = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final total = ref.watch(cartTotalProvider);
    final promoCode = ref.watch(checkoutPromoCodeProvider);
    final previewTotal = promoCode.toUpperCase() == 'FREELOCAL'
        ? total * 0.9
        : total;
    final catalogAsync = ref.watch(catalogProvider);

    return Scaffold(
      body: BrandBackground(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: SafeArea(
          child: AppAsyncValueWidget(
            value: catalogAsync,
            builder: (catalog) {
              if (cart.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: EmptyStateCard(
                    title: 'No pending checkout',
                    message:
                        'Your booking cart is empty. Add at least one item before paying.',
                    actionLabel: 'Back to cart',
                    onAction: () => context.go('/cart'),
                  ),
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
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const Spacer(),
                        const BrandWordmark(compact: true),
                        const Spacer(),
                        Text(
                          formatCurrency(previewTotal),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.deepBlue,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Secure Checkout',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppColors.mediterraneanBlue,
                      ),
                    ),
                    const SizedBox(height: 18),
                    BrandPanel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trip breakdown',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          ...cart.map((item) {
                            final place = catalog.places.firstWhere(
                              (element) => element.id == item.placeId,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          place.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${item.type.label} - x${item.quantity}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(
                                      item.unitPrice * item.quantity,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const Divider(),
                          _SummaryRow(
                            label: 'Subtotal',
                            value: formatCurrency(total),
                          ),
                          if (promoCode.isNotEmpty)
                            _SummaryRow(
                              label: 'Promo code',
                              value: promoCode.toUpperCase() == 'FREELOCAL'
                                  ? '-10%'
                                  : 'No discount',
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
                            'Payment method',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 14),
                          ...PaymentMethod.values.map(
                            (method) => _MethodTile(
                              label: switch (method) {
                                PaymentMethod.card => 'Card / demo checkout',
                                PaymentMethod.wallet => 'Local wallet',
                                PaymentMethod.cash => 'Pay locally on arrival',
                              },
                              subtitle: switch (method) {
                                PaymentMethod.card =>
                                  'Fastest option for the mock payment flow.',
                                PaymentMethod.wallet =>
                                  'Good for testing alternate payment states.',
                                PaymentMethod.cash =>
                                  'Use a pay-later style confirmation flow.',
                              },
                              icon: switch (method) {
                                PaymentMethod.card => Icons.credit_card_rounded,
                                PaymentMethod.wallet =>
                                  Icons.account_balance_wallet_rounded,
                                PaymentMethod.cash => Icons.payments_rounded,
                              },
                              selected: _method == method,
                              onTap: () => setState(() => _method = method),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            value: _simulateFailure,
                            onChanged: (value) =>
                                setState(() => _simulateFailure = value),
                            title: const Text('Simulate payment failure'),
                            subtitle: const Text(
                              'Useful for testing failed checkout and receipt states.',
                            ),
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
                            'Today you pay',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.94),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatCurrency(previewTotal),
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: _isPaying
                                ? null
                                : () async {
                                    setState(() => _isPaying = true);
                                    final result = await ref
                                        .read(
                                          bookingsControllerProvider.notifier,
                                        )
                                        .checkout(
                                          cartItems: cart,
                                          method: _method,
                                          currency: 'TND',
                                          promoCode: promoCode.isEmpty
                                              ? null
                                              : promoCode,
                                          simulateFailure: _simulateFailure,
                                          itineraryId: ref
                                              .read(selectedItineraryProvider)
                                              ?.id,
                                        );
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(result.message)),
                                      );
                                      context.go(
                                        '/receipt/${result.booking.id}',
                                      );
                                    }
                                    if (mounted) {
                                      setState(() => _isPaying = false);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.deepBlue,
                            ),
                            child: Text(
                              _isPaying ? 'Processing...' : 'Confirm and Pay',
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

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: selected
                ? AppColors.mediterraneanBlue.withValues(alpha: 0.10)
                : AppColors.offWhite,
            border: Border.all(
              color: selected
                  ? AppColors.mediterraneanBlue
                  : AppColors.sandDark,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(icon, color: AppColors.deepBlue),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.mediterraneanBlue,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
