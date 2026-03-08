import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import 'models/store_model.dart';

/// Repository for store / branch location queries.
class StoreRepository {
  const StoreRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Fetches all active stores.
  Future<List<StoreInfo>> getStores() async {
    return _apiClient.get<List<StoreInfo>>(
      '/stores',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => StoreInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Fetches stores sorted by distance from the given coordinates.
  Future<List<StoreInfo>> getNearbyStores(double lat, double lng) async {
    return _apiClient.get<List<StoreInfo>>(
      '/stores',
      queryParameters: {'latitude': lat, 'longitude': lng, 'sort': 'distance'},
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => StoreInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Fetches a single store by its ID.
  Future<StoreInfo> getStore(String id) async {
    return _apiClient.get<StoreInfo>(
      '/stores/$id',
      fromJson: (json) =>
          StoreInfo.fromJson(json as Map<String, dynamic>),
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
  return StoreRepository(apiClient: apiClient);
});
