import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../domain/loyalty_notifier.dart';
import '../domain/loyalty_state.dart';

/// Màn hình hướng dẫn cách tích điểm và hiển thị QR cá nhân.
class EarnPointsScreen extends ConsumerStatefulWidget {
  const EarnPointsScreen({super.key});

  @override
  ConsumerState<EarnPointsScreen> createState() => _EarnPointsScreenState();
}

class _EarnPointsScreenState extends ConsumerState<EarnPointsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = ref.read(loyaltyNotifierProvider);
      if (state is LoyaltyInitial) {
        ref.read(loyaltyNotifierProvider.notifier).loadDashboard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loyaltyState = ref.watch(loyaltyNotifierProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.earnPointsTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current points summary
            if (loyaltyState is LoyaltyLoaded) ...[
              _PointsSummaryCard(
                availablePoints:
                    loyaltyState.dashboard.member.availablePoints.toInt(),
                tierName: loyaltyState.dashboard.tier.name,
                multiplier: loyaltyState.dashboard.tier.pointMultiplier,
              ),
              const SizedBox(height: 20),

              // Member QR code
              _MemberQRCard(
                memberId: loyaltyState.dashboard.member.id,
                phone: loyaltyState.dashboard.member.phone,
              ),
              const SizedBox(height: 24),
            ],

            Text(
              l10n.earnPointsMethods,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            // Earning methods
            _EarnMethodCard(
              icon: Icons.qr_code_scanner,
              title: l10n.earnPointsCheckin,
              description: l10n.earnPointsCheckinDesc,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            _EarnMethodCard(
              icon: Icons.shopping_bag_outlined,
              title: l10n.earnPointsOrder,
              description: l10n.earnPointsOrderDesc,
              color: AppColors.success,
            ),
            const SizedBox(height: 12),
            _EarnMethodCard(
              icon: Icons.local_fire_department_outlined,
              title: l10n.earnPointsStreak,
              description: l10n.earnPointsStreakDesc,
              color: AppColors.warning,
            ),
            const SizedBox(height: 12),
            _EarnMethodCard(
              icon: Icons.card_giftcard_outlined,
              title: l10n.earnPointsPromo,
              description: l10n.earnPointsPromoDesc,
              color: AppColors.info,
            ),

            const SizedBox(height: 32),

            // Quick action: check-in
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push(AppRoutes.checkin),
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(l10n.earnPointsCheckinNow),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Member QR code card ------------------------------------------------------

class _MemberQRCard extends StatelessWidget {
  const _MemberQRCard({required this.memberId, required this.phone});

  final int memberId;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    // QR data: member_id for cashier to scan and earn points
    final qrData = 'comtammatu://member/$memberId';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              l10n.earnPointsMyQR,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 180,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: AppColors.primary,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.earnPointsShowQR,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// -- Points summary card ------------------------------------------------------

class _PointsSummaryCard extends StatelessWidget {
  const _PointsSummaryCard({
    required this.availablePoints,
    required this.tierName,
    required this.multiplier,
  });

  final int availablePoints;
  final String tierName;
  final double multiplier;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Card(
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.earnPointsCurrentPoints,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$availablePoints',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l10n.earnPointsTierMultiplier(
                    tierName, multiplier.toStringAsFixed(1)),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Earning method card ------------------------------------------------------

class _EarnMethodCard extends StatelessWidget {
  const _EarnMethodCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
