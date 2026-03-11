import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

/// Model đại diện cho một mặt hàng trong kho.
@freezed
class InventoryItem with _$InventoryItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory InventoryItem({
    required int id,
    required String name,
    required String category,
    required String unit,
    required double currentStock,
    required double minStock,
    required double maxStock,
    required DateTime lastRestocked,
    required int pricePerUnit,
    int? supplierId,
    String? supplierName,
  }) = _InventoryItem;

  const InventoryItem._();

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  /// Kiểm tra mặt hàng sắp hết (dưới mức tồn kho tối thiểu).
  bool get isLowStock => currentStock < minStock;

  /// Phần trăm tồn kho hiện tại so với tối đa (0.0 - 1.0).
  double get stockPercentage =>
      maxStock > 0 ? (currentStock / maxStock).clamp(0.0, 1.0) : 0.0;
}
