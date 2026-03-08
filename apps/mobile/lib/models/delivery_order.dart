class OrderItem {
  final int menuItemId;
  final String name;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  const OrderItem({
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      menuItemId: json['menu_item_id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unit_price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_item_id': menuItemId,
      'name': name,
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,
    };
  }

  OrderItem copyWith({
    int? menuItemId,
    String? name,
    int? quantity,
    double? unitPrice,
    double? subtotal,
  }) {
    return OrderItem(
      menuItemId: menuItemId ?? this.menuItemId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          menuItemId == other.menuItemId;

  @override
  int get hashCode => menuItemId.hashCode;

  @override
  String toString() =>
      'OrderItem(name: $name, qty: $quantity, subtotal: $subtotal)';
}

class DeliveryOrder {
  final int orderId;
  final int deliveryOrderId;
  final String status;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final DateTime estimatedDeliveryAt;
  final int pointsWillEarn;
  final DateTime createdAt;

  const DeliveryOrder({
    required this.orderId,
    required this.deliveryOrderId,
    required this.status,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.estimatedDeliveryAt,
    required this.pointsWillEarn,
    required this.createdAt,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryOrder(
      orderId: json['order_id'] as int,
      deliveryOrderId: json['delivery_order_id'] as int,
      status: json['status'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      estimatedDeliveryAt:
          DateTime.parse(json['estimated_delivery_at'] as String),
      pointsWillEarn: json['points_will_earn'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'delivery_order_id': deliveryOrderId,
      'status': status,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'total': total,
      'estimated_delivery_at': estimatedDeliveryAt.toIso8601String(),
      'points_will_earn': pointsWillEarn,
      'created_at': createdAt.toIso8601String(),
    };
  }

  DeliveryOrder copyWith({
    int? orderId,
    int? deliveryOrderId,
    String? status,
    List<OrderItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? discount,
    double? total,
    DateTime? estimatedDeliveryAt,
    int? pointsWillEarn,
    DateTime? createdAt,
  }) {
    return DeliveryOrder(
      orderId: orderId ?? this.orderId,
      deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
      status: status ?? this.status,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      estimatedDeliveryAt:
          estimatedDeliveryAt ?? this.estimatedDeliveryAt,
      pointsWillEarn: pointsWillEarn ?? this.pointsWillEarn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryOrder &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId;

  @override
  int get hashCode => orderId.hashCode;

  @override
  String toString() =>
      'DeliveryOrder(orderId: $orderId, status: $status, total: $total)';
}
