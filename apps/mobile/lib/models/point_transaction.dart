import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_transaction.freezed.dart';
part 'point_transaction.g.dart';

@freezed
class PointTransaction with _$PointTransaction {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PointTransaction({
    required int id,
    required String type,
    required int points,
    required int balanceAfter,
    required String description,
    required DateTime createdAt,
    String? referenceType,
    int? referenceId,
  }) = _PointTransaction;

  const PointTransaction._();

  factory PointTransaction.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionFromJson(json);

  /// Whether this transaction added points (earn, cashback, checkin_bonus, positive adjust).
  bool get isCredit => points > 0;

  /// Whether this transaction removed points (redeem, expire, negative adjust).
  bool get isDebit => points < 0;
}
