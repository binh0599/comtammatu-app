import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion.freezed.dart';
part 'promotion.g.dart';

@freezed
class Promotion with _$Promotion {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Promotion({
    required int id,
    required String name,
    required String description,
    required String cashbackType,
    required double cashbackValue,
    required DateTime startDate,
    required DateTime endDate,
    required bool eligible,
    String? imageUrl,
  }) = _Promotion;

  const Promotion._();

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  /// Whether the promotion is currently active based on date range.
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }
}
