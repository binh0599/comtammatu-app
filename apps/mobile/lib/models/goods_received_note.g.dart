// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_received_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsReceivedNoteImpl _$$GoodsReceivedNoteImplFromJson(
        Map<String, dynamic> json) =>
    _$GoodsReceivedNoteImpl(
      brandId: (json['brand_id'] as num).toInt(),
      branchId: (json['branch_id'] as num).toInt(),
      supplierId: (json['supplier_id'] as num).toInt(),
      grnNumber: json['grn_number'] as String,
      receivedBy: json['received_by'] as String,
      id: (json['id'] as num?)?.toInt(),
      poId: (json['po_id'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'draft',
      receivedDate: json['received_date'] == null
          ? null
          : DateTime.parse(json['received_date'] as String),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$GoodsReceivedNoteImplToJson(
        _$GoodsReceivedNoteImpl instance) =>
    <String, dynamic>{
      'brand_id': instance.brandId,
      'branch_id': instance.branchId,
      'supplier_id': instance.supplierId,
      'grn_number': instance.grnNumber,
      'received_by': instance.receivedBy,
      'id': instance.id,
      'po_id': instance.poId,
      'status': instance.status,
      'received_date': instance.receivedDate?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
