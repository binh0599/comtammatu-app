import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/checkin_result.dart';
import '../../../models/loyalty_dashboard.dart';
import '../../../models/point_transaction.dart';

/// Result of a point redemption request.
class RedemptionResult {
  final int transactionId;
  final double pointsRedeemed;
  final double newBalance;

  const RedemptionResult({
    required this.transactionId,
    required this.pointsRedeemed,
    required this.newBalance,
  });

  factory RedemptionResult.fromJson(Map<String, dynamic> json) {
    return RedemptionResult(
      transactionId: json['transaction_id'] as int,
      pointsRedeemed: (json['points_redeemed'] as num).toDouble(),
      newBalance: (json['new_balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'points_redeemed': pointsRedeemed,
      'new_balance': newBalance,
    };
  }
}

/// Paginated response for point transactions.
class PaginatedTransactions {
  final List<PointTransaction> transactions;
  final String? nextCursor;
  final bool hasMore;

  const PaginatedTransactions({
    required this.transactions,
    required this.hasMore,
    this.nextCursor,
  });

  factory PaginatedTransactions.fromJson(Map<String, dynamic> json) {
    final data = json['transactions'] as List<dynamic>? ??
        json['items'] as List<dynamic>? ??
        [];
    return PaginatedTransactions(
      transactions: data
          .map((e) => PointTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['next_cursor'] as String?,
      hasMore: json['has_more'] as bool? ?? false,
    );
  }
}

/// Repository for loyalty-related API calls.
class LoyaltyRepository {
  const LoyaltyRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Fetches the full loyalty dashboard (member, tier, transactions, promotions, stats).
  Future<LoyaltyDashboard> getDashboard() async {
    return _apiClient.get<LoyaltyDashboard>(
      '/get-loyalty-dashboard',
      fromJson: (json) =>
          LoyaltyDashboard.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Verifies a check-in via QR code or branch ID.
  Future<CheckinResult> verifyCheckin({
    required int branchId,
    String? qrCode,
    double? latitude,
    double? longitude,
  }) async {
    return _apiClient.post<CheckinResult>(
      '/verify-checkin',
      data: {
        'branch_id': branchId,
        if (qrCode != null) 'qr_code': qrCode,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
      },
      fromJson: (json) => CheckinResult.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Redeems loyalty points for a reward or discount.
  Future<RedemptionResult> redeemPoints({
    required double points,
    required String rewardType,
    int? orderId,
  }) async {
    return _apiClient.post<RedemptionResult>(
      '/redeem-points',
      data: {
        'points': points,
        'reward_type': rewardType,
        if (orderId != null) 'order_id': orderId,
      },
      fromJson: (json) =>
          RedemptionResult.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Fetches paginated point transaction history.
  Future<PaginatedTransactions> getTransactions({
    String? cursor,
    int limit = 20,
  }) async {
    return _apiClient.get<PaginatedTransactions>(
      '/get-transactions',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      },
      fromJson: (json) =>
          PaginatedTransactions.fromJson(json as Map<String, dynamic>),
    );
  }
}

/// Riverpod provider for [LoyaltyRepository].
final loyaltyRepositoryProvider = Provider<LoyaltyRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return LoyaltyRepository(apiClient: apiClient);
});
