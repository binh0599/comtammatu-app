import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

/// Model representing a user feedback entry for an order.
@freezed
class FeedbackModel with _$FeedbackModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FeedbackModel({
    required int id,
    required int orderId,
    required int rating,
    required String comment,
    required DateTime createdAt,
    @Default([]) List<String> tags,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);
}
