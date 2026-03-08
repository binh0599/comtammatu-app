import '../../../models/cart_item.dart';

/// State for the cart feature.
class CartState {
  const CartState({
    this.items = const [],
    this.deliveryFee = 0,
    this.discount = 0,
    this.paymentMethod = 'cod',
    this.addressId,
    this.note = '',
    this.couponCode,
  });

  final List<CartItem> items;
  final double deliveryFee;
  final double discount;
  final String paymentMethod;
  final int? addressId;
  final String note;
  final String? couponCode;

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.total);

  double get total => subtotal + deliveryFee - discount;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItem>? items,
    double? deliveryFee,
    double? discount,
    String? paymentMethod,
    int? addressId,
    String? note,
    String? couponCode,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      addressId: addressId ?? this.addressId,
      note: note ?? this.note,
      couponCode: couponCode ?? this.couponCode,
    );
  }
}
