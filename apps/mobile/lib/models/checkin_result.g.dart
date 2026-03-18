// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BranchImpl _$$BranchImplFromJson(Map<String, dynamic> json) => _$BranchImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$$BranchImplToJson(_$BranchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
    };

_$CheckinStreakImpl _$$CheckinStreakImplFromJson(Map<String, dynamic> json) =>
    _$CheckinStreakImpl(
      current: (json['current'] as num).toInt(),
      bonus: (json['bonus'] as num).toInt(),
      nextMilestone: (json['next_milestone'] as num).toInt(),
      nextMilestoneBonus: (json['next_milestone_bonus'] as num).toInt(),
    );

Map<String, dynamic> _$$CheckinStreakImplToJson(_$CheckinStreakImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'bonus': instance.bonus,
      'next_milestone': instance.nextMilestone,
      'next_milestone_bonus': instance.nextMilestoneBonus,
    };

_$CheckinResultImpl _$$CheckinResultImplFromJson(Map<String, dynamic> json) =>
    _$CheckinResultImpl(
      checkinId: (json['checkin_id'] as num).toInt(),
      branch: Branch.fromJson(json['branch'] as Map<String, dynamic>),
      pointsEarned: (json['points_earned'] as num).toInt(),
      newBalance: (json['new_balance'] as num).toInt(),
      streak: CheckinStreak.fromJson(json['streak'] as Map<String, dynamic>),
      checkedInAt: DateTime.parse(json['checked_in_at'] as String),
    );

Map<String, dynamic> _$$CheckinResultImplToJson(_$CheckinResultImpl instance) =>
    <String, dynamic>{
      'checkin_id': instance.checkinId,
      'branch': instance.branch,
      'points_earned': instance.pointsEarned,
      'new_balance': instance.newBalance,
      'streak': instance.streak,
      'checked_in_at': instance.checkedInAt.toIso8601String(),
    };
