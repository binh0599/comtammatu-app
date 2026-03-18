import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_webhook.freezed.dart';
part 'payment_webhook.g.dart';

@freezed
class PaymentWebhook with _$PaymentWebhook {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaymentWebhook({
    required String provider,
    required String eventType,
    required Map<String, dynamic> payload,
    int? id,
    String? externalRef,
    Map<String, dynamic>? headers,
    String? signature,
    bool? signatureValid,
    int? httpStatus,
    @Default(false) bool processed,
    String? errorMessage,
    int? paymentId,
    int? orderId,
    DateTime? receivedAt,
  }) = _PaymentWebhook;

  const PaymentWebhook._();

  factory PaymentWebhook.fromJson(Map<String, dynamic> json) =>
      _$PaymentWebhookFromJson(json);

  bool get isMomo => provider == 'momo';
  bool get isPayos => provider == 'payos';
  bool get isVnpay => provider == 'vnpay';
}
