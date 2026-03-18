import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_received_note.freezed.dart';
part 'goods_received_note.g.dart';

@freezed
class GoodsReceivedNote with _$GoodsReceivedNote {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GoodsReceivedNote({
    required int brandId,
    required int branchId,
    required int supplierId,
    required String grnNumber,
    required String receivedBy,
    int? id,
    int? poId,
    @Default('draft') String status,
    DateTime? receivedDate,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GoodsReceivedNote;

  const GoodsReceivedNote._();

  factory GoodsReceivedNote.fromJson(Map<String, dynamic> json) =>
      _$GoodsReceivedNoteFromJson(json);

  bool get isDraft => status == 'draft';
  bool get isConfirmed => status == 'confirmed';
  bool get isCancelled => status == 'cancelled';
}
