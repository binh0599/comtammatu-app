import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/voucher_model.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../../shared/utils/formatters.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../domain/voucher_notifier.dart';

/// Main voucher / coupon screen with two tabs: available and owned.
class VoucherScreen extends ConsumerStatefulWidget {
  const VoucherScreen({super.key});

  @override
  ConsumerState<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends ConsumerState<VoucherScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load both voucher lists on init.
    Future.microtask(() {
      ref.read(availableVouchersProvider.notifier).loadVouchers();
      ref.read(myVouchersProvider.notifier).loadVouchers();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onRedeemVoucher(Voucher voucher) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          context.l10n.voucherRedeemConfirmTitle,
          style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voucher.title,
              style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.voucherRedeemConfirmMessage(Formatters.number(voucher.pointsCost)),
              style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              context.l10n.cancel,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _performRedeem(voucher);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(context.l10n.voucherRedeemNow),
          ),
        ],
      ),
    );
  }

  Future<void> _performRedeem(Voucher voucher) async {
    try {
      await ref
          .read(availableVouchersProvider.notifier)
          .redeemVoucher(voucher.id);

      // Refresh owned vouchers after redemption.
      unawaited(ref.read(myVouchersProvider.notifier).loadVouchers());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.voucherRedeemSuccess(voucher.title),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Switch to "Của tôi" tab.
      _tabController.animateTo(1);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.voucherRedeemFailed(e.toString())),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _onUseVoucher(Voucher voucher) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.voucherCodeCopied(voucher.code),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.info,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(context.l10n.profileMyOffers),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          tabs: [
            Tab(text: context.l10n.voucherAvailable),
            Tab(text: context.l10n.voucherMine),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AvailableVouchersTab(onRedeem: _onRedeemVoucher),
          _MyVouchersTab(onUse: _onUseVoucher),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Available vouchers tab
// ---------------------------------------------------------------------------

class _AvailableVouchersTab extends ConsumerWidget {
  const _AvailableVouchersTab({required this.onRedeem});

  final ValueChanged<Voucher> onRedeem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(availableVouchersProvider);

    return switch (state) {
      VoucherListInitial() || VoucherListLoading() => const LoadingIndicator(
          type: LoadingType.shimmer,
        ),
      VoucherListError(message: final msg) => ErrorView(
          message: msg,
          onRetry: () =>
              ref.read(availableVouchersProvider.notifier).loadVouchers(),
        ),
      VoucherListLoaded(vouchers: final vouchers) => vouchers.isEmpty
          ? EmptyView(
              icon: Icons.card_giftcard_outlined,
              message: context.l10n.voucherEmptyAvailable,
            )
          : RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () =>
                  ref.read(availableVouchersProvider.notifier).loadVouchers(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: vouchers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _VoucherCard(
                  voucher: vouchers[index],
                  variant: _VoucherCardVariant.available,
                  onAction: () => onRedeem(vouchers[index]),
                ),
              ),
            ),
    };
  }
}

// ---------------------------------------------------------------------------
// My (owned) vouchers tab
// ---------------------------------------------------------------------------

class _MyVouchersTab extends ConsumerWidget {
  const _MyVouchersTab({required this.onUse});

  final ValueChanged<Voucher> onUse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myVouchersProvider);

    return switch (state) {
      VoucherListInitial() || VoucherListLoading() => const LoadingIndicator(
          type: LoadingType.shimmer,
        ),
      VoucherListError(message: final msg) => ErrorView(
          message: msg,
          onRetry: () => ref.read(myVouchersProvider.notifier).loadVouchers(),
        ),
      VoucherListLoaded(vouchers: final vouchers) => vouchers.isEmpty
          ? EmptyView(
              icon: Icons.confirmation_number_outlined,
              message: context.l10n.voucherEmptyMine,
            )
          : RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () =>
                  ref.read(myVouchersProvider.notifier).loadVouchers(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: vouchers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _VoucherCard(
                  voucher: vouchers[index],
                  variant: _VoucherCardVariant.owned,
                  onAction: () => onUse(vouchers[index]),
                ),
              ),
            ),
    };
  }
}

