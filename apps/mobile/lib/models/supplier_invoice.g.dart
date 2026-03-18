// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierInvoiceImpl _$$SupplierInvoiceImplFromJson(
        Map<String, dynamic> json) =>
    _$SupplierInvoiceImpl(
      brandId: (json['brand_id'] as num).toInt(),
      supplierId: (json['supplier_id'] as num).toInt(),
      invoiceNumber: json['invoice_number'] as String,
      invoiceDate: DateTime.parse(json['invoice_date'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      vatAmount: (json['vat_amount'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
      poId: (json['po_id'] as num?)?.toInt(),
      grnId: (json['grn_id'] as num?)?.toInt(),
      vatRate: (json['vat_rate'] as num?)?.toDouble() ?? 10,
      status: json['status'] as String? ?? 'pending',
      matchStatus: json['match_status'] as String? ?? 'unmatched',
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$SupplierInvoiceImplToJson(
        _$SupplierInvoiceImpl instance) =>
    <String, dynamic>{
      'brand_id': instance.brandId,
      'supplier_id': instance.supplierId,
      'invoice_number': instance.invoiceNumber,
      'invoice_date': instance.invoiceDate.toIso8601String(),
      'subtotal': instance.subtotal,
      'vat_amount': instance.vatAmount,
      'total_amount': instance.totalAmount,
      'id': instance.id,
      'po_id': instance.poId,
      'grn_id': instance.grnId,
      'vat_rate': instance.vatRate,
      'status': instance.status,
      'match_status': instance.matchStatus,
      'due_date': instance.dueDate?.toIso8601String(),
      'paid_at': instance.paidAt?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
