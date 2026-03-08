import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
class CacheService {
  CacheService({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  // -- Menu -----------------------------------------------------------------

  /// Caches the menu items list.
  Future<void> cacheMenu(List<Map<String, dynamic>> items) async {
    await _setJsonList(_CacheKeys.menu, items);
  }

  /// Returns cached menu items, or empty list if no cache.
  List<Map<String, dynamic>> getCachedMenu() {
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
    await _prefs.remove(_CacheKeys.menu);
    await _prefs.remove(_CacheKeys.cart);
    await _prefs.remove(_CacheKeys.orders);
    await _prefs.remove(_CacheKeys.stores);
    await _prefs.remove(_CacheKeys.timestamp(_CacheKeys.menu));
    await _prefs.remove(_CacheKeys.timestamp(_CacheKeys.cart));
    await _prefs.remove(_CacheKeys.timestamp(_CacheKeys.orders));
    await _prefs.remove(_CacheKeys.timestamp(_CacheKeys.stores));
  }

  // -- Timestamp & freshness ------------------------------------------------

  /// Returns the timestamp when the given cache key was last written,
  /// or null if never cached.
  DateTime? getCacheTimestamp(String key) {
    final millis = _prefs.getInt(_CacheKeys.timestamp(key));
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  /// Returns true if the cache for [key] exists and was written within
  /// the given [maxAge] duration.
  bool isCacheValid(String key, Duration maxAge) {
    final timestamp = getCacheTimestamp(key);
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < maxAge;
  }

  // -- Private helpers ------------------------------------------------------

  Future<void> _setJsonList(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    final jsonString = jsonEncode(data);
    await _prefs.setString(key, jsonString);
    await _prefs.setInt(
      _CacheKeys.timestamp(key),
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  List<Map<String, dynamic>> _getJsonList(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return [];
    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
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
