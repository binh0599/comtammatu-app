import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_member.freezed.dart';
part 'staff_member.g.dart';

/// Vai trò nhân viên trong hệ thống.
enum StaffRole {
  cashier,
  chef,
  waiter,
  manager,
  inventory,
  hr;

  /// Tên hiển thị tiếng Việt.
  String get displayName {
    switch (this) {
      case StaffRole.cashier:
        return 'Thu ngân';
      case StaffRole.chef:
        return 'Đầu bếp';
      case StaffRole.waiter:
        return 'Phục vụ';
      case StaffRole.manager:
        return 'Quản lý';
      case StaffRole.inventory:
        return 'Kho';
      case StaffRole.hr:
        return 'Nhân sự';
    }
  }

  /// Parse từ JSON string.
  static StaffRole fromString(String value) {
    return StaffRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => StaffRole.waiter,
    );
  }
}

/// Nhân viên trong hệ thống quản lý.
@freezed
class StaffMember with _$StaffMember {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StaffMember({
    required int id,
    required String name,
    required String phone,
    required StaffRole role,
    required DateTime hireDate,
    required int branchId,
    required String branchName,
    @Default(true) bool isActive,
    String? avatarUrl,
  }) = _StaffMember;

  factory StaffMember.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberFromJson(json);
}
