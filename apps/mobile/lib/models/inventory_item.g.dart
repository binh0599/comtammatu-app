// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryItemImpl _$$InventoryItemImplFromJson(Map<String, dynamic> json) =>
    _$InventoryItemImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      unit: json['unit'] as String,
      currentStock: (json['current_stock'] as num).toDouble(),
      minStock: (json['min_stock'] as num).toDouble(),
      maxStock: (json['max_stock'] as num).toDouble(),
      lastRestocked: DateTime.parse(json['last_restocked'] as String),
      pricePerUnit: (json['price_per_unit'] as num).toInt(),
      supplierId: (json['supplier_id'] as num?)?.toInt(),
      supplierName: json['supplier_name'] as String?,
    );

Map<String, dynamic> _$$InventoryItemImplToJson(_$InventoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'unit': instance.unit,
      'current_stock': instance.currentStock,
      'min_stock': instance.minStock,
      'max_stock': instance.maxStock,
      'last_restocked': instance.lastRestocked.toIso8601String(),
      'price_per_unit': instance.pricePerUnit,
      'supplier_id': instance.supplierId,
      'supplier_name': instance.supplierName,
    };
