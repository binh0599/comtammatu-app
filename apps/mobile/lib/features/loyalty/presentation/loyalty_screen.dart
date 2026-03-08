import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

// -- Data models ----------------------------------------------------------

class LoyaltyTier {
  const LoyaltyTier({
    required this.name,
    required this.minPoints,
    required this.color,
    required this.icon,
    required this.benefits,
  });

  final String name;
  final int minPoints;
  final Color color;
  final IconData icon;
  final List<String> benefits;
}

class LoyaltyTransaction {
  const LoyaltyTransaction({
    required this.title,
    required this.date,
    required this.points,
    required this.isEarned,
  });

  final String title;
  final String date;
  final int points;
  final bool isEarned;
}

// -- Sample data ----------------------------------------------------------

const _kTiers = [
  LoyaltyTier(
    name: 'Đồng',
    minPoints: 0,
    color: AppColors.tierBronze,
    icon: Icons.workspace_premium,
    benefits: [
      'Tích 1 điểm / 10.000đ',
      'Ưu đãi sinh nhật',
    ],
  ),
  LoyaltyTier(
    name: 'Bạc',
    minPoints: 500,
    color: AppColors.tierSilver,
    icon: Icons.workspace_premium,
    benefits: [
      'Tích 1.5 điểm / 10.000đ',
      'Ưu đãi sinh nhật',
      'Freeship đơn từ 100.000đ',
    ],
  ),
  LoyaltyTier(
    name: 'Vàng',
    minPoints: 2000,
    color: AppColors.tierGold,
    icon: Icons.workspace_premium,
    benefits: [
      'Tích 2 điểm / 10.000đ',
      'Ưu đãi sinh nhật',
      'Freeship mọi đơn',
      'Ưu tiên đặt bàn',
    ],
  ),
  LoyaltyTier(
    name: 'Kim Cương',
    minPoints: 5000,
    color: AppColors.tierDiamond,
    icon: Icons.diamond,
    benefits: [
      'Tích 3 điểm / 10.000đ',
      'Ưu đãi sinh nhật đặc biệt',
      'Freeship mọi đơn',
      'Ưu tiên đặt bàn VIP',
      'Quà tặng hàng tháng',
    ],
  ),
];

const _kSampleTransactions = [
  LoyaltyTransaction(
    title: 'Mua Cơm tấm sườn bì chả',
    date: '07/03/2026',
    points: 55,
    isEarned: true,
  ),
  LoyaltyTransaction(
    title: 'Đổi điểm — Giảm 20.000đ',
    date: '05/03/2026',
    points: 200,
    isEarned: false,
  ),
  LoyaltyTransaction(
    title: 'Điểm danh cửa hàng',
    date: '04/03/2026',
    points: 10,
    isEarned: true,
  ),
  LoyaltyTransaction(
    title: 'Mua Cơm tấm đặc biệt',
    date: '02/03/2026',
    points: 65,
    isEarned: true,
  ),
  LoyaltyTransaction(
    title: 'Mua 2 Nước sâm',
    date: '28/02/2026',
    points: 30,
    isEarned: true,
  ),
];

// -- Providers ------------------------------------------------------------

final loyaltyPointsProvider = Provider<int>((ref) => 1250);

final loyaltyTransactionsProvider =
    Provider<List<LoyaltyTransaction>>((ref) => _kSampleTransactions);

// -- Helpers --------------------------------------------------------------

LoyaltyTier _currentTier(int points) {
  var tier = _kTiers.first;
  for (final t in _kTiers) {
    if (points >= t.minPoints) tier = t;
  }
  return tier;
}

LoyaltyTier? _nextTier(int points) {
  for (final t in _kTiers) {
    if (points < t.minPoints) return t;
  }
  return null;
}

// -- Screen ---------------------------------------------------------------

/// Loyalty screen showing points, tier, and transaction history.
class LoyaltyScreen extends ConsumerWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(loyaltyPointsProvider);
    final transactions = ref.watch(loyaltyTransactionsProvider);
    final tier = _currentTier(points);
    final next = _nextTier(points);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tích điểm'),
      ),
      body: SingleChildScrollView(
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
                        Icon(tier.icon, color: tier.color, size: 28),
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

                    // Progress bar
                    _TierProgressBar(points: points),

                    if (next != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        'Cần thêm ${next.minPoints - points} điểm để lên hạng ${next.name}',
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

            ...transactions.map(
              (tx) => _TransactionTile(transaction: tx),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Tier progress bar ----------------------------------------------------

class _TierProgressBar extends StatelessWidget {
  const _TierProgressBar({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tier labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _kTiers
              .map(
                (t) => Text(
                  t.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: points >= t.minPoints
                            ? t.color
                            : AppColors.textHint,
                        fontWeight: points >= t.minPoints
                            ? FontWeight.w600
                            : FontWeight.w400,
                        fontSize: 11,
                      ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 6),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 10,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxPoints =
                    _kTiers.last.minPoints.toDouble(); // 5000
                final progress =
                    (points / maxPoints).clamp(0.0, 1.0);
                return Stack(
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// -- Transaction tile -----------------------------------------------------

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final LoyaltyTransaction transaction;

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: transaction.isEarned
              ? AppColors.success.withOpacity(0.1)
              : AppColors.error.withOpacity(0.1),
          child: Icon(
            transaction.isEarned
                ? Icons.add_circle_outline
                : Icons.remove_circle_outline,
            color:
                transaction.isEarned ? AppColors.success : AppColors.error,
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          transaction.date,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          '${transaction.isEarned ? '+' : '-'}${transaction.points} điểm',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: transaction.isEarned
                    ? AppColors.success
                    : AppColors.error,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
