import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_async_value_widget.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../theme/app_colors.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  late final TextEditingController _promoController;

  @override
  void initState() {
    super.initState();
    _promoController = TextEditingController(
      text: ref.read(checkoutPromoCodeProvider),
    );
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final total = ref.watch(cartTotalProvider);
    final catalogAsync = ref.watch(catalogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Booking cart')),
      body: SafeArea(
        child: AppAsyncValueWidget(
          value: catalogAsync,
          builder: (catalog) {
            if (cart.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: EmptyStateCard(
                  title: 'Your cart is empty',
                  message:
                      'Add stays, activities, or transport from a place page or itinerary.',
                  actionLabel: 'Explore places',
                  onAction: () => context.go('/explore'),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...cart.map((item) {
                    final place = catalog.places.firstWhere(
                      (element) => element.id == item.placeId,
                    );
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
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
                                  place.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              IconButton(
                                onPressed: () => ref
                                    .read(cartControllerProvider.notifier)
                                    .removePlace(item.placeId),
                                icon: const Icon(Icons.delete_outline_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${place.type.label} · ${formatCurrency(item.unitPrice)}',
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton.outlined(
                                onPressed: () => ref
                                    .read(cartControllerProvider.notifier)
                                    .changeQuantity(
                                      item.placeId,
                                      item.quantity - 1,
                                    ),
                                icon: const Icon(Icons.remove_rounded),
                              ),
                              const SizedBox(width: 12),
                              Text('${item.quantity}'),
                              const SizedBox(width: 12),
                              IconButton.filled(
                                onPressed: () => ref
                                    .read(cartControllerProvider.notifier)
                                    .changeQuantity(
                                      item.placeId,
                                      item.quantity + 1,
                                    ),
                                icon: const Icon(Icons.add_rounded),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _promoController,
                    decoration: const InputDecoration(
                      labelText: 'Promo code',
                      hintText: 'Use FREELOCAL for a demo discount',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ref.read(checkoutPromoCodeProvider.notifier).state =
                            _promoController.text.trim();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Promo code applied to checkout.'),
                          ),
                        );
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: AppColors.deepBlue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip breakdown',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${cart.length} items in cart · Total ${formatCurrency(total)}',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.92),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.push('/payment'),
                    child: const Text('Proceed to payment'),
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
