import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/app_database.dart';

/// Cache keys used for SharedPreferences storage.
class _CacheKeys {
  _CacheKeys._();

  static const String menu = 'cache_menu';
  static const String cart = 'cache_cart';
  static const String orders = 'cache_orders';
  static const String stores = 'cache_stores';
  static String timestamp(String key) => '${key}_timestamp';
}

/// Offline cache service using SharedPreferences.
///
/// Stores data as JSON strings with timestamps for freshness checks.
/// Can also operate in Drift-backed mode via [CacheService.fromDrift]
/// for offline-first menu access when SharedPreferences is unavailable.
class CacheService {
  CacheService({required SharedPreferences prefs})
      : _prefs = prefs,
        _db = null;

  /// Creates a Drift-backed CacheService that reads menu data from the
  /// [CachedMenuItems] table. Use this fallback when SharedPreferences
  /// is not yet initialized.
  CacheService.fromDrift({required AppDatabase db})
      : _prefs = null,
        _db = db;

  final SharedPreferences? _prefs;
  final AppDatabase? _db;

  bool get _isDriftBacked => _db != null;

  // -- Menu -----------------------------------------------------------------

  /// Caches the menu items list.
  Future<void> cacheMenu(List<Map<String, dynamic>> items) async {
    if (_isDriftBacked) {
      await _cacheMenuToDrift(items);
      return;
    }
    await _setJsonList(_CacheKeys.menu, items);
  }

  /// Returns cached menu items, or empty list if no cache.
  List<Map<String, dynamic>> getCachedMenu() {
    if (_isDriftBacked) {
      // Drift queries are async; return empty for sync callers.
      // Use [getCachedMenuAsync] for Drift-backed instances.
      return [];
    }
    return _getJsonList(_CacheKeys.menu);
  }

  /// Async version of [getCachedMenu] that supports Drift-backed reads.
  Future<List<Map<String, dynamic>>> getCachedMenuAsync() async {
    if (_isDriftBacked) {
      return _getCachedMenuFromDrift();
    }
    return _getJsonList(_CacheKeys.menu);
  }

  // -- Cart -----------------------------------------------------------------

  /// Caches the cart items list.
  Future<void> cacheCart(List<Map<String, dynamic>> items) async {
    await _setJsonList(_CacheKeys.cart, items);
  }

  /// Returns cached cart items, or empty list if no cache.
  List<Map<String, dynamic>> getCachedCart() {
    return _getJsonList(_CacheKeys.cart);
  }

  // -- Orders ---------------------------------------------------------------

  /// Caches the order history list.
  Future<void> cacheOrders(List<Map<String, dynamic>> orders) async {
    await _setJsonList(_CacheKeys.orders, orders);
  }

  /// Returns cached orders, or empty list if no cache.
  List<Map<String, dynamic>> getCachedOrders() {
    return _getJsonList(_CacheKeys.orders);
  }

  // -- Stores ---------------------------------------------------------------

  /// Caches the store list.
  Future<void> cacheStores(List<Map<String, dynamic>> stores) async {
    await _setJsonList(_CacheKeys.stores, stores);
  }

  /// Returns cached stores, or empty list if no cache.
  List<Map<String, dynamic>> getCachedStores() {
    return _getJsonList(_CacheKeys.stores);
  }

  // -- Clear ----------------------------------------------------------------

  /// Clears all cached data.
  Future<void> clearCache() async {
    if (_db case final db?) {
      await db.delete(db.cachedMenuItems).go();
      return;
    }
    final prefs = _prefs!;
    await prefs.remove(_CacheKeys.menu);
    await prefs.remove(_CacheKeys.cart);
    await prefs.remove(_CacheKeys.orders);
    await prefs.remove(_CacheKeys.stores);
    await prefs.remove(_CacheKeys.timestamp(_CacheKeys.menu));
    await prefs.remove(_CacheKeys.timestamp(_CacheKeys.cart));
    await prefs.remove(_CacheKeys.timestamp(_CacheKeys.orders));
    await prefs.remove(_CacheKeys.timestamp(_CacheKeys.stores));
  }

  // -- Timestamp & freshness ------------------------------------------------

  /// Returns the timestamp when the given cache key was last written,
  /// or null if never cached.
  DateTime? getCacheTimestamp(String key) {
    if (_isDriftBacked) {
      // Drift-backed mode does not track per-key timestamps via prefs.
      return null;
    }
    final millis = _prefs!.getInt(_CacheKeys.timestamp(key));
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  /// Returns true if the cache for [key] exists and was written within
  /// the given [maxAge] duration.
  bool isCacheValid(String key, Duration maxAge) {
    if (_isDriftBacked) {
      // Drift-backed mode: cache validity is not tracked via prefs,
      // always return false so the caller attempts a fresh fetch.
      return false;
    }
    final timestamp = getCacheTimestamp(key);
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < maxAge;
  }

  // -- Drift helpers --------------------------------------------------------

  Future<void> _cacheMenuToDrift(List<Map<String, dynamic>> items) async {
    final db = _db!;
    await db.transaction(() async {
      await db.delete(db.cachedMenuItems).go();
      final now = DateTime.now();
      for (final item in items) {
        await db.into(db.cachedMenuItems).insert(
              CachedMenuItemsCompanion.insert(
                remoteId: (item['id'] ?? '').toString(),
                name: item['name'] as String? ?? '',
                description: Value(item['description'] as String?),
                price: (item['price'] as num?)?.toDouble() ?? 0.0,
                imageUrl: Value(item['image_url'] as String?),
                category: item['category'] as String? ?? '',
                isAvailable: Value(item['is_available'] as bool? ?? true),
                cachedAt: now,
              ),
            );
      }
    });
  }

  Future<List<Map<String, dynamic>>> _getCachedMenuFromDrift() async {
    final db = _db!;
    final rows = await db.select(db.cachedMenuItems).get();
    return rows
        .map((row) => <String, dynamic>{
              'id': int.tryParse(row.remoteId) ?? 0,
              'name': row.name,
              'description': row.description,
              'price': row.price.toInt(),
              'image_url': row.imageUrl,
              'category': row.category,
              'is_available': row.isAvailable,
            })
        .toList();
  }

  // -- Private helpers ------------------------------------------------------

  Future<void> _setJsonList(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    final prefs = _prefs!;
    final jsonString = jsonEncode(data);
    await prefs.setString(key, jsonString);
    await prefs.setInt(
      _CacheKeys.timestamp(key),
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  List<Map<String, dynamic>> _getJsonList(String key) {
    final prefs = _prefs;
    if (prefs == null) return [];
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (_) {
      return [];
    }
  }
}

/// Riverpod provider for [CacheService].
///
/// Requires [SharedPreferences] to be initialised before the app starts.
/// Override this provider in main.dart with the actual instance.
final cacheServiceProvider = Provider<CacheService>((ref) {
  // This will be overridden with the actual SharedPreferences instance
  // in the ProviderScope at app startup.
  throw UnimplementedError(
    'cacheServiceProvider must be overridden with a SharedPreferences instance.',
  );
});
