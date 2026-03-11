// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoyaltyStatsImpl _$$LoyaltyStatsImplFromJson(Map<String, dynamic> json) =>
    _$LoyaltyStatsImpl(
      totalCheckinsThisMonth:
          (json['total_checkins_this_month'] as num).toInt(),
      totalOrdersThisMonth: (json['total_orders_this_month'] as num).toInt(),
      streakDays: (json['streak_days'] as num).toInt(),
    );

Map<String, dynamic> _$$LoyaltyStatsImplToJson(_$LoyaltyStatsImpl instance) =>
    <String, dynamic>{
      'total_checkins_this_month': instance.totalCheckinsThisMonth,
      'total_orders_this_month': instance.totalOrdersThisMonth,
      'streak_days': instance.streakDays,
    };

_$LoyaltyDashboardImpl _$$LoyaltyDashboardImplFromJson(
        Map<String, dynamic> json) =>
    _$LoyaltyDashboardImpl(
      member: LoyaltyMember.fromJson(json['member'] as Map<String, dynamic>),
      tier: Tier.fromJson(json['tier'] as Map<String, dynamic>),
      recentTransactions: (json['recent_transactions'] as List<dynamic>)
          .map((e) => PointTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      activePromotions: (json['active_promotions'] as List<dynamic>)
          .map((e) => Promotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: LoyaltyStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoyaltyDashboardImplToJson(
        _$LoyaltyDashboardImpl instance) =>
    <String, dynamic>{
      'member': instance.member,
      'tier': instance.tier,
      'recent_transactions': instance.recentTransactions,
      'active_promotions': instance.activePromotions,
      'stats': instance.stats,
    };
