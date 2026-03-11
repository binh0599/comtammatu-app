import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/dashboard_stats.dart';

/// Repository cho các API bảng điều khiển quản lý.
class DashboardRepository {
  const DashboardRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Lấy dữ liệu tổng quan bảng điều khiển.
  Future<DashboardStats> getStats() async {
    return _apiClient.get<DashboardStats>(
      '/dashboard-stats',
      fromJson: (json) => DashboardStats.fromJson(json as Map<String, dynamic>),
    );
  }
}

/// Riverpod provider cho [DashboardRepository].
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRepository(apiClient: apiClient);
});
