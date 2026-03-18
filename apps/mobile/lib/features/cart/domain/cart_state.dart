import '../../../models/cart_item.dart';

/// State for the cart feature.
class CartState {
  const CartState({
    this.items = const [],
    this.deliveryFee = 0,
    this.discount = 0,
    this.paymentMethod = 'cod',
    this.deliveryAddress,
    this.latitude,
    this.longitude,
    this.note = '',
    this.couponCode,
    this.promotionId,
    this.isSubmitting = false,
    this.orderError,
  });

  final List<CartItem> items;
  final int deliveryFee;
  final int discount;
  final String paymentMethod;
  final String? deliveryAddress;
  final double? latitude;
  final double? longitude;
  final String note;
  final String? couponCode;
  final int? promotionId;
  final bool isSubmitting;
  final String? orderError;

  int get subtotal => items.fold(0, (sum, item) => sum + item.total);

  int get total => subtotal + deliveryFee - discount;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItem>? items,
    int? deliveryFee,
    int? discount,
    String? paymentMethod,
    String? deliveryAddress,
    double? latitude,
    double? longitude,
    String? note,
    String? couponCode,
    int? promotionId,
    bool? isSubmitting,
    String? orderError,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      note: note ?? this.note,
      couponCode: couponCode ?? this.couponCode,
      promotionId: promotionId ?? this.promotionId,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      orderError: orderError,
    );
  }
}
