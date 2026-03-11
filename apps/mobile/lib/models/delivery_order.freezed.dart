// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  int get menuItemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call(
      {int menuItemId,
      String name,
      int quantity,
      double unitPrice,
      double subtotal});
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItemId = null,
    Object? name = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? subtotal = null,
  }) {
    return _then(_value.copyWith(
      menuItemId: null == menuItemId
          ? _value.menuItemId
          : menuItemId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
          _$OrderItemImpl value, $Res Function(_$OrderItemImpl) then) =
      __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int menuItemId,
      String name,
      int quantity,
      double unitPrice,
      double subtotal});
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
      _$OrderItemImpl _value, $Res Function(_$OrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItemId = null,
    Object? name = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? subtotal = null,
  }) {
    return _then(_$OrderItemImpl(
      menuItemId: null == menuItemId
          ? _value.menuItemId
          : menuItemId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$OrderItemImpl extends _OrderItem {
  const _$OrderItemImpl(
      {required this.menuItemId,
      required this.name,
      required this.quantity,
      required this.unitPrice,
      required this.subtotal})
      : super._();

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final int menuItemId;
  @override
  final String name;
  @override
  final int quantity;
  @override
  final double unitPrice;
  @override
  final double subtotal;

  @override
  String toString() {
    return 'OrderItem(menuItemId: $menuItemId, name: $name, quantity: $quantity, unitPrice: $unitPrice, subtotal: $subtotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, menuItemId, name, quantity, unitPrice, subtotal);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(
      this,
    );
  }
}

abstract class _OrderItem extends OrderItem {
  const factory _OrderItem(
      {required final int menuItemId,
      required final String name,
      required final int quantity,
      required final double unitPrice,
      required final double subtotal}) = _$OrderItemImpl;
  const _OrderItem._() : super._();

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  int get menuItemId;
  @override
  String get name;
  @override
  int get quantity;
  @override
  double get unitPrice;
  @override
  double get subtotal;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliveryOrder _$DeliveryOrderFromJson(Map<String, dynamic> json) {
  return _DeliveryOrder.fromJson(json);
}

/// @nodoc
mixin _$DeliveryOrder {
  int get orderId => throw _privateConstructorUsedError;
  int get deliveryOrderId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<OrderItem> get items => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get deliveryFee => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  DateTime get estimatedDeliveryAt => throw _privateConstructorUsedError;
  int get pointsWillEarn => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DeliveryOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryOrderCopyWith<DeliveryOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryOrderCopyWith<$Res> {
  factory $DeliveryOrderCopyWith(
          DeliveryOrder value, $Res Function(DeliveryOrder) then) =
      _$DeliveryOrderCopyWithImpl<$Res, DeliveryOrder>;
  @useResult
  $Res call(
      {int orderId,
      int deliveryOrderId,
      String status,
      List<OrderItem> items,
      double subtotal,
      double deliveryFee,
      double discount,
      double total,
      DateTime estimatedDeliveryAt,
      int pointsWillEarn,
      DateTime createdAt});
}

/// @nodoc
class _$DeliveryOrderCopyWithImpl<$Res, $Val extends DeliveryOrder>
    implements $DeliveryOrderCopyWith<$Res> {
  _$DeliveryOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? deliveryOrderId = null,
    Object? status = null,
    Object? items = null,
    Object? subtotal = null,
    Object? deliveryFee = null,
    Object? discount = null,
    Object? total = null,
    Object? estimatedDeliveryAt = null,
    Object? pointsWillEarn = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryOrderId: null == deliveryOrderId
          ? _value.deliveryOrderId
          : deliveryOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDeliveryAt: null == estimatedDeliveryAt
          ? _value.estimatedDeliveryAt
          : estimatedDeliveryAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pointsWillEarn: null == pointsWillEarn
          ? _value.pointsWillEarn
          : pointsWillEarn // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliveryOrderImplCopyWith<$Res>
    implements $DeliveryOrderCopyWith<$Res> {
  factory _$$DeliveryOrderImplCopyWith(
          _$DeliveryOrderImpl value, $Res Function(_$DeliveryOrderImpl) then) =
      __$$DeliveryOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderId,
      int deliveryOrderId,
      String status,
      List<OrderItem> items,
      double subtotal,
      double deliveryFee,
      double discount,
      double total,
      DateTime estimatedDeliveryAt,
      int pointsWillEarn,
      DateTime createdAt});
}

/// @nodoc
class __$$DeliveryOrderImplCopyWithImpl<$Res>
    extends _$DeliveryOrderCopyWithImpl<$Res, _$DeliveryOrderImpl>
    implements _$$DeliveryOrderImplCopyWith<$Res> {
  __$$DeliveryOrderImplCopyWithImpl(
      _$DeliveryOrderImpl _value, $Res Function(_$DeliveryOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? deliveryOrderId = null,
    Object? status = null,
    Object? items = null,
    Object? subtotal = null,
    Object? deliveryFee = null,
    Object? discount = null,
    Object? total = null,
    Object? estimatedDeliveryAt = null,
    Object? pointsWillEarn = null,
    Object? createdAt = null,
  }) {
    return _then(_$DeliveryOrderImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryOrderId: null == deliveryOrderId
          ? _value.deliveryOrderId
          : deliveryOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDeliveryAt: null == estimatedDeliveryAt
          ? _value.estimatedDeliveryAt
          : estimatedDeliveryAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pointsWillEarn: null == pointsWillEarn
          ? _value.pointsWillEarn
          : pointsWillEarn // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DeliveryOrderImpl extends _DeliveryOrder {
  const _$DeliveryOrderImpl(
      {required this.orderId,
      required this.deliveryOrderId,
      required this.status,
      required final List<OrderItem> items,
      required this.subtotal,
      required this.deliveryFee,
      required this.discount,
      required this.total,
      required this.estimatedDeliveryAt,
      required this.pointsWillEarn,
      required this.createdAt})
      : _items = items,
        super._();

  factory _$DeliveryOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryOrderImplFromJson(json);

  @override
  final int orderId;
  @override
  final int deliveryOrderId;
  @override
  final String status;
  final List<OrderItem> _items;
  @override
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double subtotal;
  @override
  final double deliveryFee;
  @override
  final double discount;
  @override
  final double total;
  @override
  final DateTime estimatedDeliveryAt;
  @override
  final int pointsWillEarn;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'DeliveryOrder(orderId: $orderId, deliveryOrderId: $deliveryOrderId, status: $status, items: $items, subtotal: $subtotal, deliveryFee: $deliveryFee, discount: $discount, total: $total, estimatedDeliveryAt: $estimatedDeliveryAt, pointsWillEarn: $pointsWillEarn, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryOrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.deliveryOrderId, deliveryOrderId) ||
                other.deliveryOrderId == deliveryOrderId) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.estimatedDeliveryAt, estimatedDeliveryAt) ||
                other.estimatedDeliveryAt == estimatedDeliveryAt) &&
            (identical(other.pointsWillEarn, pointsWillEarn) ||
                other.pointsWillEarn == pointsWillEarn) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      deliveryOrderId,
      status,
      const DeepCollectionEquality().hash(_items),
      subtotal,
      deliveryFee,
      discount,
      total,
      estimatedDeliveryAt,
      pointsWillEarn,
      createdAt);

  /// Create a copy of DeliveryOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryOrderImplCopyWith<_$DeliveryOrderImpl> get copyWith =>
      __$$DeliveryOrderImplCopyWithImpl<_$DeliveryOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryOrderImplToJson(
      this,
    );
  }
}

abstract class _DeliveryOrder extends DeliveryOrder {
  const factory _DeliveryOrder(
      {required final int orderId,
      required final int deliveryOrderId,
      required final String status,
      required final List<OrderItem> items,
      required final double subtotal,
      required final double deliveryFee,
      required final double discount,
      required final double total,
      required final DateTime estimatedDeliveryAt,
      required final int pointsWillEarn,
      required final DateTime createdAt}) = _$DeliveryOrderImpl;
  const _DeliveryOrder._() : super._();

  factory _DeliveryOrder.fromJson(Map<String, dynamic> json) =
      _$DeliveryOrderImpl.fromJson;

  @override
  int get orderId;
  @override
  int get deliveryOrderId;
  @override
  String get status;
  @override
  List<OrderItem> get items;
  @override
  double get subtotal;
  @override
  double get deliveryFee;
  @override
  double get discount;
  @override
  double get total;
  @override
  DateTime get estimatedDeliveryAt;
  @override
  int get pointsWillEarn;
  @override
  DateTime get createdAt;

  /// Create a copy of DeliveryOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryOrderImplCopyWith<_$DeliveryOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
