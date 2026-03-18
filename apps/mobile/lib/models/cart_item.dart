import 'package:freezed_annotation/freezed_annotation.dart';

import 'menu_item.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CartItem({
    required MenuItem menuItem,
    required int quantity,
    String? note,
  }) = _CartItem;

  const CartItem._();

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  /// Total price for this cart line (unit price * quantity).
  int get total => menuItem.price * quantity;
}
