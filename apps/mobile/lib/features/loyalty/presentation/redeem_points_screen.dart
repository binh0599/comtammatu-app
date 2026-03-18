import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/loyalty_notifier.dart';
import '../domain/loyalty_state.dart';

/// Màn hình đổi điểm lấy phần thưởng.
class RedeemPointsScreen extends ConsumerStatefulWidget {
  const RedeemPointsScreen({super.key});

  @override
  ConsumerState<RedeemPointsScreen> createState() =>
      _RedeemPointsScreenState();
}

class _RedeemPointsScreenState extends ConsumerState<RedeemPointsScreen> {
  bool _isRedeeming = false;

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
      appBar: AppBar(title: const Text('Đổi điểm')),
      body: switch (loyaltyState) {
        LoyaltyLoading() || LoyaltyInitial() =>
          const Center(child: CircularProgressIndicator()),
        LoyaltyError(:final message) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline,
                    size: 48, color: AppColors.error),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.read(loyaltyNotifierProvider.notifier).loadDashboard(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        LoyaltyLoaded(:final dashboard) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Available points
                Card(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.stars, color: Colors.white, size: 32),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Điểm có thể đổi',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white70),
                              ),
                              Text(
                                '${dashboard.member.availablePoints.toInt()} điểm',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'Phần thưởng',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),

                // Reward list
                ..._rewards.map(
                  (reward) => _RewardCard(
                    reward: reward,
                    availablePoints:
                        dashboard.member.availablePoints.toInt(),
                    isRedeeming: _isRedeeming,
                    onRedeem: () => _handleRedeem(reward),
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }

  Future<void> _handleRedeem(_Reward reward) async {
    final loyaltyState = ref.read(loyaltyNotifierProvider);
    if (loyaltyState is! LoyaltyLoaded) return;

    final available = loyaltyState.dashboard.member.availablePoints.toInt();
    if (available < reward.pointsCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không đủ điểm để đổi phần thưởng này'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận đổi điểm'),
        content: Text(
          'Bạn muốn dùng ${reward.pointsCost} điểm để đổi "${reward.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Huỷ'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Đổi điểm'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isRedeeming = true);
    try {
      await ref.read(loyaltyNotifierProvider.notifier).redeemPoints(
            points: reward.pointsCost.toDouble(),
            rewardType: reward.type,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đổi thành công: ${reward.name}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đổi điểm thất bại: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isRedeeming = false);
    }
  }
}

// -- Reward data -----------------------------------------------------------

class _Reward {
  const _Reward({
    required this.name,
    required this.description,
    required this.pointsCost,
    required this.type,
    required this.icon,
  });

  final String name;
  final String description;
  final int pointsCost;
  final String type;
  final IconData icon;
}

const _rewards = [
  _Reward(
    name: 'Giảm 10.000đ',
    description: 'Áp dụng cho đơn từ 50.000đ trở lên',
    pointsCost: 100,
    type: 'discount_10k',
    icon: Icons.local_offer_outlined,
  ),
  _Reward(
    name: 'Giảm 25.000đ',
    description: 'Áp dụng cho đơn từ 100.000đ trở lên',
    pointsCost: 200,
    type: 'discount_25k',
    icon: Icons.local_offer_outlined,
  ),
  _Reward(
    name: 'Miễn phí nước uống',
    description: 'Tặng 1 nước uống bất kỳ khi mua cơm tấm',
    pointsCost: 50,
    type: 'free_drink',
    icon: Icons.local_drink_outlined,
  ),
  _Reward(
    name: 'Miễn phí giao hàng',
    description: 'Áp dụng cho 1 đơn giao hàng tiếp theo',
    pointsCost: 80,
    type: 'free_delivery',
    icon: Icons.delivery_dining_outlined,
  ),
  _Reward(
    name: 'Suất cơm tấm miễn phí',
    description: 'Tặng 1 suất cơm tấm sườn bì chả trị giá 55.000đ',
    pointsCost: 500,
    type: 'free_meal',
    icon: Icons.restaurant_outlined,
  ),
];

// -- Reward card -----------------------------------------------------------

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.reward,
    required this.availablePoints,
    required this.isRedeeming,
    required this.onRedeem,
  });

  final _Reward reward;
  final int availablePoints;
  final bool isRedeeming;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canAfford = availablePoints >= reward.pointsCost;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: canAfford
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.textSecondary.withValues(alpha: 0.1),
              child: Icon(
                reward.icon,
                color:
                    canAfford ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.name,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reward.description,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${reward.pointsCost} điểm',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: canAfford && !isRedeeming ? onRedeem : null,
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isRedeeming
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Đổi'),
            ),
          ],
        ),
      ),
    );
  }
}
