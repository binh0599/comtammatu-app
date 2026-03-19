import 'package:freezed_annotation/freezed_annotation.dart';

part 'einvoice.freezed.dart';
part 'einvoice.g.dart';

@freezed
class Einvoice with _$Einvoice {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Einvoice({
    required int brandId,
    required int branchId,
    required int orderId,
    required int configId,
    int? id,
    int? paymentId,
    String? invoiceNumber,
    String? serial,
    @Default('draft') String status,
    String? buyerName,
    String? buyerTaxCode,
    String? buyerAddress,
    @Default(0) int subtotal,
    @Default(0) int taxAmount,
    @Default(0) int total,
    Map<String, dynamic>? xmlPayload,
    Map<String, dynamic>? providerResponse,
    DateTime? submittedAt,
    DateTime? signedAt,
    DateTime? cancelledAt,
    String? errorMessage,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Einvoice;

  const Einvoice._();

  factory Einvoice.fromJson(Map<String, dynamic> json) =>
      _$EinvoiceFromJson(json);

  bool get isDraft => status == 'draft';
  bool get isPending => status == 'pending';
  bool get isSubmitted => status == 'submitted';
  bool get isSigned => status == 'signed';
  bool get isCancelled => status == 'cancelled';
  bool get hasError => status == 'error';
}
