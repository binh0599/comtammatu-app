import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_invoice.freezed.dart';
part 'supplier_invoice.g.dart';

@freezed
class SupplierInvoice with _$SupplierInvoice {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SupplierInvoice({
    required int brandId,
    required int supplierId,
    required String invoiceNumber,
    required DateTime invoiceDate,
    required int subtotal,
    required int vatAmount,
    required int totalAmount,
    int? id,
    int? poId,
    int? grnId,
    @Default(10) double vatRate,
    @Default('pending') String status,
    @Default('unmatched') String matchStatus,
    DateTime? dueDate,
    DateTime? paidAt,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SupplierInvoice;

  const SupplierInvoice._();

  factory SupplierInvoice.fromJson(Map<String, dynamic> json) =>
      _$SupplierInvoiceFromJson(json);

  bool get isPaid => status == 'paid';
  bool get isDisputed => status == 'disputed';
  bool get isMatched => matchStatus == 'matched';
  bool get isOverdue =>
      dueDate != null && dueDate!.isBefore(DateTime.now()) && !isPaid;
}
