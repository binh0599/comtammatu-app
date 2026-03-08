import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/staff_member.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../domain/staff_notifier.dart';

// ---------------------------------------------------------------------------
// Sample data provider (thay thế bằng API thực tế sau)
// ---------------------------------------------------------------------------

final _sampleStaffProvider = Provider<List<StaffMember>>((ref) {
  return [
    StaffMember(
      id: 1,
      name: 'Nguyễn Văn An',
      phone: '0901234567',
      role: StaffRole.manager,
      isActive: true,
      hireDate: DateTime(2023, 1, 15),
      branchId: 1,
      branchName: 'Chi nhánh Quận 1',
    ),
    StaffMember(
      id: 2,
      name: 'Trần Thị Bích',
      phone: '0912345678',
      role: StaffRole.cashier,
      isActive: true,
      hireDate: DateTime(2023, 3, 20),
      branchId: 1,
      branchName: 'Chi nhánh Quận 1',
    ),
    StaffMember(
      id: 3,
      name: 'Lê Minh Châu',
      phone: '0923456789',
      role: StaffRole.chef,
      isActive: true,
      hireDate: DateTime(2023, 5, 10),
      branchId: 1,
      branchName: 'Chi nhánh Quận 1',
    ),
    StaffMember(
      id: 4,
      name: 'Phạm Đức Dũng',
      phone: '0934567890',
      role: StaffRole.waiter,
      isActive: true,
      hireDate: DateTime(2023, 7, 1),
      branchId: 1,
      branchName: 'Chi nhánh Quận 1',
    ),
    StaffMember(
      id: 5,
      name: 'Hoàng Thị Lan',
      phone: '0945678901',
      role: StaffRole.chef,
      isActive: false,
      hireDate: DateTime(2023, 2, 28),
      branchId: 2,
      branchName: 'Chi nhánh Quận 3',
    ),
    StaffMember(
      id: 6,
      name: 'Võ Thanh Hải',
      phone: '0956789012',
      role: StaffRole.waiter,
      isActive: true,
      hireDate: DateTime(2023, 9, 15),
      branchId: 2,
      branchName: 'Chi nhánh Quận 3',
    ),
    StaffMember(
      id: 7,
      name: 'Đặng Thị Mai',
      phone: '0967890123',
      role: StaffRole.inventory,
      isActive: true,
      hireDate: DateTime(2024, 1, 5),
      branchId: 2,
      branchName: 'Chi nhánh Quận 3',
    ),
    StaffMember(
      id: 8,
      name: 'Bùi Quốc Nam',
      phone: '0978901234',
      role: StaffRole.manager,
      isActive: false,
      hireDate: DateTime(2023, 6, 12),
      branchId: 2,
      branchName: 'Chi nhánh Quận 3',
    ),
  ];
});

// ---------------------------------------------------------------------------
// Local state providers
// ---------------------------------------------------------------------------

/// Bộ lọc vai trò hiện tại (null = Tất cả).
final _roleFilterProvider = StateProvider<StaffRole?>((ref) => null);

/// Danh sách nhân viên có thể thay đổi (thêm / toggle active).
final _staffListProvider =
    StateNotifierProvider<_StaffListNotifier, List<StaffMember>>((ref) {
  final sample = ref.read(_sampleStaffProvider);
  return _StaffListNotifier(sample);
});

class _StaffListNotifier extends StateNotifier<List<StaffMember>> {
  _StaffListNotifier(super.initial);

  void add(StaffMember member) {
    state = [...state, member];
  }

  void toggleActive(int id) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(isActive: !s.isActive) else s,
    ];
  }

  void update(StaffMember updated) {
    state = [
      for (final s in state)
        if (s.id == updated.id) updated else s,
    ];
  }
}

/// Danh sách nhân viên đã lọc theo vai trò.
final _filteredStaffProvider = Provider<List<StaffMember>>((ref) {
  final all = ref.watch(_staffListProvider);
  final filter = ref.watch(_roleFilterProvider);
  if (filter == null) return all;
  return all.where((s) => s.role == filter).toList();
});

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Trả về màu tương ứng với vai trò nhân viên.
Color _roleColor(StaffRole role) {
  switch (role) {
    case StaffRole.cashier:
      return AppColors.info;
    case StaffRole.chef:
      return AppColors.warning;
    case StaffRole.waiter:
      return AppColors.success;
    case StaffRole.manager:
      return AppColors.primary;
    case StaffRole.inventory:
      return AppColors.secondary;
    case StaffRole.hr:
      return AppColors.textSecondary;
  }
}

