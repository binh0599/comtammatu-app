import 'package:freezed_annotation/freezed_annotation.dart';

part 'grn_item.freezed.dart';
part 'grn_item.g.dart';

@freezed
class GrnItem with _$GrnItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GrnItem({
    required int grnId,
    required int ingredientId,
    required double quantityReceived,
    required double unitCost,
    int? id,
    @Default(0) double quantityOrdered,
    @Default(0) double quantityRejected,
    String? batchRef,
    DateTime? expiryDate,
    String? notes,
  }) = _GrnItem;

  const GrnItem._();

  factory GrnItem.fromJson(Map<String, dynamic> json) =>
      _$GrnItemFromJson(json);

  double get quantityAccepted => quantityReceived - quantityRejected;
  double get lineTotal => quantityReceived * unitCost;
}
