// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoyaltyMemberImpl _$$LoyaltyMemberImplFromJson(Map<String, dynamic> json) =>
    _$LoyaltyMemberImpl(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      totalPoints: (json['total_points'] as num).toInt(),
      availablePoints: (json['available_points'] as num).toInt(),
      lifetimePoints: (json['lifetime_points'] as num).toInt(),
      version: (json['version'] as num).toInt(),
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$LoyaltyMemberImplToJson(_$LoyaltyMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'total_points': instance.totalPoints,
      'available_points': instance.availablePoints,
      'lifetime_points': instance.lifetimePoints,
      'version': instance.version,
      'avatar_url': instance.avatarUrl,
    };
