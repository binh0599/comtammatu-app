import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/cart_item.dart';
import '../../../shared/widgets/app_button.dart';
import '../domain/cart_notifier.dart';

// -- Data models kept for UI only -----------------------------------------

enum PaymentMethod { cod, momo, zalopay }

// -- Helpers --------------------------------------------------------------

String _formatPrice(double price) {
  final intPrice = price.round();
  final str = intPrice.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
    buffer.write(str[i]);
  }
  buffer.write('\u20ab');
  return buffer.toString();
}

String _paymentLabel(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cod:
      return 'Thanh to\u00e1n khi nh\u1eadn h\u00e0ng';
    case PaymentMethod.momo:
      return 'V\u00ed MoMo';
    case PaymentMethod.zalopay:
      return 'ZaloPay';
  }
}

IconData _paymentIcon(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cod:
      return Icons.payments_outlined;
    case PaymentMethod.momo:
      return Icons.account_balance_wallet_outlined;
    case PaymentMethod.zalopay:
      return Icons.account_balance_wallet;
  }
}

/// Maps [PaymentMethod] enum to the string value stored in [CartState].
String _paymentMethodToString(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cod:
      return 'cod';
    case PaymentMethod.momo:
      return 'momo';
    case PaymentMethod.zalopay:
      return 'zalopay';
  }
}

PaymentMethod _paymentMethodFromString(String value) {
  switch (value) {
    case 'momo':
      return PaymentMethod.momo;
    case 'zalopay':
      return PaymentMethod.zalopay;
    default:
      return PaymentMethod.cod;
  }
}

// -- Screen ---------------------------------------------------------------

/// Cart screen with item list, order summary, and checkout.
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gi\u1ecf h\u00e0ng'),
        actions: [
          if (!cartState.isEmpty)
            TextButton(
              onPressed: () {
                ref.read(cartNotifierProvider.notifier).clearCart();
              },
              child: const Text(
                'X\u00f3a t\u1ea5t c\u1ea3',
                style: TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: cartState.isEmpty ? const _EmptyCart() : const _CartContent(),
    );
  }
}

