/// Model đại diện cho một mặt hàng trong kho.
class InventoryItem {
  final int id;
  final String name;
  final String category;
  final String unit;
  final double currentStock;
  final double minStock;
  final double maxStock;
  final DateTime lastRestocked;
  final int pricePerUnit;
  final int? supplierId;
  final String? supplierName;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.currentStock,
    required this.minStock,
    required this.maxStock,
    required this.lastRestocked,
    required this.pricePerUnit,
    this.supplierId,
    this.supplierName,
  });

  /// Kiểm tra mặt hàng sắp hết (dưới mức tồn kho tối thiểu).
  bool get isLowStock => currentStock < minStock;

  /// Phần trăm tồn kho hiện tại so với tối đa (0.0 - 1.0).
  double get stockPercentage =>
      maxStock > 0 ? (currentStock / maxStock).clamp(0.0, 1.0) : 0.0;

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      unit: json['unit'] as String,
      currentStock: (json['current_stock'] as num).toDouble(),
      minStock: (json['min_stock'] as num).toDouble(),
      maxStock: (json['max_stock'] as num).toDouble(),
      lastRestocked: DateTime.parse(json['last_restocked'] as String),
      pricePerUnit: json['price_per_unit'] as int,
      supplierId: json['supplier_id'] as int?,
      supplierName: json['supplier_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
      'current_stock': currentStock,
      'min_stock': minStock,
      'max_stock': maxStock,
      'last_restocked': lastRestocked.toIso8601String(),
      'price_per_unit': pricePerUnit,
      'supplier_id': supplierId,
      'supplier_name': supplierName,
    };
  }

  InventoryItem copyWith({
    int? id,
    String? name,
    String? category,
    String? unit,
    double? currentStock,
    double? minStock,
    double? maxStock,
    DateTime? lastRestocked,
    int? pricePerUnit,
    int? supplierId,
    String? supplierName,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      lastRestocked: lastRestocked ?? this.lastRestocked,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'InventoryItem(id: $id, name: $name, stock: $currentStock/$maxStock $unit)';
}
