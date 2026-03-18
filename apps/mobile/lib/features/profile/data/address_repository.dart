import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
import '../../../core/network/api_client.dart';
import '../../../models/address_model.dart';

/// Repository for CRUD operations on user saved addresses with offline cache.
class AddressRepository {
  const AddressRepository({
    required ApiClient apiClient,
    required CacheService cacheService,
  })  : _apiClient = apiClient,
        _cacheService = cacheService;

  final ApiClient _apiClient;
  final CacheService _cacheService;

  static const _cacheKey = 'cache_addresses';
  static const _cacheMaxAge = Duration(seconds: 300); // 5 min

  /// Fetches all saved addresses for the current user.
  ///
  /// Uses cache-first strategy:
  /// 1. If cache is valid (< 5 min), return cached data immediately.
  /// 2. Otherwise, fetch from API and update cache.
  /// 3. On network error, fall back to stale cache.
  Future<List<Address>> getAddresses() async {
    // 1. Check fresh cache
    if (_cacheService.isCacheValid(_cacheKey, _cacheMaxAge)) {
      final cached = _cacheService.getCachedAddresses();
      if (cached.isNotEmpty) {
        return cached.map(Address.fromJson).toList();
      }
    }

    // 2. Try network
    try {
      final addresses = await _apiClient.get<List<Address>>(
        '/addresses',
        fromJson: (json) {
          final list = json as List<dynamic>;
          return list
              .map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      // Cache the raw JSON for offline use
      await _cacheService.cacheAddresses(
        addresses.map((a) => a.toJson()).toList(),
      );
      return addresses;
    } catch (_) {
      // 3. Fallback to stale cache on network error
      final staleCache = _cacheService.getCachedAddresses();
      if (staleCache.isNotEmpty) {
        return staleCache.map((e) => Address.fromJson(e)).toList();
      }
      rethrow;
    }
  }

  /// Creates a new address. Returns the created address with server-assigned id.
  Future<Address> createAddress(Address address) async {
    final result = await _apiClient.post<Address>(
      '/addresses',
      data: address.toJson()..remove('id'),
      fromJson: (json) => Address.fromJson(json as Map<String, dynamic>),
    );
    await _invalidateCache();
    return result;
  }

  /// Updates an existing address. Returns the updated address.
  Future<Address> updateAddress(Address address) async {
    final result = await _apiClient.put<Address>(
      '/addresses',
      data: address.toJson(),
      fromJson: (json) => Address.fromJson(json as Map<String, dynamic>),
    );
    await _invalidateCache();
    return result;
  }

  /// Deletes an address by id.
  Future<void> deleteAddress(int addressId) async {
    await _apiClient.delete<void>('/addresses?id=$addressId');
    await _invalidateCache();
  }

  /// Sets the given address as the default.
  Future<void> setDefault(int addressId) async {
    await _apiClient.post<void>(
      '/addresses/set-default',
      data: {'address_id': addressId},
    );
    await _invalidateCache();
  }

  /// Removes cached addresses so the next read fetches fresh data.
  Future<void> _invalidateCache() async {
    final prefs = _cacheService;
    // Clear by caching an empty list — the timestamp will also reset,
    // ensuring isCacheValid returns false on next check.
    await prefs.cacheAddresses([]);
  }
}

/// Riverpod provider for [AddressRepository].
final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return AddressRepository(apiClient: apiClient, cacheService: cacheService);
});
