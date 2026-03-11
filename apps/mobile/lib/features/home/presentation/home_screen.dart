import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/formatters.dart';
import '../../loyalty/domain/loyalty_notifier.dart';
import '../../loyalty/domain/loyalty_state.dart';

/// Home screen — main landing page with loyalty summary and promotions.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load loyalty dashboard on first build
    Future.microtask(() {
      ref.read(loyaltyNotifierProvider.notifier).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loyaltyState = ref.watch(loyaltyNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cơm Tấm Má Tư'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go(AppRoutes.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(loyaltyNotifierProvider.notifier).loadDashboard();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Loyalty summary card
                _buildLoyaltyCard(context, loyaltyState),
                const SizedBox(height: 24),

                // Quick actions
                Text(
                  'Thao tác nhanh',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.qr_code_scanner,
                        label: 'Điểm danh',
                        onTap: () => context.push(AppRoutes.checkin),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.restaurant_menu,
                        label: 'Thực đơn',
                        onTap: () => context.go(AppRoutes.menu),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.delivery_dining,
                        label: 'Giao hàng',
                        onTap: () => context.go(AppRoutes.delivery),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.location_on_outlined,
                        label: 'Cửa hàng',
                        onTap: () => context.go(AppRoutes.storeLocator),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Promotions section
                _buildPromotions(context, loyaltyState),

                const SizedBox(height: 24),

                // Recent transactions
                _buildRecentTransactions(context, loyaltyState),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoyaltyCard(BuildContext context, LoyaltyState loyaltyState) {
    var pointsText = '---';
    var tierName = '---';
    double progressPercent = 0;

    if (loyaltyState is LoyaltyLoaded) {
      final d = loyaltyState.dashboard;
      pointsText = Formatters.formatNumber(d.member.availablePoints);
      tierName = d.tier.name;
      progressPercent = d.tier.nextTier?.progressPercent ?? 100;
    }

    return Card(
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Điểm tích lũy',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tierName,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (loyaltyState is LoyaltyLoading)
              const SizedBox(
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
            else
              Text(
                pointsText,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            const SizedBox(height: 4),
            Text(
              'điểm khả dụng',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 16),
            // Tier progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressPercent / 100,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 6,
              ),
            ),
            if (loyaltyState is LoyaltyLoaded &&
                loyaltyState.dashboard.tier.nextTier != null) ...[
              const SizedBox(height: 8),
              Text(
                'Còn ${Formatters.formatNumber(loyaltyState.dashboard.tier.nextTier!.pointsNeeded)} điểm nữa lên hạng ${loyaltyState.dashboard.tier.nextTier!.name}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPromotions(BuildContext context, LoyaltyState loyaltyState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ưu đãi dành cho bạn',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        if (loyaltyState is LoyaltyLoaded &&
            loyaltyState.dashboard.activePromotions.isNotEmpty)
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: loyaltyState.dashboard.activePromotions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final promo = loyaltyState.dashboard.activePromotions[index];
                return SizedBox(
                  width: 280,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promo.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            promo.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          if (promo.eligible)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Đủ điều kiện',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.success),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  loyaltyState is LoyaltyLoading
                      ? 'Đang tải ưu đãi...'
                      : 'Chưa có ưu đãi nào',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRecentTransactions(
      BuildContext context, LoyaltyState loyaltyState) {
    if (loyaltyState is! LoyaltyLoaded) return const SizedBox.shrink();

    final transactions = loyaltyState.dashboard.recentTransactions;
    if (transactions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Giao dịch gần đây',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.loyalty),
              child: const Text('Xem tất cả'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...transactions.take(3).map((txn) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor:
                    txn.type == 'earn' || txn.type == 'checkin_bonus'
                        ? AppColors.success.withValues(alpha: 0.1)
                        : AppColors.error.withValues(alpha: 0.1),
                child: Icon(
                  txn.type == 'earn' || txn.type == 'checkin_bonus'
                      ? Icons.add
                      : Icons.remove,
                  color: txn.type == 'earn' || txn.type == 'checkin_bonus'
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
              title: Text(txn.description),
              subtitle: Text(Formatters.formatDateTime(txn.createdAt)),
              trailing: Text(
                '${txn.type == 'earn' || txn.type == 'checkin_bonus' ? '+' : '-'}${txn.points.toInt()}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: txn.type == 'earn' || txn.type == 'checkin_bonus'
                          ? AppColors.success
                          : AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            )),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
