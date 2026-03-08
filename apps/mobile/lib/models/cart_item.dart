import 'menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  final int quantity;
  final String? note;

  const CartItem({
    required this.menuItem,
    required this.quantity,
    this.note,
  });

  /// Total price for this cart line (unit price * quantity).
  double get total => menuItem.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menuItem: MenuItem.fromJson(json['menu_item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_item': menuItem.toJson(),
      'quantity': quantity,
      'note': note,
    };
  }

  CartItem copyWith({
    MenuItem? menuItem,
    int? quantity,
    String? note,
  }) {
    return CartItem(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          menuItem.id == other.menuItem.id &&
          note == other.note;

  @override
  int get hashCode => menuItem.id.hashCode ^ note.hashCode;

  @override
  String toString() =>
      'CartItem(name: ${menuItem.name}, qty: $quantity, total: $total)';
}
