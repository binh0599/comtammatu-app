import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
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

/// Repository for voucher / coupon API calls with offline cache support.
class VoucherRepository {
  const VoucherRepository({
    required ApiClient apiClient,
    required CacheService cacheService,
  })  : _apiClient = apiClient,
        _cacheService = cacheService;

  final ApiClient _apiClient;
  final CacheService _cacheService;

  static const _availableCacheKey = 'cache_vouchers_available';
  static const _mineCacheKey = 'cache_vouchers_mine';
  static const _cacheMaxAge = Duration(seconds: 300); // 5 min

  /// Fetches vouchers available for point redemption.
  ///
  /// Uses cache-first strategy:
  /// 1. If cache is valid (< 5 min), return cached data immediately.
  /// 2. Otherwise, fetch from API and update cache.
  /// 3. On network error, fall back to stale cache.
  Future<List<Voucher>> getAvailableVouchers() async {
    // 1. Check fresh cache
    if (_cacheService.isCacheValid(_availableCacheKey, _cacheMaxAge)) {
      final cached = _cacheService.getCachedVouchers(_availableCacheKey);
      if (cached.isNotEmpty) {
        return cached.map(Voucher.fromJson).toList();
      }
    }

    // 2. Try network
    try {
      final vouchers = await _apiClient.get<List<Voucher>>(
        '/vouchers',
        fromJson: (json) {
          final map = json as Map<String, dynamic>;
          final list = map['vouchers'] as List<dynamic>? ?? [];
          return list
              .map((e) => Voucher.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      await _cacheService.cacheVouchers(
        _availableCacheKey,
        vouchers.map((v) => v.toJson()).toList(),
      );
      return vouchers;
    } catch (_) {
      // 3. Fallback to stale cache on network error
      final staleCache = _cacheService.getCachedVouchers(_availableCacheKey);
      if (staleCache.isNotEmpty) {
        return staleCache.map((e) => Voucher.fromJson(e)).toList();
      }
      rethrow;
    }
  }

  /// Redeems a voucher using loyalty points.
  Future<VoucherRedemptionResult> redeemVoucher(int voucherId) async {
    return _apiClient.post<VoucherRedemptionResult>(
      '/vouchers/redeem',
      data: {
        'voucher_id': voucherId,
      },
      fromJson: (json) =>
          VoucherRedemptionResult.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Fetches vouchers the user has already redeemed (owned).
  ///
  /// Uses cache-first strategy:
  /// 1. If cache is valid (< 5 min), return cached data immediately.
  /// 2. Otherwise, fetch from API and update cache.
  /// 3. On network error, fall back to stale cache.
  Future<List<Voucher>> getMyVouchers() async {
    // 1. Check fresh cache
    if (_cacheService.isCacheValid(_mineCacheKey, _cacheMaxAge)) {
      final cached = _cacheService.getCachedVouchers(_mineCacheKey);
      if (cached.isNotEmpty) {
        return cached.map(Voucher.fromJson).toList();
      }
    }

    // 2. Try network
    try {
      final vouchers = await _apiClient.get<List<Voucher>>(
        '/vouchers/mine',
        fromJson: (json) {
          final map = json as Map<String, dynamic>;
          final list = map['vouchers'] as List<dynamic>? ?? [];
          return list
              .map((e) => Voucher.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      await _cacheService.cacheVouchers(
        _mineCacheKey,
        vouchers.map((v) => v.toJson()).toList(),
      );
      return vouchers;
    } catch (_) {
      // 3. Fallback to stale cache on network error
      final staleCache = _cacheService.getCachedVouchers(_mineCacheKey);
      if (staleCache.isNotEmpty) {
        return staleCache.map((e) => Voucher.fromJson(e)).toList();
      }
      rethrow;
    }
  }
}

/// Riverpod provider for [VoucherRepository].
final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return VoucherRepository(apiClient: apiClient, cacheService: cacheService);
});
