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
class StaffMember {
  final int id;
  final String name;
  final String phone;
  final StaffRole role;
  final String? avatarUrl;
  final bool isActive;
  final DateTime hireDate;
  final int branchId;
  final String branchName;

  const StaffMember({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.avatarUrl,
    required this.isActive,
    required this.hireDate,
    required this.branchId,
    required this.branchName,
  });

  factory StaffMember.fromJson(Map<String, dynamic> json) {
    return StaffMember(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: StaffRole.fromString(json['role'] as String),
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      hireDate: DateTime.parse(json['hire_date'] as String),
      branchId: json['branch_id'] as int,
      branchName: json['branch_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role.name,
      'avatar_url': avatarUrl,
      'is_active': isActive,
      'hire_date': hireDate.toIso8601String(),
      'branch_id': branchId,
      'branch_name': branchName,
    };
  }

  StaffMember copyWith({
    int? id,
    String? name,
    String? phone,
    StaffRole? role,
    String? avatarUrl,
    bool? isActive,
    DateTime? hireDate,
    int? branchId,
    String? branchName,
  }) {
    return StaffMember(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      hireDate: hireDate ?? this.hireDate,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaffMember &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'StaffMember(id: $id, name: $name, role: ${role.displayName})';
}