// ---------------------------------------------------------------------------
// Voucher card variant
// ---------------------------------------------------------------------------

enum _VoucherCardVariant { available, owned }

// ---------------------------------------------------------------------------
// Voucher card widget — distinctive design with left colored strip
// ---------------------------------------------------------------------------

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({
    required this.voucher,
    required this.variant,
    required this.onAction,
  });

  final Voucher voucher;
  final _VoucherCardVariant variant;
  final VoidCallback onAction;

  String _discountLabel(BuildContext context) {
    if (voucher.discountType == 'percentage') {
      return context.l10n.voucherDiscountPercent(voucher.discountValue.toString());
    }
    return context.l10n.voucherDiscountFixed(Formatters.formatNumber(voucher.discountValue));
  }

  Color get _stripColor {
    if (voucher.isExpired) return AppColors.textHint;
    if (voucher.isUsed) return AppColors.textHint;
    return voucher.discountType == 'percentage'
        ? AppColors.primary
        : AppColors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = voucher.isExpired || voucher.isUsed;

    return Opacity(
      opacity: isDisabled ? 0.55 : 1.0,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left colored strip with discount badge
              _LeftStrip(
                color: _stripColor,
                label: _discountLabel(context),
              ),

              // Content area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with points badge (available) or code (owned)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              voucher.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (variant == _VoucherCardVariant.available) ...[
                            const SizedBox(width: 8),
                            _PointsBadge(points: voucher.pointsCost),
                          ],
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Description
                      Text(
                        voucher.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 10),

                      // Bottom row: min order + expiry + action button
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _InfoChip(
                                  icon: Icons.shopping_bag_outlined,
                                  text: context.l10n.voucherMinOrder(
                                      Formatters.formatNumber(voucher.minOrderAmount)),
                                ),
                                const SizedBox(height: 4),
                                _InfoChip(
                                  icon: Icons.schedule_outlined,
                                  text: context.l10n.voucherExpiry(
                                      Formatters.date(voucher.expiresAt)),
                                  isWarning: _isExpiringSoon(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _ActionButton(
                            variant: variant,
                            isDisabled: isDisabled,
                            onPressed: isDisabled ? null : onAction,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns true if the voucher expires within 3 days.
  bool _isExpiringSoon() {
    final daysLeft = voucher.expiresAt.difference(DateTime.now()).inDays;
    return daysLeft >= 0 && daysLeft <= 3;
  }
}

// ---------------------------------------------------------------------------
// Left colored strip with rotated discount text
// ---------------------------------------------------------------------------

class _LeftStrip extends StatelessWidget {
  const _LeftStrip({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_rounded,
            color: Colors.white.withValues(alpha: 0.9),
            size: 24,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Points cost badge
// ---------------------------------------------------------------------------

class _PointsBadge extends StatelessWidget {
  const _PointsBadge({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stars_rounded,
            size: 14,
            color: AppColors.secondaryDark,
          ),
          const SizedBox(width: 4),
          Text(
            '${Formatters.number(points)} điểm',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info chip (min order, expiry)
// ---------------------------------------------------------------------------

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
    this.isWarning = false,
  });

  final IconData icon;
  final String text;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final color = isWarning ? AppColors.error : AppColors.textHint;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: isWarning ? FontWeight.w600 : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Action button (Đổi ngay / Sử dụng)
// ---------------------------------------------------------------------------

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.variant,
    required this.isDisabled,
    required this.onPressed,
  });

  final _VoucherCardVariant variant;
  final bool isDisabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isAvailable = variant == _VoucherCardVariant.available;

    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isAvailable ? AppColors.primary : AppColors.success,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.textHint.withValues(alpha: 0.3),
          disabledForegroundColor: AppColors.textHint,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(isAvailable ? context.l10n.voucherRedeemNow : context.l10n.voucherUse),
      ),
    );
  }
}
