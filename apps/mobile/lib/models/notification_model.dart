import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Model representing an in-app notification item.
@freezed
class NotificationItem with _$NotificationItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NotificationItem({
    required String id,
    required String title,
    required String body,
    required String type, // 'order' | 'promotion' | 'loyalty' | 'system'
    required bool isRead,
    required DateTime createdAt,
    Map<String, dynamic>? data,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}