/// Định dạng ngày kiểu Việt Nam.
String _formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// Màn hình quản lý nhân viên.
class StaffManagementScreen extends ConsumerWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allStaff = ref.watch(_staffListProvider);
    final filteredStaff = ref.watch(_filteredStaffProvider);
    final roleFilter = ref.watch(_roleFilterProvider);

    final activeCount = allStaff.where((s) => s.isActive).length;
    final inactiveCount = allStaff.length - activeCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Quản lý nhân viên'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Thêm nhân viên',
            onPressed: () => _showAddStaffDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // ---- Staff count summary ----
          _StaffCountSummary(
            total: allStaff.length,
            active: activeCount,
            inactive: inactiveCount,
          ),

          // ---- Role filter chips ----
          _RoleFilterChips(
            selected: roleFilter,
            onSelected: (role) =>
                ref.read(_roleFilterProvider.notifier).state = role,
          ),

          // ---- Staff list ----
          Expanded(
            child: filteredStaff.isEmpty
                ? const EmptyView(
                    message: 'Không tìm thấy nhân viên nào',
                    icon: Icons.person_off_outlined,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredStaff.length,
                    itemBuilder: (context, index) {
                      final member = filteredStaff[index];
                      return _StaffCard(
                        member: member,
                        onTap: () =>
                            _showDetailBottomSheet(context, ref, member),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Staff count summary
// ---------------------------------------------------------------------------

class _StaffCountSummary extends StatelessWidget {
  const _StaffCountSummary({
    required this.total,
    required this.active,
    required this.inactive,
  });

  final int total;
  final int active;
  final int inactive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _CountItem(
            label: 'Tổng cộng',
            count: total,
            color: AppColors.textPrimary,
          ),
          const _VerticalDivider(),
          _CountItem(
            label: 'Đang làm',
            count: active,
            color: AppColors.success,
          ),
          const _VerticalDivider(),
          _CountItem(
            label: 'Nghỉ việc',
            count: inactive,
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class _CountItem extends StatelessWidget {
  const _CountItem({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.border,
    );
  }
}

// ---------------------------------------------------------------------------
// Role filter chips
// ---------------------------------------------------------------------------

class _RoleFilterChips extends StatelessWidget {
  const _RoleFilterChips({
    required this.selected,
    required this.onSelected,
  });

  final StaffRole? selected;
  final ValueChanged<StaffRole?> onSelected;

  static const _filterRoles = [
    null, // Tất cả
    StaffRole.cashier,
    StaffRole.chef,
    StaffRole.waiter,
    StaffRole.manager,
    StaffRole.inventory,
  ];

  String _label(StaffRole? role) {
    if (role == null) return 'Tất cả';
    return role.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterRoles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final role = _filterRoles[index];
          final isSelected = selected == role;
          return ChoiceChip(
            label: Text(_label(role)),
            selected: isSelected,
            onSelected: (_) => onSelected(role),
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            backgroundColor: AppColors.surface,
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Staff card
// ---------------------------------------------------------------------------

class _StaffCard extends StatelessWidget {
  const _StaffCard({
    required this.member,
    required this.onTap,
  });

  final StaffMember member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _roleColor(member.role);
    final initial = member.name.isNotEmpty ? member.name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: color.withOpacity(0.15),
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              member.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Active dot
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: member.isActive
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        member.phone,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Role badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              member.role.displayName,
                              style: TextStyle(
                                color: color,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.textHint,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              member.branchName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textHint),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textHint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail bottom sheet
// ---------------------------------------------------------------------------

void _showDetailBottomSheet(
  BuildContext context,
  WidgetRef ref,
  StaffMember member,
) {
  final color = _roleColor(member.role);
  final initial = member.name.isNotEmpty ? member.name[0].toUpperCase() : '?';

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Avatar
            CircleAvatar(
              radius: 36,
              backgroundColor: color.withOpacity(0.15),
              child: Text(
                initial,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Name
            Text(
              member.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Role badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                member.role.displayName,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Info rows
            _DetailInfoRow(
              icon: Icons.phone_outlined,
              label: 'Số điện thoại',
              value: member.phone,
            ),
            _DetailInfoRow(
              icon: Icons.location_on_outlined,
              label: 'Chi nhánh',
              value: member.branchName,
            ),
            _DetailInfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Ngày vào làm',
              value: _formatDate(member.hireDate),
            ),
            _DetailInfoRow(
              icon: Icons.circle,
              label: 'Trạng thái',
              value: member.isActive ? 'Đang làm việc' : 'Đã nghỉ việc',
              valueColor: member.isActive ? AppColors.success : AppColors.error,
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final uri = Uri(scheme: 'tel', path: member.phone);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Gọi điện'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.info,
                      side: const BorderSide(color: AppColors.info),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showEditStaffDialog(context, ref, member);
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Chỉnh sửa'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Toggle active
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref
                      .read(_staffListProvider.notifier)
                      .toggleActive(member.id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        member.isActive
                            ? '${member.name} đã được đánh dấu nghỉ việc'
                            : '${member.name} đã được kích hoạt lại',
                      ),
                      backgroundColor: member.isActive
                          ? AppColors.warning
                          : AppColors.success,
                    ),
                  );
                },
                icon: Icon(
                  member.isActive
                      ? Icons.person_off_outlined
                      : Icons.person_add_outlined,
                ),
                label: Text(
                  member.isActive
                      ? 'Đánh dấu nghỉ việc'
                      : 'Kích hoạt lại',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: member.isActive
                      ? AppColors.error
                      : AppColors.success,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _DetailInfoRow extends StatelessWidget {
  const _DetailInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textHint),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Add staff dialog
// ---------------------------------------------------------------------------

void _showAddStaffDialog(BuildContext context, WidgetRef ref) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  StaffRole selectedRole = StaffRole.waiter;
  int selectedBranchId = 1;
  String selectedBranchName = 'Chi nhánh Quận 1';
  final formKey = GlobalKey<FormState>();

  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Thêm nhân viên mới'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Họ và tên',
                        hintText: 'Nhập họ và tên nhân viên',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập họ tên';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        hintText: 'Nhập số điện thoại',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        if (value.trim().length < 10) {
                          return 'Số điện thoại không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<StaffRole>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        labelText: 'Vai trò',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      items: StaffRole.values
                          .where((r) => r != StaffRole.hr)
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role.displayName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedRole = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedBranchId,
                      decoration: const InputDecoration(
                        labelText: 'Chi nhánh',
                        prefixIcon: Icon(Icons.store_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Chi nhánh Quận 1'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Chi nhánh Quận 3'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedBranchId = value;
                            selectedBranchName = value == 1
                                ? 'Chi nhánh Quận 1'
                                : 'Chi nhánh Quận 3';
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Huỷ'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final allStaff = ref.read(_staffListProvider);
                    final newId = allStaff.isEmpty
                        ? 1
                        : allStaff
                                .map((s) => s.id)
                                .reduce((a, b) => a > b ? a : b) +
                            1;

                    final newMember = StaffMember(
                      id: newId,
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      role: selectedRole,
                      isActive: true,
                      hireDate: DateTime.now(),
                      branchId: selectedBranchId,
                      branchName: selectedBranchName,
                    );

                    ref.read(_staffListProvider.notifier).add(newMember);
                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Đã thêm nhân viên ${newMember.name}',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Thêm'),
              ),
            ],
          );
        },
      );
    },
  );
}

// ---------------------------------------------------------------------------
// Edit staff dialog
// ---------------------------------------------------------------------------

void _showEditStaffDialog(
  BuildContext context,
  WidgetRef ref,
  StaffMember member,
) {
  final nameController = TextEditingController(text: member.name);
  final phoneController = TextEditingController(text: member.phone);
  StaffRole selectedRole = member.role;
  int selectedBranchId = member.branchId;
  String selectedBranchName = member.branchName;
  final formKey = GlobalKey<FormState>();

  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Chỉnh sửa nhân viên'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Họ và tên',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập họ tên';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        if (value.trim().length < 10) {
                          return 'Số điện thoại không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<StaffRole>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        labelText: 'Vai trò',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      items: StaffRole.values
                          .where((r) => r != StaffRole.hr)
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role.displayName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedRole = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedBranchId,
                      decoration: const InputDecoration(
                        labelText: 'Chi nhánh',
                        prefixIcon: Icon(Icons.store_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Chi nhánh Quận 1'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Chi nhánh Quận 3'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedBranchId = value;
                            selectedBranchName = value == 1
                                ? 'Chi nhánh Quận 1'
                                : 'Chi nhánh Quận 3';
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Huỷ'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final updated = member.copyWith(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      role: selectedRole,
                      branchId: selectedBranchId,
                      branchName: selectedBranchName,
                    );

                    ref.read(_staffListProvider.notifier).update(updated);
                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Đã cập nhật thông tin ${updated.name}',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Lưu'),
              ),
            ],
          );
        },
      );
    },
  );
}
