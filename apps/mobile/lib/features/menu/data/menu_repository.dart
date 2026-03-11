import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../models/menu_item.dart';

/// Repository for menu-related API calls with offline cache support.
class MenuRepository {
  const MenuRepository({
    required ApiClient apiClient,
    required CacheService cacheService,
  })  : _apiClient = apiClient,
        _cacheService = cacheService;

  final ApiClient _apiClient;
  final CacheService _cacheService;

  static const _cacheKey = 'cache_menu';
  static const _cacheMaxAge = Duration(seconds: AppConstants.cacheMaxAge);

  /// Fetches the full menu grouped by category for a given branch.
  ///
  /// Uses cache-first strategy:
  /// 1. If cache is valid (< 5 min), return cached data immediately.
  /// 2. Otherwise, fetch from API and update cache.
  /// 3. On network error, fall back to stale cache (up to 24h).
  Future<List<MenuCategory>> getMenu({required int branchId}) async {
    // 1. Check fresh cache
    if (_cacheService.isCacheValid(_cacheKey, _cacheMaxAge)) {
      final cached = _cacheService.getCachedMenu();
      if (cached.isNotEmpty) {
        return _parseMenuJson(cached);
      }
    }

    // 2. Try network
    try {
      final categories = await _fetchMenuFromApi(branchId);
      // Cache the raw JSON for offline use
      await _cacheService.cacheMenu(
        categories
            .expand((cat) => cat.items.map((item) => item.toJson()))
            .toList(),
      );
      return categories;
    } catch (_) {
      // 3. Fallback to stale cache on network error
      final staleCache = await _cacheService.getCachedMenuAsync();
      if (staleCache.isNotEmpty) {
        return _parseMenuJson(staleCache);
      }
      rethrow;
    }
  }

  /// Direct API fetch without cache (for pull-to-refresh).
  Future<List<MenuCategory>> refreshMenu({required int branchId}) async {
    final categories = await _fetchMenuFromApi(branchId);
    await _cacheService.cacheMenu(
      categories
          .expand((cat) => cat.items.map((item) => item.toJson()))
          .toList(),
    );
    return categories;
  }

  Future<List<MenuCategory>> _fetchMenuFromApi(int branchId) {
    return _apiClient.get<List<MenuCategory>>(
      '/get-menu',
      queryParameters: {'branch_id': branchId.toString()},
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        final categories = map['categories'] as List<dynamic>;
        return categories
            .map((e) => MenuCategory.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Parses cached flat menu items back into categories.
  List<MenuCategory> _parseMenuJson(List<Map<String, dynamic>> items) {
    final byCategory = <String, List<MenuItem>>{};
    for (final item in items) {
      final menuItem = MenuItem.fromApiJson(item);
      final category = menuItem.category;
      byCategory.putIfAbsent(category, () => []).add(menuItem);
    }
    return byCategory.entries
        .map((e) => MenuCategory(name: e.key, items: e.value))
        .toList();
  }
}

/// Riverpod provider for [MenuRepository].
final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return MenuRepository(apiClient: apiClient, cacheService: cacheService);
});
