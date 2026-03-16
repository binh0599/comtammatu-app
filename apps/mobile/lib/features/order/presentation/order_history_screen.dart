import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/delivery_order.dart';
import '../../../shared/utils/formatters.dart';
import '../../../shared/widgets/app_button.dart';
import '../domain/order_history_notifier.dart';

// -- Filter ----------------------------------------------------------------

enum OrderFilter { all, delivering, delivered, cancelled }

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

String _filterLabel(OrderFilter filter) {
  return switch (filter) {
    OrderFilter.all => 'Tất cả',
    OrderFilter.delivering => 'Đang giao',
    OrderFilter.delivered => 'Hoàn thành',
    OrderFilter.cancelled => 'Đã hủy',
  };
}

/// Maps an [OrderFilter] enum to the API status string (null = all).
String? _filterToStatus(OrderFilter filter) {
  return switch (filter) {
    OrderFilter.all => null,
    OrderFilter.delivering => 'delivering',
    OrderFilter.delivered => 'delivered',
    OrderFilter.cancelled => 'cancelled',
  };
}

// -- Screen -----------------------------------------------------------------

/// Order history screen showing past orders with status filters and actions.
class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  OrderFilter _activeFilter = OrderFilter.all;

  @override
  void initState() {
    super.initState();
    // Trigger initial load after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderHistoryNotifierProvider.notifier).loadOrders();
    });
  }

  void _onFilterSelected(OrderFilter filter) {
    setState(() => _activeFilter = filter);
    ref
        .read(orderHistoryNotifierProvider.notifier)
        .setFilter(_filterToStatus(filter));
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(orderHistoryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đơn hàng'),
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: OrderFilter.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = OrderFilter.values[index];
                final isSelected = _activeFilter == filter;
                return ChoiceChip(
                  label: Text(_filterLabel(filter)),
                  selected: isSelected,
                  onSelected: (_) => _onFilterSelected(filter),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13,
                  ),
                  backgroundColor: AppColors.surface,
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                  showCheckmark: false,
                );
              },
            ),
          ),

          // Content area
          Expanded(
            child: _buildContent(context, historyState),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, OrderHistoryState state) {
    // Loading state
    if (state.isLoading) {
      return _buildLoadingShimmer();
    }

    // Error state
    if (state.error != null) {
      return _buildErrorState(context, state.error!);
    }

    // Empty state
    if (state.orders.isEmpty) {
      return _buildEmptyState(context, _activeFilter);
    }

    // Orders list with pull-to-refresh
    return RefreshIndicator(
      onRefresh: ref.read(orderHistoryNotifierProvider.notifier).refresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.orders.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == state.orders.length) {
            // Load more trigger
            _triggerLoadMore();
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _OrderCard(order: state.orders[index]);
        },
      ),
    );
  }

  void _triggerLoadMore() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderHistoryNotifierProvider.notifier).loadMore();
    });
  }

  Widget _buildLoadingShimmer() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => _ShimmerCard(),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Không thể tải đơn hàng',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Thử lại',
              icon: Icons.refresh,
              fullWidth: false,
              onPressed: () {
                ref.read(orderHistoryNotifierProvider.notifier).refresh();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, OrderFilter filter) {
    final message = switch (filter) {
      OrderFilter.all => 'Chưa có đơn hàng nào',
      OrderFilter.delivering => 'Không có đơn đang giao',
      OrderFilter.delivered => 'Chưa có đơn hoàn thành',
      OrderFilter.cancelled => 'Không có đơn đã hủy',
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (filter == OrderFilter.all) ...[
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
          ],
        ),
      ),
    );
  }
}

// -- Shimmer placeholder card -----------------------------------------------

class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(width: 100, height: 16),
                _shimmerBox(width: 72, height: 22, radius: 20),
              ],
            ),
            const SizedBox(height: 12),
            _shimmerBox(width: 140, height: 12),
            const SizedBox(height: 8),
            _shimmerBox(width: double.infinity, height: 12),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(width: 90, height: 16),
                _shimmerBox(width: 80, height: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({
    required double height,
    double? width,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(radius),
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
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isDelivering
            ? () {
                context.go('${AppRoutes.delivery}/${order.orderId}');
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(order.status).withValues(alpha: 0.1),
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
                  const Icon(
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

              // Points earned
              if (isCompleted && order.pointsWillEarn > 0) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star,
                        size: 14, color: AppColors.secondary),
                    const SizedBox(width: 4),
                    Text(
                      '+${order.pointsWillEarn} điểm',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 8),

              // Total + actions
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isDelivering)
                        TextButton.icon(
                          onPressed: () {
                            context
                                .go('${AppRoutes.delivery}/${order.orderId}');
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
                      if (isCompleted) ...[
                        TextButton.icon(
                          onPressed: () {
                            context.push(
                              '${AppRoutes.feedback}?orderId=${order.orderId}',
                            );
                          },
                          icon:
                              const Icon(Icons.rate_review_outlined, size: 18),
                          label: const Text('Đánh giá'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.secondary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
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
                                horizontal: 8, vertical: 4),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ],
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
