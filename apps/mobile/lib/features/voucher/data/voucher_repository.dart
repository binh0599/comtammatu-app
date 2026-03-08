import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/voucher_model.dart';

/// Result returned after redeeming a voucher with points.
class VoucherRedemptionResult {
  final int voucherId;
  final String code;
  final int pointsSpent;
  final int newBalance;

  const VoucherRedemptionResult({
    required this.voucherId,
    required this.code,
    required this.pointsSpent,
    required this.newBalance,
  });

  factory VoucherRedemptionResult.fromJson(Map<String, dynamic> json) {
    return VoucherRedemptionResult(
      voucherId: json['voucher_id'] as int,
      code: json['code'] as String,
      pointsSpent: json['points_spent'] as int,
      newBalance: json['new_balance'] as int,
    );
  }
}

/// Repository for voucher / coupon API calls.
class VoucherRepository {
  const VoucherRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Fetches vouchers available for point redemption.
  Future<List<Voucher>> getAvailableVouchers() async {
    return _apiClient.get<List<Voucher>>(
      '/redeem-points',
      queryParameters: {'action': 'available_rewards'},
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => Voucher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Redeems a voucher using loyalty points.
  Future<VoucherRedemptionResult> redeemVoucher(int voucherId) async {
    return _apiClient.post<VoucherRedemptionResult>(
      '/redeem-points',
      data: {
        'voucher_id': voucherId,
        'reward_type': 'voucher',
        'points': 0, // Server calculates from voucher
      },
      fromJson: (json) =>
          VoucherRedemptionResult.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Fetches vouchers the user has already redeemed (owned).
  Future<List<Voucher>> getMyVouchers() async {
    return _apiClient.get<List<Voucher>>(
      '/redeem-points',
      queryParameters: {'action': 'my_vouchers'},
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => Voucher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Riverpod provider for [VoucherRepository].
final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return VoucherRepository(apiClient: apiClient);
});
