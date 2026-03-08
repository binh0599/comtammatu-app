import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';

// -- Data models ----------------------------------------------------------

class CartItem {
  CartItem({
    required this.id,
    required this.name,
    required this.unitPrice,
    this.quantity = 1,
    this.note = '',
  });

  final int id;
  final String name;
  final int unitPrice;
  int quantity;
  String note;

  int get subtotal => unitPrice * quantity;
}

enum PaymentMethod { cod, momo, zalopay }

// -- Sample data ----------------------------------------------------------

final _kSampleCart = [
  CartItem(id: 1, name: 'Cơm tấm sườn bì chả', unitPrice: 55000, quantity: 2),
  CartItem(id: 2, name: 'Trà đá', unitPrice: 5000, quantity: 2),
  CartItem(id: 3, name: 'Chả trứng', unitPrice: 10000),
];

// -- Providers ------------------------------------------------------------

final cartItemsProvider =
    StateProvider<List<CartItem>>((ref) => List.of(_kSampleCart));

final selectedPaymentProvider =
    StateProvider<PaymentMethod>((ref) => PaymentMethod.cod);

final deliveryFeeProvider = Provider<int>((ref) => 15000);

final discountProvider = Provider<int>((ref) => 0);

final cartSubtotalProvider = Provider<int>((ref) {
  final items = ref.watch(cartItemsProvider);
  return items.fold<int>(0, (sum, item) => sum + item.subtotal);
});

final cartTotalProvider = Provider<int>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final delivery = ref.watch(deliveryFeeProvider);
  final discount = ref.watch(discountProvider);
  return subtotal + delivery - discount;
});

// -- Helpers --------------------------------------------------------------

String _formatPrice(int price) {
  final str = price.toString();
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
      return 'Thanh toán khi nhận hàng';
    case PaymentMethod.momo:
      return 'Ví MoMo';
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

// -- Screen ---------------------------------------------------------------

/// Cart screen with item list, order summary, and checkout.
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(cartItemsProvider.notifier).state = [];
              },
              child: Text(
                'Xóa tất cả',
                style: TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: items.isEmpty ? const _EmptyCart() : const _CartContent(),
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
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'Giỏ hàng trống',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hãy thêm món ăn từ thực đơn\nđể bắt đầu đặt hàng nhé!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Xem thực đơn',
              icon: Icons.restaurant_menu,
              fullWidth: false,
              onPressed: () {
                // TODO: Navigate to menu
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
    final items = ref.watch(cartItemsProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final deliveryFee = ref.watch(deliveryFeeProvider);
    final discount = ref.watch(discountProvider);
    final total = ref.watch(cartTotalProvider);
    final selectedPayment = ref.watch(selectedPaymentProvider);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart items
                ...items.asMap().entries.map(
                      (entry) => _CartItemTile(
                        item: entry.value,
                        onQuantityChanged: (qty) {
                          final updated = List<CartItem>.from(items);
                          if (qty <= 0) {
                            updated.removeAt(entry.key);
                          } else {
                            updated[entry.key].quantity = qty;
                          }
                          ref.read(cartItemsProvider.notifier).state =
                              List.of(updated);
                        },
                        onNoteChanged: (note) {
                          final updated = List<CartItem>.from(items);
                          updated[entry.key].note = note;
                          ref.read(cartItemsProvider.notifier).state =
                              List.of(updated);
                        },
                        onRemove: () {
                          final updated = List<CartItem>.from(items);
                          updated.removeAt(entry.key);
                          ref.read(cartItemsProvider.notifier).state =
                              updated;
                        },
                      ),
                    ),

                const SizedBox(height: 20),

                // Delivery address
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.border),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      'Địa chỉ giao hàng',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      'Chưa chọn địa chỉ',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textHint,
                              ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        // TODO: Address picker
                      },
                      child: const Text('Chọn địa chỉ'),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Payment method
                Text(
                  'Phương thức thanh toán',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                ...PaymentMethod.values.map(
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
                          ref.read(selectedPaymentProvider.notifier).state =
                              v;
                        }
                      },
                      title: Text(
                        _paymentLabel(method),
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
                ),

                const SizedBox(height: 16),

                // Order summary
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chi tiết đơn hàng',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        _SummaryRow(
                          label: 'Tạm tính',
                          value: _formatPrice(subtotal),
                        ),
                        const SizedBox(height: 8),
                        _SummaryRow(
                          label: 'Phí giao hàng',
                          value: _formatPrice(deliveryFee),
                        ),
                        if (discount > 0) ...[
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'Giảm giá',
                            value: '-${_formatPrice(discount)}',
                            valueColor: AppColors.success,
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        _SummaryRow(
                          label: 'Tổng cộng',
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
                color: Colors.black.withOpacity(0.06),
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
                        'Tổng cộng',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      Text(
                        _formatPrice(total),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AppButton(
                    label: 'Đặt hàng',
                    icon: Icons.shopping_bag_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đang xử lý đơn hàng...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
        side: BorderSide(color: AppColors.border),
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
                    item.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(Icons.close, size: 20, color: AppColors.textHint),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _formatPrice(item.unitPrice),
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
                        onTap: () =>
                            onQuantityChanged(item.quantity - 1),
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
                        onTap: () =>
                            onQuantityChanged(item.quantity + 1),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  _formatPrice(item.subtotal),
                  style:
                      Theme.of(context).textTheme.titleSmall?.copyWith(
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
              decoration: InputDecoration(
                hintText: 'Ghi chú (vd: ít hành, thêm nước mắm...)',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textHint,
                    ),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.border),
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
