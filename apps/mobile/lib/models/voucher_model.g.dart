// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherImpl _$$VoucherImplFromJson(Map<String, dynamic> json) =>
    _$VoucherImpl(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      discountType: json['discount_type'] as String,
      discountValue: (json['discount_value'] as num).toInt(),
      minOrderAmount: (json['min_order_amount'] as num).toInt(),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      pointsCost: (json['points_cost'] as num).toInt(),
      maxDiscount: (json['max_discount'] as num?)?.toInt(),
      isUsed: json['is_used'] as bool? ?? false,
    );

Map<String, dynamic> _$$VoucherImplToJson(_$VoucherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'min_order_amount': instance.minOrderAmount,
      'expires_at': instance.expiresAt.toIso8601String(),
      'points_cost': instance.pointsCost,
      'max_discount': instance.maxDiscount,
      'is_used': instance.isUsed,
    };
