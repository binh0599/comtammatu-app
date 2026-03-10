import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/staff_member.dart';

/// Repository cho các thao tác quản lý nhân viên.
class StaffRepository {
  const StaffRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Lấy danh sách nhân viên, có thể lọc theo chi nhánh.
  Future<List<StaffMember>> getStaff({int? branchId}) async {
    return _apiClient.get<List<StaffMember>>(
      '/staff-management',
      queryParameters: {
        'action': 'list',
        if (branchId != null) 'branch_id': branchId,
      },
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        final list = map['staff'] as List<dynamic>? ?? [];
        return list
            .map((e) => StaffMember.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Thêm nhân viên mới.
  Future<StaffMember> addStaff({
    required String name,
    required String phone,
    required StaffRole role,
    required int branchId,
    required String branchName,
  }) async {
    return _apiClient.post<StaffMember>(
      '/staff-management',
      data: {
        'action': 'add',
        'name': name,
        'phone': phone,
        'role': role.name,
        'branch_id': branchId,
        'branch_name': branchName,
      },
      fromJson: (json) =>
          StaffMember.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Cập nhật thông tin nhân viên.
  Future<StaffMember> updateStaff({
    required int staffId,
    String? name,
    String? phone,
    StaffRole? role,
    int? branchId,
    String? branchName,
  }) async {
    return _apiClient.post<StaffMember>(
      '/staff-management',
      data: {
        'action': 'update',
        'staff_id': staffId,
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (role != null) 'role': role.name,
        if (branchId != null) 'branch_id': branchId,
        if (branchName != null) 'branch_name': branchName,
      },
      fromJson: (json) =>
          StaffMember.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Kích hoạt hoặc vô hiệu hoá nhân viên.
  Future<StaffMember> toggleActive({required int staffId}) async {
    return _apiClient.post<StaffMember>(
      '/staff-management',
      data: {
        'action': 'toggle_active',
        'staff_id': staffId,
      },
      fromJson: (json) =>
          StaffMember.fromJson(json as Map<String, dynamic>),
    );
  }
}

/// Riverpod provider cho [StaffRepository].
final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return StaffRepository(apiClient: apiClient);
});
