import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/formatters.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../models/delivery_order.dart';

// -- Sample data for development --------------------------------------------

final _kSampleOrders = [
  DeliveryOrder(
    orderId: 10245,
    deliveryOrderId: 5012,
    status: 'delivered',
    items: const [
      OrderItem(
        menuItemId: 1,
        name: 'Cơm tấm sườn bì chả',
        quantity: 2,
        unitPrice: 55000,
        subtotal: 110000,
      ),
      OrderItem(
        menuItemId: 9,
        name: 'Trà đá',
        quantity: 2,
        unitPrice: 5000,
        subtotal: 10000,
      ),
    ],
    subtotal: 120000,
    deliveryFee: 15000,
    discount: 0,
    total: 135000,
    estimatedDeliveryAt: DateTime.now().subtract(const Duration(days: 2)),
    pointsWillEarn: 135,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  DeliveryOrder(
    orderId: 10300,
    deliveryOrderId: 5067,
    status: 'delivering',
    items: const [
      OrderItem(
        menuItemId: 4,
        name: 'Cơm tấm đặc biệt',
        quantity: 1,
        unitPrice: 65000,
        subtotal: 65000,
      ),
      OrderItem(
        menuItemId: 11,
        name: 'Nước sâm',
        quantity: 1,
        unitPrice: 15000,
        subtotal: 15000,
      ),
    ],
    subtotal: 80000,
    deliveryFee: 15000,
    discount: 10000,
    total: 85000,
    estimatedDeliveryAt: DateTime.now().add(const Duration(minutes: 25)),
    pointsWillEarn: 85,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  DeliveryOrder(
    orderId: 10189,
    deliveryOrderId: 4950,
    status: 'delivered',
    items: const [
      OrderItem(
        menuItemId: 2,
        name: 'Cơm tấm sườn nướng',
        quantity: 1,
        unitPrice: 45000,
        subtotal: 45000,
      ),
    ],
    subtotal: 45000,
    deliveryFee: 15000,
    discount: 0,
    total: 60000,
    estimatedDeliveryAt: DateTime.now().subtract(const Duration(days: 5)),
    pointsWillEarn: 60,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  DeliveryOrder(
    orderId: 10120,
    deliveryOrderId: 4880,
    status: 'cancelled',
    items: const [
      OrderItem(
        menuItemId: 1,
        name: 'Cơm tấm sườn bì chả',
        quantity: 3,
        unitPrice: 55000,
        subtotal: 165000,
      ),
    ],
    subtotal: 165000,
    deliveryFee: 15000,
    discount: 0,
    total: 180000,
    estimatedDeliveryAt: DateTime.now().subtract(const Duration(days: 7)),
    pointsWillEarn: 0,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
];

// -- Providers --------------------------------------------------------------

final orderHistoryProvider =
    StateProvider<List<DeliveryOrder>>((ref) => _kSampleOrders);

// -- Helpers ----------------------------------------------------------------

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

Color _statusColor(String status) {
  switch (status) {
    case 'delivered':
      return AppColors.success;
    case 'delivering':
    case 'on_the_way':
    case 'picked_up':
      return AppColors.info;
    case 'pending':
    case 'confirmed':
    case 'preparing':
      return AppColors.warning;
    case 'cancelled':
      return AppColors.error;
    default:
      return AppColors.textSecondary;
  }
}

String _statusLabel(String status) {
  switch (status) {
    case 'delivered':
      return 'Hoàn thành';
    case 'delivering':
    case 'on_the_way':
      return 'Đang giao';
    case 'picked_up':
      return 'Đã lấy hàng';
    case 'pending':
      return 'Chờ xác nhận';
    case 'confirmed':
      return 'Đã xác nhận';
    case 'preparing':
      return 'Đang chuẩn bị';
    case 'cancelled':
      return 'Đã hủy';
    default:
      return status;
  }
}

// -- Screen -----------------------------------------------------------------

/// Order history screen showing past orders with status chips.
class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đơn hàng'),
      ),
      body: orders.isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _OrderCard(order: orders[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có đơn hàng nào',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hãy đặt món từ thực đơn\nđể bắt đầu nhé!',
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
              onPressed: () => context.go(AppRoutes.menu),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Order card -------------------------------------------------------------

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final DeliveryOrder order;

  @override
  Widget build(BuildContext context) {
    final isDelivering = order.status == 'delivering' ||
        order.status == 'on_the_way' ||
        order.status == 'picked_up';
    final isCompleted = order.status == 'delivered';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isDelivering
            ? () {
                context.go(
                    '${AppRoutes.delivery}/${order.orderId}');
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: order ID + status chip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đơn #${order.orderId}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          _statusColor(order.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel(order.status),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _statusColor(order.status),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    Formatters.dateTime(order.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Items summary
              Text(
                order.items.map((i) => '${i.name} x${i.quantity}').join(', '),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Total + action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatPrice(order.total.toInt()),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  if (isDelivering)
                    TextButton.icon(
                      onPressed: () {
                        context.go(
                            '${AppRoutes.delivery}/${order.orderId}');
                      },
                      icon: const Icon(Icons.delivery_dining, size: 18),
                      label: const Text('Theo dõi'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  if (isCompleted)
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Đang thêm các món vào giỏ hàng...'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.replay, size: 18),
                      label: const Text('Đặt lại'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
