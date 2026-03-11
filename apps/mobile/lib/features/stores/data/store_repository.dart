import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';
import 'models/store_model.dart';

/// Repository for store / branch location queries with offline cache.
class StoreRepository {
  const StoreRepository({
    required ApiClient apiClient,
    required CacheService cacheService,
  })  : _apiClient = apiClient,
        _cacheService = cacheService;

  final ApiClient _apiClient;
  final CacheService _cacheService;

  static const _cacheKey = 'cache_stores';
  static const _cacheMaxAge = Duration(seconds: AppConstants.cacheMaxAge);

  /// Fetches all active stores with cache-first strategy.
  Future<List<StoreInfo>> getStores() async {
    // 1. Check fresh cache
    if (_cacheService.isCacheValid(_cacheKey, _cacheMaxAge)) {
      final cached = _cacheService.getCachedStores();
      if (cached.isNotEmpty) {
        return cached.map(StoreInfo.fromJson).toList();
      }
    }

    // 2. Try network
    try {
      final stores = await _fetchStoresFromApi();
      await _cacheService.cacheStores(stores.map((s) => s.toJson()).toList());
      return stores;
    } catch (_) {
      // 3. Fallback to stale cache
      final staleCache = _cacheService.getCachedStores();
      if (staleCache.isNotEmpty) {
        return staleCache.map(StoreInfo.fromJson).toList();
      }
      rethrow;
    }
  }

  /// Fetches stores sorted by distance from the given coordinates.
  Future<List<StoreInfo>> getNearbyStores(double lat, double lng) async {
    try {
      return await _apiClient.get<List<StoreInfo>>(
        '/stores',
        queryParameters: {'lat': lat, 'lng': lng},
        fromJson: (json) {
          final map = json as Map<String, dynamic>;
          final list = map['stores'] as List<dynamic>;
          return list
              .map((e) => StoreInfo.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
    } catch (_) {
      // Fallback: return cached stores sorted by distance
      final cached = _cacheService.getCachedStores();
      if (cached.isNotEmpty) {
        final stores = cached.map(StoreInfo.fromJson).toList()
          ..sort((a, b) {
            final dA = (a.latitude != null && a.longitude != null)
                ? distanceKm(lat, lng, a.latitude!, a.longitude!)
                : double.infinity;
            final dB = (b.latitude != null && b.longitude != null)
                ? distanceKm(lat, lng, b.latitude!, b.longitude!)
                : double.infinity;
            return dA.compareTo(dB);
          });
        return stores;
      }
      rethrow;
    }
  }

  /// Fetches a single store by its ID.
  Future<StoreInfo> getStore(int id) async {
    return _apiClient.get<StoreInfo>(
      '/stores',
      queryParameters: {'id': id},
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        return StoreInfo.fromJson(map['store'] as Map<String, dynamic>);
      },
    );
  }

  Future<List<StoreInfo>> _fetchStoresFromApi() {
    return _apiClient.get<List<StoreInfo>>(
      '/stores',
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        final list = map['stores'] as List<dynamic>;
        return list
            .map((e) => StoreInfo.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Calculates distance in kilometres between two lat/lng pairs (Haversine).
  static double distanceKm(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadius = 6371.0; // km
    final dLat = _deg2rad(lat2 - lat1);
    final dLng = _deg2rad(lng2 - lng1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _deg2rad(double deg) => deg * (pi / 180);
}

/// Riverpod provider for [StoreRepository].
final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return StoreRepository(apiClient: apiClient, cacheService: cacheService);
});
