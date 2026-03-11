// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      menuItemId: (json['menu_item_id'] as num).toInt(),
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'menu_item_id': instance.menuItemId,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'subtotal': instance.subtotal,
    };

_$DeliveryOrderImpl _$$DeliveryOrderImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryOrderImpl(
      orderId: (json['order_id'] as num).toInt(),
      deliveryOrderId: (json['delivery_order_id'] as num).toInt(),
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
      pointsWillEarn: (json['points_will_earn'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$DeliveryOrderImplToJson(_$DeliveryOrderImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'delivery_order_id': instance.deliveryOrderId,
      'status': instance.status,
      'items': instance.items,
      'subtotal': instance.subtotal,
      'delivery_fee': instance.deliveryFee,
      'discount': instance.discount,
      'total': instance.total,
      'estimated_delivery_at': instance.estimatedDeliveryAt.toIso8601String(),
      'points_will_earn': instance.pointsWillEarn,
      'created_at': instance.createdAt.toIso8601String(),
    };
