import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/voucher_model.dart';
import '../data/voucher_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

/// State for a voucher list (available or owned).
sealed class VoucherListState {
  const VoucherListState();
}

class VoucherListInitial extends VoucherListState {
  const VoucherListInitial();
}

class VoucherListLoading extends VoucherListState {
  const VoucherListLoading();
}

class VoucherListLoaded extends VoucherListState {
  const VoucherListLoaded({required this.vouchers});
  final List<Voucher> vouchers;
}

class VoucherListError extends VoucherListState {
  const VoucherListError({required this.message});
  final String message;
}

// ---------------------------------------------------------------------------
// Notifier — available vouchers
// ---------------------------------------------------------------------------

/// Manages the list of vouchers available for point redemption.
class AvailableVouchersNotifier extends StateNotifier<VoucherListState> {
  AvailableVouchersNotifier({required VoucherRepository voucherRepository})
      : _voucherRepository = voucherRepository,
        super(const VoucherListInitial());

  final VoucherRepository _voucherRepository;

  /// Fetch vouchers available in the shop.
  Future<void> loadVouchers() async {
    state = const VoucherListLoading();
    try {
      final vouchers = await _voucherRepository.getAvailableVouchers();
      state = VoucherListLoaded(vouchers: vouchers);
    } catch (e) {
      state = VoucherListError(message: e.toString());
    }
  }

  /// Redeem a voucher by its [voucherId], then refresh the list.
  Future<void> redeemVoucher(int voucherId) async {
    try {
      await _voucherRepository.redeemVoucher(voucherId);
      await loadVouchers();
    } catch (e) {
      rethrow;
    }
  }
}

// ---------------------------------------------------------------------------
// Notifier — my (owned) vouchers
// ---------------------------------------------------------------------------

/// Manages the list of vouchers the user has already redeemed.
class MyVouchersNotifier extends StateNotifier<VoucherListState> {
  MyVouchersNotifier({required VoucherRepository voucherRepository})
      : _voucherRepository = voucherRepository,
        super(const VoucherListInitial());

  final VoucherRepository _voucherRepository;

  /// Fetch the user's owned vouchers.
  Future<void> loadVouchers() async {
    state = const VoucherListLoading();
    try {
      final vouchers = await _voucherRepository.getMyVouchers();
      state = VoucherListLoaded(vouchers: vouchers);
    } catch (e) {
      state = VoucherListError(message: e.toString());
    }
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

final availableVouchersProvider = StateNotifierProvider.autoDispose<
    AvailableVouchersNotifier, VoucherListState>((ref) {
  final repo = ref.watch(voucherRepositoryProvider);
  return AvailableVouchersNotifier(voucherRepository: repo);
});

final myVouchersProvider =
    StateNotifierProvider.autoDispose<MyVouchersNotifier, VoucherListState>(
        (ref) {
  final repo = ref.watch(voucherRepositoryProvider);
  return MyVouchersNotifier(voucherRepository: repo);
});
