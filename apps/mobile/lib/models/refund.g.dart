// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefundImpl _$$RefundImplFromJson(Map<String, dynamic> json) => _$RefundImpl(
      paymentId: (json['payment_id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      branchId: (json['branch_id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      reason: json['reason'] as String,
      method: json['method'] as String,
      requestedBy: json['requested_by'] as String,
      idempotencyKey: json['idempotency_key'] as String,
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'pending',
      providerRef: json['provider_ref'] as String?,
      approvedBy: json['approved_by'] as String?,
      processedAt: json['processed_at'] == null
          ? null
          : DateTime.parse(json['processed_at'] as String),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$RefundImplToJson(_$RefundImpl instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'order_id': instance.orderId,
      'branch_id': instance.branchId,
      'amount': instance.amount,
      'reason': instance.reason,
      'method': instance.method,
      'requested_by': instance.requestedBy,
      'idempotency_key': instance.idempotencyKey,
      'id': instance.id,
      'status': instance.status,
      'provider_ref': instance.providerRef,
      'approved_by': instance.approvedBy,
      'processed_at': instance.processedAt?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
