import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/cart_item.dart';
import '../../../shared/extensions/context_extensions.dart';
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

String _paymentLabel(BuildContext context, PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cod:
      return context.l10n.cartPaymentCod;
    case PaymentMethod.momo:
      return context.l10n.cartPaymentMomo;
    case PaymentMethod.zalopay:
      return context.l10n.cartPaymentZalopay;
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
        title: Text(context.l10n.cart),
        actions: [
          if (!cartState.isEmpty)
            TextButton(
              onPressed: () {
                ref.read(cartNotifierProvider.notifier).clearCart();
              },
              child: Text(
                context.l10n.cartClearAll,
                style: const TextStyle(color: AppColors.error),
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
              context.l10n.emptyCart,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.cartEmptyMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: context.l10n.cartViewMenu,
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
    final selectedPayment = _paymentMethodFromString(cartState.paymentMethod);
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
                      context.l10n.cartDeliveryAddress,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      cartState.deliveryAddress ?? context.l10n.cartNoAddress,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        context.push(AppRoutes.savedAddresses);
                      },
                      child: Text(context.l10n.cartSelectAddress),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Payment method
                Text(
                  context.l10n.cartPaymentMethod,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Column(
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
                            groupValue: selectedPayment,
                            onChanged: (v) {
                              if (v != null) {
                                ref
                                    .read(cartNotifierProvider.notifier)
                                    .setPaymentMethod(
                                        _paymentMethodToString(v));
                              }
                            },
                            title: Text(
                              _paymentLabel(context, method),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            secondary: Icon(
                              _paymentIcon(method),
                              color: AppColors.textSecondary,
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            activeColor: AppColors.primary,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      )
                      .toList(),
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
                          context.l10n.cartOrderDetails,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        _SummaryRow(
                          label: context.l10n.cartSubtotal,
                          value: _formatPrice(subtotal),
                        ),
                        const SizedBox(height: 8),
                        _SummaryRow(
                          label: context.l10n.cartDeliveryFee,
                          value: _formatPrice(deliveryFee),
                        ),
                        if (discount > 0) ...[
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: context.l10n.cartDiscount,
                            value: '-${_formatPrice(discount)}',
                            valueColor: AppColors.success,
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        _SummaryRow(
                          label: context.l10n.cartTotal,
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
                        context.l10n.cartTotal,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      Text(
                        _formatPrice(total),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AppButton(
                    label: context.l10n.cartPlaceOrder,
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
        SnackBar(
          content: Text(context.l10n.orderSuccess),
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
                        padding: const EdgeInsets.symmetric(horizontal: 14),
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
                hintText: context.l10n.cartNoteHint,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textHint,
                    ),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
