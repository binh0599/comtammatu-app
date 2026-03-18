import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund.freezed.dart';
part 'refund.g.dart';

@freezed
class Refund with _$Refund {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Refund({
    required int paymentId,
    required int orderId,
    required int branchId,
    required int amount,
    required String reason,
    required String method,
    required String requestedBy,
    required String idempotencyKey,
    int? id,
    @Default('pending') String status,
    String? providerRef,
    String? approvedBy,
    DateTime? processedAt,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Refund;

  const Refund._();

  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);

  bool get isPending => status == 'pending';
  bool get isProcessed => status == 'processed';
  bool get isRejected => status == 'rejected';
}
