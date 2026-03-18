// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grn_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GrnItemImpl _$$GrnItemImplFromJson(Map<String, dynamic> json) =>
    _$GrnItemImpl(
      grnId: (json['grn_id'] as num).toInt(),
      ingredientId: (json['ingredient_id'] as num).toInt(),
      quantityReceived: (json['quantity_received'] as num).toDouble(),
      unitCost: (json['unit_cost'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
      quantityOrdered: (json['quantity_ordered'] as num?)?.toDouble() ?? 0,
      quantityRejected: (json['quantity_rejected'] as num?)?.toDouble() ?? 0,
      batchRef: json['batch_ref'] as String?,
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$GrnItemImplToJson(_$GrnItemImpl instance) =>
    <String, dynamic>{
      'grn_id': instance.grnId,
      'ingredient_id': instance.ingredientId,
      'quantity_received': instance.quantityReceived,
      'unit_cost': instance.unitCost,
      'id': instance.id,
      'quantity_ordered': instance.quantityOrdered,
      'quantity_rejected': instance.quantityRejected,
      'batch_ref': instance.batchRef,
      'expiry_date': instance.expiryDate?.toIso8601String(),
      'notes': instance.notes,
    };
