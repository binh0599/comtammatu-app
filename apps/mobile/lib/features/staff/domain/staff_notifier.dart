import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/staff_member.dart';
import '../data/staff_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

/// Trạng thái danh sách nhân viên.
sealed class StaffListState {
  const StaffListState();
}

class StaffInitial extends StaffListState {
  const StaffInitial();
}

class StaffLoading extends StaffListState {
  const StaffLoading();
}

class StaffLoaded extends StaffListState {
  const StaffLoaded({required this.staff});
  final List<StaffMember> staff;
}

class StaffError extends StaffListState {
  const StaffError({required this.message});
  final String message;
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

/// Quản lý trạng thái danh sách nhân viên.
class StaffNotifier extends StateNotifier<StaffListState> {
  StaffNotifier({required StaffRepository staffRepository})
      : _staffRepository = staffRepository,
        super(const StaffInitial());

  final StaffRepository _staffRepository;

  /// Tải danh sách nhân viên từ API.
  Future<void> loadStaff() async {
    state = const StaffLoading();
    try {
      final staff = await _staffRepository.getStaff();
      state = StaffLoaded(staff: staff);
    } catch (e) {
      state = StaffError(message: e.toString());
    }
  }

  /// Thêm nhân viên mới rồi tải lại danh sách.
  Future<void> addStaff({
    required String name,
    required String phone,
    required StaffRole role,
    required int branchId,
    required String branchName,
  }) async {
    try {
      await _staffRepository.addStaff(
        name: name,
        phone: phone,
        role: role,
        branchId: branchId,
        branchName: branchName,
      );
      await loadStaff();
    } catch (e) {
      rethrow;
    }
  }

  /// Cập nhật thông tin nhân viên rồi tải lại danh sách.
  Future<void> updateStaff({
    required int staffId,
    String? name,
    String? phone,
    StaffRole? role,
    int? branchId,
    String? branchName,
  }) async {
    try {
      await _staffRepository.updateStaff(
        staffId: staffId,
        name: name,
        phone: phone,
        role: role,
        branchId: branchId,
        branchName: branchName,
      );
      await loadStaff();
    } catch (e) {
      rethrow;
    }
  }

  /// Bật / tắt trạng thái hoạt động của nhân viên.
  Future<void> toggleActive({required int staffId}) async {
    try {
      await _staffRepository.toggleActive(staffId: staffId);
      await loadStaff();
    } catch (e) {
      rethrow;
    }
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

/// Provider chính cho StaffNotifier.
final staffNotifierProvider =
    StateNotifierProvider.autoDispose<StaffNotifier, StaffListState>((ref) {
  final repo = ref.watch(staffRepositoryProvider);
  return StaffNotifier(staffRepository: repo);
});

/// Provider lọc nhân viên theo vai trò.
final staffRoleFilterProvider = StateProvider.autoDispose<StaffRole?>((ref) => null);

/// Provider danh sách nhân viên đã lọc theo vai trò.
final filteredStaffProvider = Provider.autoDispose<List<StaffMember>>((ref) {
  final state = ref.watch(staffNotifierProvider);
  final roleFilter = ref.watch(staffRoleFilterProvider);

  if (state is! StaffLoaded) return [];

  final staff = state.staff;
  if (roleFilter == null) return staff;

  return staff.where((s) => s.role == roleFilter).toList();
});
