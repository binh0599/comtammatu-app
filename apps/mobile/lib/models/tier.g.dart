// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TierProgressImpl _$$TierProgressImplFromJson(Map<String, dynamic> json) =>
    _$TierProgressImpl(
      name: json['name'] as String,
      tierCode: json['tier_code'] as String,
      minPoints: (json['min_points'] as num).toDouble(),
      pointsNeeded: (json['points_needed'] as num).toDouble(),
      progressPercent: (json['progress_percent'] as num).toDouble(),
    );

Map<String, dynamic> _$$TierProgressImplToJson(_$TierProgressImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tier_code': instance.tierCode,
      'min_points': instance.minPoints,
      'points_needed': instance.pointsNeeded,
      'progress_percent': instance.progressPercent,
    };

_$TierImpl _$$TierImplFromJson(Map<String, dynamic> json) => _$TierImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      tierCode: json['tier_code'] as String,
      pointMultiplier: (json['point_multiplier'] as num).toDouble(),
      cashbackPercent: (json['cashback_percent'] as num).toDouble(),
      benefits:
          (json['benefits'] as List<dynamic>).map((e) => e as String).toList(),
      nextTier: json['next_tier'] == null
          ? null
          : TierProgress.fromJson(json['next_tier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TierImplToJson(_$TierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tier_code': instance.tierCode,
      'point_multiplier': instance.pointMultiplier,
      'cashback_percent': instance.cashbackPercent,
      'benefits': instance.benefits,
      'next_tier': instance.nextTier,
    };