// -- Empty state ----------------------------------------------------------

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'Gi\u1ecf h\u00e0ng tr\u1ed1ng',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'H\u00e3y th\u00eam m\u00f3n \u0103n t\u1eeb th\u1ef1c \u0111\u01a1n\n\u0111\u1ec3 b\u1eaft \u0111\u1ea7u \u0111\u1eb7t h\u00e0ng nh\u00e9!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Xem th\u1ef1c \u0111\u01a1n',
              icon: Icons.restaurant_menu,
              fullWidth: false,
              onPressed: () {
                context.go(AppRoutes.menu);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// -- Cart content ---------------------------------------------------------

class _CartContent extends ConsumerWidget {
  const _CartContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final items = cartState.items;
    final subtotal = cartState.subtotal;
    final deliveryFee = cartState.deliveryFee;
    final discount = cartState.discount;
    final total = cartState.total;
    final selectedPayment =
        _paymentMethodFromString(cartState.paymentMethod);
    final isSubmitting = cartState.isSubmitting;

    // Listen for orderError changes to show snackbar
    ref.listen<String?>(
      cartNotifierProvider.select((s) => s.orderError),
      (previous, next) {
        if (next != null && next.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart items
                ...items.map(
                  (item) => _CartItemTile(
                    item: item,
                    onQuantityChanged: (qty) {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .updateQuantity(item.menuItem.id, qty);
                    },
                    onNoteChanged: (note) {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .updateNote(item.menuItem.id, note);
                    },
                    onRemove: () {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .removeItem(item.menuItem.id);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Delivery address
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      '\u0110\u1ecba ch\u1ec9 giao h\u00e0ng',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      cartState.deliveryAddress ?? 'Ch\u01b0a ch\u1ecdn \u0111\u1ecba ch\u1ec9',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        context.push(AppRoutes.savedAddresses);
                      },
                      child: const Text('Ch\u1ecdn \u0111\u1ecba ch\u1ec9'),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Payment method
                Text(
                  'Ph\u01b0\u01a1ng th\u1ee9c thanh to\u00e1n',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                RadioGroup<PaymentMethod>(
                  groupValue: selectedPayment,
                  onChanged: (v) {
                    if (v != null) {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .setPaymentMethod(_paymentMethodToString(v));
                    }
                  },
                  child: Column(
                    children: PaymentMethod.values
                        .map(
                          (method) => Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: selectedPayment == method
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: selectedPayment == method ? 1.5 : 1,
                              ),
                            ),
                            child: RadioListTile<PaymentMethod>(
                              value: method,
                              title: Text(
                                _paymentLabel(method),
                                style:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                              secondary: Icon(
                                _paymentIcon(method),
                                color: AppColors.textSecondary,
                              ),
                              controlAffinity:
                                  ListTileControlAffinity.trailing,
                              activeColor: AppColors.primary,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                          ),
                        ),
                      )
                        .toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // Order summary
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chi ti\u1ebft \u0111\u01a1n h\u00e0ng',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        _SummaryRow(
                          label: 'T\u1ea1m t\u00ednh',
                          value: _formatPrice(subtotal),
                        ),
                        const SizedBox(height: 8),
                        _SummaryRow(
                          label: 'Ph\u00ed giao h\u00e0ng',
                          value: _formatPrice(deliveryFee),
                        ),
                        if (discount > 0) ...[
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'Gi\u1ea3m gi\u00e1',
                            value: '-${_formatPrice(discount)}',
                            valueColor: AppColors.success,
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        _SummaryRow(
                          label: 'T\u1ed5ng c\u1ed9ng',
                          value: _formatPrice(total),
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Bottom CTA
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'T\u1ed5ng c\u1ed9ng',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      Text(
                        _formatPrice(total),
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AppButton(
                    label: '\u0110\u1eb7t h\u00e0ng',
                    icon: Icons.shopping_bag_outlined,
                    isLoading: isSubmitting,
                    onPressed: isSubmitting
                        ? null
                        : () => _handleCheckout(context, ref),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleCheckout(BuildContext context, WidgetRef ref) async {
    await ref.read(cartNotifierProvider.notifier).placeOrder();

    if (!context.mounted) return;

    final cartState = ref.read(cartNotifierProvider);

    if (cartState.orderError == null && !cartState.isSubmitting) {
      // Order succeeded — cart was cleared by placeOrder()
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('\u0110\u1eb7t h\u00e0ng th\u00e0nh c\u00f4ng!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.go(AppRoutes.orders);
    }
    // Error case is handled by ref.listen in build()
  }
}

// -- Cart item tile -------------------------------------------------------

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.item,
    required this.onQuantityChanged,
    required this.onNoteChanged,
    required this.onRemove,
  });

  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<String> onNoteChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.menuItem.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close,
                      size: 20, color: AppColors.textHint),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _formatPrice(item.menuItem.price),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 10),

            // Quantity & subtotal
            Row(
              children: [
                // Quantity controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _QtyButton(
                        icon: Icons.remove,
                        onTap: () => onQuantityChanged(item.quantity - 1),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '${item.quantity}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      _QtyButton(
                        icon: Icons.add,
                        onTap: () => onQuantityChanged(item.quantity + 1),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  _formatPrice(item.total),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Note field
            TextField(
              onChanged: onNoteChanged,
              controller: TextEditingController(text: item.note ?? ''),
              decoration: InputDecoration(
                hintText:
                    'Ghi ch\u00fa (vd: \u00edt h\u00e0nh, th\u00eam n\u01b0\u1edbc m\u1eafm...)',
                hintStyle:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textHint,
                        ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// -- Quantity button -------------------------------------------------------

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}

// -- Summary row ----------------------------------------------------------

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
        ),
        Text(
          value,
          style: isBold
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: valueColor ?? AppColors.primary,
                    fontWeight: FontWeight.w700,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: valueColor,
                  ),
        ),
      ],
    );
  }
}
