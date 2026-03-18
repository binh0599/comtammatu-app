import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_order.freezed.dart';
part 'delivery_order.g.dart';

@freezed
class OrderItem with _$OrderItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OrderItem({
    required int menuItemId,
    required String name,
    required int quantity,
    required int unitPrice,
    required int subtotal,
  }) = _OrderItem;

  const OrderItem._();

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

@freezed
class DeliveryOrder with _$DeliveryOrder {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeliveryOrder({
    required int orderId,
    required int deliveryOrderId,
    required String status,
    required List<OrderItem> items,
    required int subtotal,
    required int deliveryFee,
    required int discount,
    required int total,
    required DateTime estimatedDeliveryAt,
    required int pointsWillEarn,
    required DateTime createdAt,
  }) = _DeliveryOrder;

  const DeliveryOrder._();

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOrderFromJson(json);
}
