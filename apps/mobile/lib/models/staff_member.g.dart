// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffMemberImpl _$$StaffMemberImplFromJson(Map<String, dynamic> json) =>
    _$StaffMemberImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: $enumDecode(_$StaffRoleEnumMap, json['role']),
      hireDate: DateTime.parse(json['hire_date'] as String),
      branchId: (json['branch_id'] as num).toInt(),
      branchName: json['branch_name'] as String,
      isActive: json['is_active'] as bool? ?? true,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$StaffMemberImplToJson(_$StaffMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'role': _$StaffRoleEnumMap[instance.role]!,
      'hire_date': instance.hireDate.toIso8601String(),
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'is_active': instance.isActive,
      'avatar_url': instance.avatarUrl,
    };

const _$StaffRoleEnumMap = {
  StaffRole.cashier: 'cashier',
  StaffRole.chef: 'chef',
  StaffRole.waiter: 'waiter',
  StaffRole.manager: 'manager',
  StaffRole.inventory: 'inventory',
  StaffRole.hr: 'hr',
};
