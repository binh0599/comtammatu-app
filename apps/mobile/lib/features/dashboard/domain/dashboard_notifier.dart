import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/dashboard_stats.dart';
import '../data/dashboard_repository.dart';

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
  DashboardNotifier({required DashboardRepository repository})
      : _repository = repository,
        super(const DashboardInitial());

  final DashboardRepository _repository;

  /// Tải dữ liệu bảng điều khiển từ Edge Function dashboard-stats.
  Future<void> loadDashboard() async {
    state = const DashboardLoading();
    try {
      final stats = await _repository.getStats();
      state = DashboardLoaded(stats: stats);
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
  final repo = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository: repo);
});
