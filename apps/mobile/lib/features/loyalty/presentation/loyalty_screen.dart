import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/loyalty_dashboard.dart';
import '../../../models/point_transaction.dart';
import '../../../models/tier.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../domain/loyalty_notifier.dart';
import '../domain/loyalty_state.dart';

// -- Helpers --------------------------------------------------------------

Color _tierColor(String tierCode) {
  return switch (tierCode) {
    'silver' => AppColors.tierSilver,
    'gold' => AppColors.tierGold,
    'diamond' => AppColors.tierDiamond,
    _ => AppColors.tierBronze,
  };
}

IconData _tierIcon(String tierCode) {
  return tierCode == 'diamond' ? Icons.diamond : Icons.workspace_premium;
}

final _dateFormat = DateFormat('dd/MM/yyyy');

// -- Screen ---------------------------------------------------------------

/// Loyalty screen showing points, tier, and transaction history.
class LoyaltyScreen extends ConsumerStatefulWidget {
  const LoyaltyScreen({super.key});

  @override
  ConsumerState<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends ConsumerState<LoyaltyScreen> {
  @override
  void initState() {
    super.initState();
    // Only fetch if we haven't loaded yet — avoids refetch on tab switch
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

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.loyalty),
      ),
      body: switch (loyaltyState) {
        LoyaltyLoading() => const Center(child: CircularProgressIndicator()),
        LoyaltyError(:final message) => _ErrorBody(
            message: message,
            onRetry: () =>
                ref.read(loyaltyNotifierProvider.notifier).loadDashboard(),
          ),
        LoyaltyLoaded(:final dashboard) => _LoadedBody(dashboard: dashboard),
        LoyaltyInitial() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

// -- Error body -----------------------------------------------------------

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              context.l10n.loyaltyCannotLoad,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Loaded body ----------------------------------------------------------

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.dashboard});

  final LoyaltyDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final tier = dashboard.tier;
    final member = dashboard.member;
    final points = member.availablePoints.toInt();
    final transactions = dashboard.recentTransactions;
    final tierColor = _tierColor(tier.tierCode);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Points balance card
          Card(
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    context.l10n.homeAccumulatedPoints,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$points',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.loyaltyPointsSuffix,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Action buttons: Earn / Redeem / Check-in
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.arrow_upward,
                          label: context.l10n.earnPoints,
                          onTap: () =>
                              context.push(AppRoutes.earnPoints),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.card_giftcard,
                          label: context.l10n.redeemPoints,
                          onTap: () =>
                              context.push(AppRoutes.redeemPoints),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.qr_code_scanner,
                          label: context.l10n.checkIn,
                          onTap: () =>
                              context.push(AppRoutes.checkin),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Tier progress
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(_tierIcon(tier.tierCode),
                          color: tierColor, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        context.l10n.loyaltyTierName(tier.name),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Progress bar to next tier
                  if (tier.nextTier != null) ...[
                    _TierProgressBar(nextTier: tier.nextTier!),
                    const SizedBox(height: 10),
                    Text(
                      context.l10n.loyaltyPointsNeeded(tier.nextTier!.pointsNeeded.toInt(), tier.nextTier!.name),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  Text(
                    context.l10n.loyaltyCurrentBenefits,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  ...tier.benefits.map(
                    (b) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 18,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              b,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Recent transactions
          Text(
            context.l10n.loyaltyTransactionHistory,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),

          if (transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  context.l10n.loyaltyNoTransactions,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            )
          else
            ...transactions.map(
              (tx) => _TransactionTile(transaction: tx),
            ),
        ],
      ),
    );
  }
}

// -- Tier progress bar ----------------------------------------------------

class _TierProgressBar extends StatelessWidget {
  const _TierProgressBar({required this.nextTier});

  final TierProgress nextTier;

  @override
  Widget build(BuildContext context) {
    final progress =
        (nextTier.progressPercent / 100).clamp(0.0, 1.0).toDouble();

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 10,
        child: Stack(
          children: [
            Container(color: AppColors.border),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.tierBronze,
                      AppColors.tierSilver,
                      AppColors.tierGold,
                    ],
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

// -- Action button --------------------------------------------------------

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// -- Transaction tile -----------------------------------------------------

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final PointTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final pts = transaction.points.abs().toInt();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: isCredit
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.error.withValues(alpha: 0.1),
          child: Icon(
            isCredit ? Icons.add_circle_outline : Icons.remove_circle_outline,
            color: isCredit ? AppColors.success : AppColors.error,
          ),
        ),
        title: Text(
          transaction.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          _dateFormat.format(transaction.createdAt),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          context.l10n.loyaltyPointsFormat(isCredit ? '+' : '-', pts),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isCredit ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
