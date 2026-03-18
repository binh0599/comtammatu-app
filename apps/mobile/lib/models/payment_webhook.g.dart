// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_webhook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentWebhookImpl _$$PaymentWebhookImplFromJson(Map<String, dynamic> json) =>
    _$PaymentWebhookImpl(
      provider: json['provider'] as String,
      eventType: json['event_type'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      id: (json['id'] as num?)?.toInt(),
      externalRef: json['external_ref'] as String?,
      headers: json['headers'] as Map<String, dynamic>?,
      signature: json['signature'] as String?,
      signatureValid: json['signature_valid'] as bool?,
      httpStatus: (json['http_status'] as num?)?.toInt(),
      processed: json['processed'] as bool? ?? false,
      errorMessage: json['error_message'] as String?,
      paymentId: (json['payment_id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      receivedAt: json['received_at'] == null
          ? null
          : DateTime.parse(json['received_at'] as String),
    );

Map<String, dynamic> _$$PaymentWebhookImplToJson(
        _$PaymentWebhookImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'event_type': instance.eventType,
      'payload': instance.payload,
      'id': instance.id,
      'external_ref': instance.externalRef,
      'headers': instance.headers,
      'signature': instance.signature,
      'signature_valid': instance.signatureValid,
      'http_status': instance.httpStatus,
      'processed': instance.processed,
      'error_message': instance.errorMessage,
      'payment_id': instance.paymentId,
      'order_id': instance.orderId,
      'received_at': instance.receivedAt?.toIso8601String(),
    };
