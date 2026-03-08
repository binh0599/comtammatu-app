import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

// -- Screen ---------------------------------------------------------------

/// Profile screen with user info, tier badge, and settings menu.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Avatar & user info
            const _UserHeader(),

            const SizedBox(height: 24),

            // Menu items
            const _MenuSection(),

            const SizedBox(height: 32),

            // App version
            Text(
              'Cơm Tấm Má Tư v1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// -- User header ----------------------------------------------------------

class _UserHeader extends StatelessWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Avatar
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 44,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),

              // Name
              Text(
                'Nguyễn Văn A',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '0901 234 567',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 12),

              // Tier badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.tierBronze,
                      AppColors.tierBronze.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.workspace_premium,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Hạng Đồng',
                      style:
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '1.250 điểm tích lũy',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -- Menu section ---------------------------------------------------------

class _MenuSection extends StatelessWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            _ProfileMenuItem(
              icon: Icons.receipt_long_outlined,
              label: 'Lịch sử đơn hàng',
              onTap: () {
                // TODO: Navigate to order history
              },
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.location_on_outlined,
              label: 'Địa chỉ đã lưu',
              onTap: () {
                // TODO: Navigate to saved addresses
              },
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.settings_outlined,
              label: 'Cài đặt',
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              label: 'Hỗ trợ',
              onTap: () {
                // TODO: Navigate to support
              },
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.logout,
              label: 'Đăng xuất',
              isDestructive: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Đăng xuất'),
                    content: const Text(
                      'Bạn có chắc chắn muốn đăng xuất không?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          // TODO: Call auth sign out
                        },
                        child: Text(
                          'Đăng xuất',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// -- Profile menu item ----------------------------------------------------

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;

    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: color,
            ),
      ),
      trailing: isDestructive
          ? null
          : Icon(
              Icons.chevron_right,
              color: AppColors.textHint,
            ),
      onTap: onTap,
    );
  }
}
