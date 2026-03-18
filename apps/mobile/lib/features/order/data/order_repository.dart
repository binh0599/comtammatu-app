import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
import '../../../core/network/api_client.dart';
import '../../../models/cart_item.dart';
import '../../../models/delivery_order.dart';

/// Repository for order-related API calls with offline cache support.
class OrderRepository {
  const OrderRepository({
    required ApiClient apiClient,
    required CacheService cacheService,
  })  : _apiClient = apiClient,
        _cacheService = cacheService;

  final ApiClient _apiClient;
  final CacheService _cacheService;

  static const _cacheKey = 'cache_orders';
  static const _cacheMaxAge = Duration(seconds: 300); // 5 min

  /// Creates a new delivery order from the cart.
  ///
  /// [items] — list of cart items to order.
  /// [deliveryAddress] — full delivery address string.
  /// [latitude] / [longitude] — delivery coordinates.
  /// [note] — optional note for the kitchen or driver.
  /// [promotionId] — optional promotion to apply.
  Future<DeliveryOrder> createDeliveryOrder({
    required List<CartItem> items,
    required String deliveryAddress,
    required double latitude,
    required double longitude,
    String? note,
    int? promotionId,
  }) async {
    return _apiClient.post<DeliveryOrder>(
      '/create-delivery-order',
      data: {
        'items': items
            .map((item) => {
                  'menu_item_id': item.menuItem.id,
                  'quantity': item.quantity,
                  if (item.note != null) 'note': item.note,
                })
            .toList(),
        'delivery_address': deliveryAddress,
        'latitude': latitude,
        'longitude': longitude,
        if (note != null) 'note': note,
        if (promotionId != null) 'promotion_id': promotionId,
      },
      fromJson: (json) => DeliveryOrder.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Fetches paginated delivery order history.
  ///
  /// Uses cache-first strategy:
  /// 1. If cache is valid (< 5 min), return cached data immediately.
  /// 2. Otherwise, fetch from API and update cache.
  /// 3. On network error, fall back to stale cache.
  ///
  /// [cursor] — pagination cursor from previous response.
  /// [limit] — max orders per page (default 20).
  /// [status] — optional status filter (e.g. 'delivered', 'cancelled').
  Future<PaginatedOrders> getOrders({
    String? cursor,
    int limit = 20,
    String? status,
  }) async {
    // 1. Check fresh cache (only for first page without filters)
    if (cursor == null && status == null) {
      if (_cacheService.isCacheValid(_cacheKey, _cacheMaxAge)) {
        final cached = _cacheService.getCachedOrders();
        if (cached.isNotEmpty) {
          return PaginatedOrders.fromJson(
              {'orders': cached, 'has_more': false});
        }
      }
    }

    // 2. Try network
    try {
      final result = await _apiClient.get<PaginatedOrders>(
        '/get-transactions',
        queryParameters: {
          if (cursor != null) 'cursor': cursor,
          'limit': limit,
          if (status != null) 'status': status,
          'type': 'delivery_orders',
        },
        fromJson: (json) =>
            PaginatedOrders.fromJson(json as Map<String, dynamic>),
      );

      // Cache first page of unfiltered results
      if (cursor == null && status == null) {
        await _cacheService.cacheOrders(
          result.orders.map((o) => o.toJson()).toList(),
        );
      }

      return result;
    } catch (_) {
      // 3. Fallback to stale cache on network error (first page only)
      if (cursor == null && status == null) {
        final staleCache = _cacheService.getCachedOrders();
        if (staleCache.isNotEmpty) {
          return PaginatedOrders.fromJson({
            'orders': staleCache,
            'has_more': false,
          });
        }
      }
      rethrow;
    }
  }
}

/// Paginated response for delivery orders.
class PaginatedOrders {
  final List<DeliveryOrder> orders;
  final String? nextCursor;
  final bool hasMore;

  const PaginatedOrders({
    required this.orders,
    required this.hasMore,
    this.nextCursor,
  });

  factory PaginatedOrders.fromJson(Map<String, dynamic> json) {
    final data = json['orders'] as List<dynamic>? ??
        json['items'] as List<dynamic>? ??
        [];
    return PaginatedOrders(
      orders: data
          .map((e) => DeliveryOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['next_cursor'] as String?,
      hasMore: json['has_more'] as bool? ?? false,
    );
  }
}

/// Riverpod provider for [OrderRepository].
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return OrderRepository(apiClient: apiClient, cacheService: cacheService);
});
