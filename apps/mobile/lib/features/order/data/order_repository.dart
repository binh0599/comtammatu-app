import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/cart_item.dart';
import '../../../models/delivery_order.dart';

/// Repository for order-related API calls.
class OrderRepository {
  const OrderRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

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
  /// [cursor] — pagination cursor from previous response.
  /// [limit] — max orders per page (default 20).
  /// [status] — optional status filter (e.g. 'delivered', 'cancelled').
  Future<PaginatedOrders> getOrders({
    String? cursor,
    int limit = 20,
    String? status,
  }) async {
    return _apiClient.get<PaginatedOrders>(
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
  return OrderRepository(apiClient: apiClient);
});
