// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionImpl _$$PromotionImplFromJson(Map<String, dynamic> json) =>
    _$PromotionImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      cashbackType: json['cashback_type'] as String,
      cashbackValue: (json['cashback_value'] as num).toInt(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      eligible: json['eligible'] as bool,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$PromotionImplToJson(_$PromotionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cashback_type': instance.cashbackType,
      'cashback_value': instance.cashbackValue,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'eligible': instance.eligible,
      'image_url': instance.imageUrl,
    };
