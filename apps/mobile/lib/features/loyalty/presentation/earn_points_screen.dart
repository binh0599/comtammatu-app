import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cách tích điểm')),
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
              const SizedBox(height: 24),
            ],

            Text(
              'Các cách tích điểm',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            // Earning methods
            const _EarnMethodCard(
              icon: Icons.qr_code_scanner,
              title: 'Điểm danh tại quán',
              description:
                  'Quét mã QR tại quầy mỗi lần đến ăn. Nhận 10 điểm/lần điểm danh.',
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            const _EarnMethodCard(
              icon: Icons.shopping_bag_outlined,
              title: 'Đặt hàng',
              description:
                  'Mỗi đơn hàng được tích 1 điểm cho mỗi 10.000đ. Hạng cao hơn có nhân điểm.',
              color: AppColors.success,
            ),
            const SizedBox(height: 12),
            const _EarnMethodCard(
              icon: Icons.local_fire_department_outlined,
              title: 'Chuỗi điểm danh',
              description:
                  'Điểm danh liên tiếp 7 ngày nhận bonus 50 điểm. 30 ngày nhận 200 điểm.',
              color: AppColors.warning,
            ),
            const SizedBox(height: 12),
            const _EarnMethodCard(
              icon: Icons.card_giftcard_outlined,
              title: 'Khuyến mãi đặc biệt',
              description:
                  'Theo dõi mục Voucher để nhận điểm thưởng từ các chương trình khuyến mãi.',
              color: AppColors.info,
            ),

            const SizedBox(height: 32),

            // Quick action: check-in
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push(AppRoutes.checkin),
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Điểm danh ngay'),
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

// -- Points summary card ---------------------------------------------------

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
                    'Điểm hiện có',
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
                'Hạng $tierName · x${multiplier.toStringAsFixed(1)}',
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

// -- Earning method card ---------------------------------------------------

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
