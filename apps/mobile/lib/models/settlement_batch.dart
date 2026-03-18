import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_batch.freezed.dart';
part 'settlement_batch.g.dart';

@freezed
class SettlementBatch with _$SettlementBatch {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SettlementBatch({
    required int branchId,
    required DateTime settlementDate,
    required String method,
    int? id,
    int? posSessionId,
    String? provider,
    @Default(0) int totalSales,
    @Default(0) int totalRefunds,
    @Default(0) int totalFees,
    @Default(0) int netAmount,
    @Default(0) int transactionCount,
    @Default('open') String status,
    String? reconciledBy,
    DateTime? reconciledAt,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SettlementBatch;

  const SettlementBatch._();

  factory SettlementBatch.fromJson(Map<String, dynamic> json) =>
      _$SettlementBatchFromJson(json);

  bool get isReconciled => status == 'reconciled';
  bool get isDisputed => status == 'disputed';
}
