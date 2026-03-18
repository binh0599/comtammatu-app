import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/reward_model.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../domain/loyalty_notifier.dart';
import '../domain/loyalty_state.dart';

/// Màn hình đổi điểm lấy phần thưởng.
class RedeemPointsScreen extends ConsumerStatefulWidget {
  const RedeemPointsScreen({super.key});

  @override
  ConsumerState<RedeemPointsScreen> createState() => _RedeemPointsScreenState();
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
    final rewardsAsync = ref.watch(availableRewardsProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.redeemPointsTitle)),
      body: switch (loyaltyState) {
        LoyaltyLoading() ||
        LoyaltyInitial() =>
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
                  onPressed: () => ref
                      .read(loyaltyNotifierProvider.notifier)
                      .loadDashboard(),
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.retry),
                ),
              ],
            ),
          ),
        LoyaltyLoaded(:final dashboard) => RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(availableRewardsProvider);
              await ref.read(loyaltyNotifierProvider.notifier).loadDashboard();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Available points card
                  Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Icon(Icons.stars,
                              color: Colors.white, size: 32),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.redeemPointsAvailable,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white70),
                                ),
                                Text(
                                  '${dashboard.member.availablePoints.toInt()} ${l10n.redeemPointsSuffix}',
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
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
                    l10n.redeemPointsRewards,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),

                  // Reward list from API
                  rewardsAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (e, _) => Center(
                      child: Column(
                        children: [
                          Text(l10n.redeemPointsNoRewards),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () =>
                                ref.invalidate(availableRewardsProvider),
                            icon: const Icon(Icons.refresh, size: 18),
                            label: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                    data: (rewards) => rewards.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Text(
                                l10n.redeemPointsNoRewards,
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ),
                          )
                        : Column(
                            children: rewards
                                .map((reward) => _RewardCard(
                                      reward: reward,
                                      availablePoints: dashboard
                                          .member.availablePoints
                                          .toInt(),
                                      isRedeeming: _isRedeeming,
                                      onRedeem: () => _handleRedeem(reward),
                                    ))
                                .toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),
      },
    );
  }

  Future<void> _handleRedeem(Reward reward) async {
    final loyaltyState = ref.read(loyaltyNotifierProvider);
    if (loyaltyState is! LoyaltyLoaded) return;
    final l10n = context.l10n;

    final available = loyaltyState.dashboard.member.availablePoints.toInt();
    if (available < reward.pointsRequired) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.redeemPointsInsufficient),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.redeemPointsConfirmTitle),
        content: Text(
          l10n.redeemPointsConfirmMessage(reward.pointsRequired, reward.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.redeemPointsRedeem),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isRedeeming = true);
    try {
      await ref.read(loyaltyNotifierProvider.notifier).redeemPoints(
            rewardId: reward.id,
            points: reward.pointsRequired,
          );
      // Refresh rewards list
      ref.invalidate(availableRewardsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.redeemPointsSuccess(reward.name)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.redeemPointsFailed(e.toString())),
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

// -- Reward card (uses Reward model from API) ---------------------------------

IconData _rewardIcon(String category) {
  return switch (category) {
    'discount' => Icons.local_offer_outlined,
    'free_item' => Icons.restaurant_outlined,
    'free_delivery' => Icons.delivery_dining_outlined,
    'free_drink' => Icons.local_drink_outlined,
    _ => Icons.card_giftcard_outlined,
  };
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.reward,
    required this.availablePoints,
    required this.isRedeeming,
    required this.onRedeem,
  });

  final Reward reward;
  final int availablePoints;
  final bool isRedeeming;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final canAfford = availablePoints >= reward.pointsRequired;

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
                _rewardIcon(reward.category),
                color: canAfford ? AppColors.primary : AppColors.textSecondary,
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
                    '${reward.pointsRequired} ${l10n.redeemPointsSuffix}',
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
                  : Text(l10n.redeemPointsRedeem),
            ),
          ],
        ),
      ),
    );
  }
}
