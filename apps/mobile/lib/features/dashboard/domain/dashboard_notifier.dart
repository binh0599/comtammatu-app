import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/dashboard_stats.dart';

/// Trạng thái của bảng điều khiển quản lý.
sealed class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded({required this.stats});
  final DashboardStats stats;
}

class DashboardError extends DashboardState {
  const DashboardError({required this.message});
  final String message;
}

/// Quản lý trạng thái bảng điều khiển cho chủ/quản lý cửa hàng.
class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(const DashboardInitial());

  /// Tải dữ liệu bảng điều khiển.
  Future<void> loadDashboard() async {
    state = const DashboardLoading();
    try {
      // Giả lập gọi API với độ trễ mạng
      await Future<void>.delayed(const Duration(milliseconds: 800));

      const sampleStats = DashboardStats(
        todayRevenue: 4850000,
        todayOrders: 86,
        avgOrderValue: 56400,
        completedOrders: 72,
        cancelledOrders: 3,
        pendingOrders: 11,
        customerCount: 1245,
        newCustomersToday: 8,
        weeklyRevenue: [
          DailyRevenue(day: 'Thứ 2', amount: 3200000),
          DailyRevenue(day: 'Thứ 3', amount: 4100000),
          DailyRevenue(day: 'Thứ 4', amount: 3800000),
          DailyRevenue(day: 'Thứ 5', amount: 4500000),
          DailyRevenue(day: 'Thứ 6', amount: 5200000),
          DailyRevenue(day: 'Thứ 7', amount: 6100000),
          DailyRevenue(day: 'CN', amount: 4850000),
        ],
        popularItems: [
          PopularItem(
            name: 'Cơm tấm sườn bì chả',
            count: 42,
            revenue: 2520000,
          ),
          PopularItem(
            name: 'Cơm tấm đặc biệt',
            count: 28,
            revenue: 2240000,
          ),
          PopularItem(
            name: 'Cơm tấm sườn nướng',
            count: 25,
            revenue: 1500000,
          ),
          PopularItem(
            name: 'Trà đá',
            count: 65,
            revenue: 325000,
          ),
          PopularItem(
            name: 'Nước sâm',
            count: 18,
            revenue: 270000,
          ),
        ],
      );

      state = const DashboardLoaded(stats: sampleStats);
    } catch (e) {
      state = DashboardError(
        message: 'Không thể tải dữ liệu bảng điều khiển: $e',
      );
    }
  }
}

/// Provider cho trạng thái bảng điều khiển.
final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier();
});
