import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../../loyalty/domain/loyalty_notifier.dart';
import '../../loyalty/domain/loyalty_state.dart';

// -- Helpers --------------------------------------------------------------

Color _tierColor(String tierCode) {
  return switch (tierCode) {
    'silver' => AppColors.tierSilver,
    'gold' => AppColors.tierGold,
    'diamond' => AppColors.tierDiamond,
    _ => AppColors.tierBronze,
  };
}

// -- Screen ---------------------------------------------------------------

/// Profile screen with user info, tier badge, and settings menu.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(AppRoutes.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Avatar & user info
            const _UserHeader(),

            const SizedBox(height: 24),

            // Quick actions
            const _QuickActions(),

            const SizedBox(height: 16),

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

class _UserHeader extends ConsumerWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final loyaltyState = ref.watch(loyaltyNotifierProvider);

    // Extract user info from auth state
    final String displayName;
    final String displayPhone;
    if (authState is Authenticated) {
      final user = authState.user;
      displayName = user.userMetadata?['full_name'] as String? ?? 'Người dùng';
      displayPhone = user.phone ?? '';
    } else {
      displayName = 'Người dùng';
      displayPhone = '';
    }

    // Extract loyalty info
    final String tierName;
    final String pointsText;
    final Color tierColor;
    if (loyaltyState is LoyaltyLoaded) {
      final dashboard = loyaltyState.dashboard;
      tierName = 'Hạng ${dashboard.tier.name}';
      final pts = dashboard.member.availablePoints.toInt();
      pointsText = '$pts điểm tích lũy';
      tierColor = _tierColor(dashboard.tier.tierCode);
    } else {
      tierName = '';
      pointsText = '';
      tierColor = AppColors.tierBronze;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(AppRoutes.profileEdit),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Avatar
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.person,
                        size: 44,
                        color: AppColors.primary,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Name
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayPhone,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 12),

                // Tier badge (only show if loyalty data loaded)
                if (tierName.isNotEmpty) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          tierColor,
                          tierColor.withValues(alpha: 0.7),
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
                          tierName,
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
                    pointsText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -- Quick actions --------------------------------------------------------

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _QuickActionItem(
            icon: Icons.receipt_long_outlined,
            label: 'Đơn hàng',
            onTap: () => context.go(AppRoutes.orders),
          ),
          const SizedBox(width: 12),
          _QuickActionItem(
            icon: Icons.local_offer_outlined,
            label: 'Ưu đãi',
            onTap: () => context.push(AppRoutes.vouchers),
          ),
          const SizedBox(width: 12),
          _QuickActionItem(
            icon: Icons.store_outlined,
            label: 'Cửa hàng',
            onTap: () => context.go(AppRoutes.storeLocator),
          ),
          const SizedBox(width: 12),
          _QuickActionItem(
            icon: Icons.star_outline,
            label: 'Tích điểm',
            onTap: () => context.go(AppRoutes.loyalty),
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              children: [
                Icon(icon, color: AppColors.primary, size: 28),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -- Menu section ---------------------------------------------------------

class _MenuSection extends ConsumerWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onTap: () => context.push(AppRoutes.orders),
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.person_outline,
              label: 'Chỉnh sửa thông tin',
              onTap: () => context.push(AppRoutes.profileEdit),
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.location_on_outlined,
              label: 'Địa chỉ đã lưu',
              onTap: () => context.push(AppRoutes.savedAddresses),
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.local_offer_outlined,
              label: 'Ưu đãi của tôi',
              onTap: () => context.push(AppRoutes.vouchers),
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.settings_outlined,
              label: 'Cài đặt',
              onTap: () => context.push(AppRoutes.settings),
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              label: 'Hỗ trợ',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Liên hệ hotline: 1900 1234'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const Divider(height: 1, indent: 56),
            _ProfileMenuItem(
              icon: Icons.logout,
              label: 'Đăng xuất',
              isDestructive: true,
              onTap: () {
                showDialog<void>(
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
                          ref.read(authNotifierProvider.notifier).signOut();
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
