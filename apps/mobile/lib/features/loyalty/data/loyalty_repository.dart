import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
import '../../../core/network/api_client.dart';
import '../../../models/checkin_result.dart';
import '../../../models/loyalty_dashboard.dart';
import '../../../models/point_transaction.dart';
import '../../../models/reward_model.dart';

/// Result of a point redemption request (API Contract §2.3).
class RedemptionResult {
  final int redemptionId;
  final int pointsDeducted;
  final double newBalance;
  final RedemptionReward? reward;
  final int version;

  const RedemptionResult({
    required this.redemptionId,
    required this.pointsDeducted,
    required this.newBalance,
    this.reward,
    this.version = 0,
  });

  factory RedemptionResult.fromJson(Map<String, dynamic> json) {
    return RedemptionResult(
      redemptionId: json['redemption_id'] as int? ?? 0,
      pointsDeducted: (json['points_deducted'] as num?)?.toInt() ?? 0,
      newBalance: (json['new_balance'] as num?)?.toDouble() ?? 0,
      reward: json['reward'] != null
          ? RedemptionReward.fromJson(json['reward'] as Map<String, dynamic>)
          : null,
      version: json['version'] as int? ?? 0,
    );
  }
}

/// Reward details returned after successful redemption.
class RedemptionReward {
  final int id;
  final String name;
  final String? description;
  final int pointsRequired;
  final String? voucherCode;
  final DateTime? expiresAt;

  const RedemptionReward({
    required this.id,
    required this.name,
    this.description,
    required this.pointsRequired,
    this.voucherCode,
    this.expiresAt,
  });

  factory RedemptionReward.fromJson(Map<String, dynamic> json) {
    return RedemptionReward(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      pointsRequired: json['points_required'] as int? ?? 0,
      voucherCode: json['voucher_code'] as String?,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'] as String)
          : null,
    );
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

/// Repository for loyalty-related API calls with offline cache support.
class LoyaltyRepository {
  const LoyaltyRepository({
    required ApiClient apiClient,
    required CacheService cacheService,
  })  : _apiClient = apiClient,
        _cacheService = cacheService;

  final ApiClient _apiClient;
  final CacheService _cacheService;

  static const _cacheKey = 'cache_loyalty';
  static const _cacheMaxAge = Duration(seconds: 300); // 5 min

  /// Fetches the full loyalty dashboard (member, tier, transactions, promotions, stats).
  ///
  /// Uses cache-first strategy:
  /// 1. If cache is valid (< 5 min), return cached data immediately.
  /// 2. Otherwise, fetch from API and update cache.
  /// 3. On network error, fall back to stale cache.
  Future<LoyaltyDashboard> getDashboard() async {
    // 1. Check fresh cache
    if (_cacheService.isCacheValid(_cacheKey, _cacheMaxAge)) {
      final cached = _cacheService.getCachedLoyalty();
      if (cached != null) {
        return LoyaltyDashboard.fromJson(cached);
      }
    }

    // 2. Try network
    try {
      final dashboard = await _apiClient.get<LoyaltyDashboard>(
        '/get-loyalty-dashboard',
        fromJson: (json) =>
            LoyaltyDashboard.fromJson(json as Map<String, dynamic>),
      );
      // Cache the raw JSON for offline use
      await _cacheService.cacheLoyalty(dashboard.toJson());
      return dashboard;
    } catch (_) {
      // 3. Fallback to stale cache on network error
      final staleCache = _cacheService.getCachedLoyalty();
      if (staleCache != null) {
        return LoyaltyDashboard.fromJson(staleCache);
      }
      rethrow;
    }
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

  /// Fetches available rewards for point redemption.
  Future<List<Reward>> getAvailableRewards() async {
    return _apiClient.get<List<Reward>>(
      '/redeem-points/rewards',
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        final list = map['rewards'] as List<dynamic>? ?? [];
        return list
            .map((e) => Reward.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Redeems loyalty points for a reward (per API Contract §2.3).
  Future<RedemptionResult> redeemPoints({
    required int rewardId,
    required int points,
  }) async {
    return _apiClient.post<RedemptionResult>(
      '/redeem-points',
      data: {
        'reward_id': rewardId,
        'points': points,
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
  final cacheService = ref.watch(cacheServiceProvider);
  return LoyaltyRepository(apiClient: apiClient, cacheService: cacheService);
});
