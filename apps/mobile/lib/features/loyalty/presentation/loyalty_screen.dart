import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/loyalty_dashboard.dart';
import '../../../models/point_transaction.dart';
import '../../../models/tier.dart';
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
        title: const Text('Tích điểm'),
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
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Không thể tải dữ liệu tích điểm',
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
              label: const Text('Thử lại'),
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
                    'Điểm tích lũy',
                    style:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$points',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'điểm',
                    style:
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white70,
                            ),
                  ),
                  const SizedBox(height: 20),

                  // Check-in button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mở camera để điểm danh...'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Điểm danh ngay'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
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
              side: BorderSide(color: AppColors.border),
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
                        'Hạng ${tier.name}',
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
                      'Cần thêm ${tier.nextTier!.pointsNeeded.toInt()} điểm để lên hạng ${tier.nextTier!.name}',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  Text(
                    'Quyền lợi hiện tại',
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
                          Icon(
                            Icons.check_circle,
                            size: 18,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              b,
                              style:
                                  Theme.of(context).textTheme.bodyMedium,
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
            'Lịch sử giao dịch',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),

          if (transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Chưa có giao dịch nào',
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
    final double progress = (nextTier.progressPercent / 100).clamp(0.0, 1.0).toDouble();

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
                decoration: BoxDecoration(
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
        side: BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: isCredit
              ? AppColors.success.withOpacity(0.1)
              : AppColors.error.withOpacity(0.1),
          child: Icon(
            isCredit
                ? Icons.add_circle_outline
                : Icons.remove_circle_outline,
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
          '${isCredit ? '+' : '-'}$pts điểm',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isCredit ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
