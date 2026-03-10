import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/dashboard_stats.dart';
import '../../../shared/utils/formatters.dart';
import '../domain/dashboard_notifier.dart';

// ---------------------------------------------------------------------------
// Màn hình bảng điều khiển quản lý
// ---------------------------------------------------------------------------

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Tải dữ liệu khi khởi tạo màn hình
    Future.microtask(() {
      ref.read(dashboardNotifierProvider.notifier).loadDashboard();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(dashboardNotifierProvider.notifier).loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bảng điều khiển'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Điều hướng tới thông báo
            },
          ),
        ],
      ),
      body: switch (dashboardState) {
        DashboardInitial() || DashboardLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        DashboardError(:final message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onRefresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            ),
          ),
        DashboardLoaded(:final stats) => RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.primary,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _SummaryCardsGrid(stats: stats),
                const SizedBox(height: 16),
                _RevenueChartSection(weeklyRevenue: stats.weeklyRevenue),
                const SizedBox(height: 16),
                _PopularItemsSection(items: stats.popularItems),
                const SizedBox(height: 16),
                _OrderStatusSection(
                  completed: stats.completedOrders,
                  pending: stats.pendingOrders,
                  cancelled: stats.cancelledOrders,
                ),
                const SizedBox(height: 16),
                const _QuickActionsSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Lưới thẻ tóm tắt (2x2)
// ---------------------------------------------------------------------------

class _SummaryCardsGrid extends StatelessWidget {
  const _SummaryCardsGrid({required this.stats});

  final DashboardStats stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'Doanh thu hôm nay',
                value: Formatters.currency(stats.todayRevenue),
                icon: Icons.trending_up,
                iconColor: AppColors.success,
                subtitle: '+12% so với hôm qua',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                title: 'Đơn hàng hôm nay',
                value: '${stats.todayOrders}',
                icon: Icons.receipt_long,
                iconColor: AppColors.info,
                subtitle:
                    '${stats.completedOrders} xong - ${stats.pendingOrders} chờ',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'Giá trị trung bình',
                value: Formatters.currency(stats.avgOrderValue),
                icon: Icons.avg_pace,
                iconColor: AppColors.secondary,
                subtitle: 'Trên mỗi đơn hàng',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                title: 'Khách hàng mới',
                value: '${stats.newCustomersToday}',
                icon: Icons.person_add,
                iconColor: AppColors.primary,
                subtitle: 'Tổng: ${Formatters.number(stats.customerCount)}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.subtitle,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textHint,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Biểu đồ doanh thu tuần (CustomPainter)
// ---------------------------------------------------------------------------

class _RevenueChartSection extends StatelessWidget {
  const _RevenueChartSection({required this.weeklyRevenue});

  final List<DailyRevenue> weeklyRevenue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doanh thu tuần này',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: CustomPaint(
              size: Size.infinite,
              painter: _RevenueBarChartPainter(data: weeklyRevenue),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueBarChartPainter extends CustomPainter {
  _RevenueBarChartPainter({required this.data});

  final List<DailyRevenue> data;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxAmount = data.map((e) => e.amount).reduce(math.max).toDouble();
    if (maxAmount == 0) return;

    const bottomPadding = 28.0;
    const topPadding = 16.0;
    final chartHeight = size.height - bottomPadding - topPadding;
    final barWidth = (size.width / data.length) * 0.55;
    final spacing = size.width / data.length;

    // Vẽ đường lưới ngang
    final gridPaint = Paint()
      ..color = const Color(0xFFE0DCD7)
      ..strokeWidth = 0.5;

    for (var i = 0; i <= 4; i++) {
      final y = topPadding + chartHeight * (1 - i / 4);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Vẽ từng cột
    final barPaint = Paint()..color = const Color(0xFFD4442A);
    final highlightPaint = Paint()..color = const Color(0xFFF5A623);
    final labelStyle = TextStyle(
      color: const Color(0xFF78716C),
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );
    final valueStyle = TextStyle(
      color: const Color(0xFF1C1917),
      fontSize: 9,
      fontWeight: FontWeight.w600,
    );

    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      final barHeight = (item.amount / maxAmount) * chartHeight;
      final x = (spacing * i) + (spacing - barWidth) / 2;
      final y = topPadding + chartHeight - barHeight;

      // Cột cao nhất dùng màu nổi bật
      final isMax = item.amount == maxAmount.toInt();
      final paint = isMax ? highlightPaint : barPaint;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, paint);

      // Nhãn giá trị trên cột
      final valueTp = TextPainter(
        text: TextSpan(
          text: '${(item.amount / 1000000).toStringAsFixed(1)}tr',
          style: valueStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      valueTp.paint(
        canvas,
        Offset(x + (barWidth - valueTp.width) / 2, y - valueTp.height - 2),
      );

      // Nhãn ngày dưới cột
      final labelTp = TextPainter(
        text: TextSpan(text: item.day, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      labelTp.paint(
        canvas,
        Offset(
          x + (barWidth - labelTp.width) / 2,
          size.height - bottomPadding + 8,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RevenueBarChartPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}

// ---------------------------------------------------------------------------
// Danh sách món bán chạy
// ---------------------------------------------------------------------------

class _PopularItemsSection extends StatelessWidget {
  const _PopularItemsSection({required this.items});

  final List<PopularItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Món bán chạy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < items.length - 1 ? 10 : 0,
              ),
              child: Row(
                children: [
                  // Huy hiệu thứ hạng
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: index < 3
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.border.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: index < 3
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tên món
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Đã bán: ${item.count} phần',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Doanh thu
                  Text(
                    Formatters.currency(item.revenue),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Trạng thái đơn hàng
// ---------------------------------------------------------------------------

class _OrderStatusSection extends StatelessWidget {
  const _OrderStatusSection({
    required this.completed,
    required this.pending,
    required this.cancelled,
  });

  final int completed;
  final int pending;
  final int cancelled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Trạng thái đơn hàng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _StatusCard(
                label: 'Hoàn thành',
                count: completed,
                color: AppColors.success,
                icon: Icons.check_circle_outline,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatusCard(
                label: 'Đang xử lý',
                count: pending,
                color: AppColors.warning,
                icon: Icons.hourglass_bottom,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatusCard(
                label: 'Đã hủy',
                count: cancelled,
                color: AppColors.error,
                icon: Icons.cancel_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  final String label;
  final int count;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Thao tác nhanh
// ---------------------------------------------------------------------------

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Thao tác nhanh',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                label: 'Xem đơn hàng',
                icon: Icons.list_alt,
                color: AppColors.info,
                onTap: () {
                  // TODO: Điều hướng tới danh sách đơn hàng
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionButton(
                label: 'Quản lý nhân viên',
                icon: Icons.people_outline,
                color: AppColors.success,
                onTap: () {
                  // TODO: Điều hướng tới quản lý nhân viên
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionButton(
                label: 'Kho hàng',
                icon: Icons.inventory_2_outlined,
                color: AppColors.secondary,
                onTap: () {
                  // TODO: Điều hướng tới kho hàng
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
