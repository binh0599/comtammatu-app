// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettlementBatchImpl _$$SettlementBatchImplFromJson(
        Map<String, dynamic> json) =>
    _$SettlementBatchImpl(
      branchId: (json['branch_id'] as num).toInt(),
      settlementDate: DateTime.parse(json['settlement_date'] as String),
      method: json['method'] as String,
      id: (json['id'] as num?)?.toInt(),
      posSessionId: (json['pos_session_id'] as num?)?.toInt(),
      provider: json['provider'] as String?,
      totalSales: (json['total_sales'] as num?)?.toInt() ?? 0,
      totalRefunds: (json['total_refunds'] as num?)?.toInt() ?? 0,
      totalFees: (json['total_fees'] as num?)?.toInt() ?? 0,
      netAmount: (json['net_amount'] as num?)?.toInt() ?? 0,
      transactionCount: (json['transaction_count'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'open',
      reconciledBy: json['reconciled_by'] as String?,
      reconciledAt: json['reconciled_at'] == null
          ? null
          : DateTime.parse(json['reconciled_at'] as String),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$SettlementBatchImplToJson(
        _$SettlementBatchImpl instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'settlement_date': instance.settlementDate.toIso8601String(),
      'method': instance.method,
      'id': instance.id,
      'pos_session_id': instance.posSessionId,
      'provider': instance.provider,
      'total_sales': instance.totalSales,
      'total_refunds': instance.totalRefunds,
      'total_fees': instance.totalFees,
      'net_amount': instance.netAmount,
      'transaction_count': instance.transactionCount,
      'status': instance.status,
      'reconciled_by': instance.reconciledBy,
      'reconciled_at': instance.reconciledAt?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
