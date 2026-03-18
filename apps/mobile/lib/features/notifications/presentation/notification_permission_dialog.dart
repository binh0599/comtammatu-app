import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/extensions/context_extensions.dart';
import 'notification_service.dart';

/// Key dùng để lưu trạng thái đã hỏi quyền thông báo.
const _kNotificationPermissionAsked = 'notification_permission_asked';

/// Kiểm tra và hiển thị dialog xin quyền thông báo nếu chưa hỏi.
///
/// Gọi trong [HomeScreen.initState] sau delay ngắn để không
/// chặn trải nghiệm người dùng ngay khi vào app.
Future<void> showNotificationPermissionIfNeeded(BuildContext context) async {
  final prefs = SharedPreferences.getInstance();
  final asked = (await prefs).getBool(_kNotificationPermissionAsked) ?? false;
  if (asked) return;

  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => const _NotificationPermissionSheet(),
  );
}

class _NotificationPermissionSheet extends ConsumerWidget {
  const _NotificationPermissionSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
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
            const SizedBox(height: 24),

            // Icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_active_outlined,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              l10n.notifPermissionTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              l10n.notifPermissionDescription,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Benefits list
            _BenefitRow(
              icon: Icons.receipt_long_outlined,
              text: l10n.notifPermissionBenefitOrders,
            ),
            _BenefitRow(
              icon: Icons.local_offer_outlined,
              text: l10n.notifPermissionBenefitPromotions,
            ),
            _BenefitRow(
              icon: Icons.star_outline,
              text: l10n.notifPermissionBenefitPoints,
            ),

            const SizedBox(height: 24),

            // Enable button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _handleEnable(context),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(l10n.notifPermissionEnable),
              ),
            ),
            const SizedBox(height: 8),

            // Skip button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => _handleSkip(context),
                child: Text(l10n.notifPermissionSkip),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleEnable(BuildContext context) async {
    await _markAsked();
    await NotificationService.instance.requestPermission();
    if (context.mounted) Navigator.of(context).pop();
  }

  Future<void> _handleSkip(BuildContext context) async {
    await _markAsked();
    if (context.mounted) Navigator.of(context).pop();
  }

  Future<void> _markAsked() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kNotificationPermissionAsked, true);
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
