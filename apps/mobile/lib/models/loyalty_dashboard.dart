import 'loyalty_member.dart';
import 'point_transaction.dart';
import 'promotion.dart';
import 'tier.dart';

class LoyaltyStats {
  final int totalCheckinsThisMonth;
  final int totalOrdersThisMonth;
  final int streakDays;

  const LoyaltyStats({
    required this.totalCheckinsThisMonth,
    required this.totalOrdersThisMonth,
    required this.streakDays,
  });

  factory LoyaltyStats.fromJson(Map<String, dynamic> json) {
    return LoyaltyStats(
      totalCheckinsThisMonth: json['total_checkins_this_month'] as int,
      totalOrdersThisMonth: json['total_orders_this_month'] as int,
      streakDays: json['streak_days'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_checkins_this_month': totalCheckinsThisMonth,
      'total_orders_this_month': totalOrdersThisMonth,
      'streak_days': streakDays,
    };
  }

  LoyaltyStats copyWith({
    int? totalCheckinsThisMonth,
    int? totalOrdersThisMonth,
    int? streakDays,
  }) {
    return LoyaltyStats(
      totalCheckinsThisMonth:
          totalCheckinsThisMonth ?? this.totalCheckinsThisMonth,
      totalOrdersThisMonth:
          totalOrdersThisMonth ?? this.totalOrdersThisMonth,
      streakDays: streakDays ?? this.streakDays,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoyaltyStats &&
          runtimeType == other.runtimeType &&
          totalCheckinsThisMonth == other.totalCheckinsThisMonth &&
          totalOrdersThisMonth == other.totalOrdersThisMonth &&
          streakDays == other.streakDays;

  @override
  int get hashCode =>
      totalCheckinsThisMonth.hashCode ^
      totalOrdersThisMonth.hashCode ^
      streakDays.hashCode;

  @override
  String toString() =>
      'LoyaltyStats(checkins: $totalCheckinsThisMonth, orders: $totalOrdersThisMonth, streak: $streakDays)';
}

class LoyaltyDashboard {
  final LoyaltyMember member;
  final Tier tier;
  final List<PointTransaction> recentTransactions;
  final List<Promotion> activePromotions;
  final LoyaltyStats stats;

  const LoyaltyDashboard({
    required this.member,
    required this.tier,
    required this.recentTransactions,
    required this.activePromotions,
    required this.stats,
  });

  factory LoyaltyDashboard.fromJson(Map<String, dynamic> json) {
    return LoyaltyDashboard(
      member:
          LoyaltyMember.fromJson(json['member'] as Map<String, dynamic>),
      tier: Tier.fromJson(json['tier'] as Map<String, dynamic>),
      recentTransactions: (json['recent_transactions'] as List<dynamic>)
          .map((e) => PointTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      activePromotions: (json['active_promotions'] as List<dynamic>)
          .map((e) => Promotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: LoyaltyStats.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member': member.toJson(),
      'tier': tier.toJson(),
      'recent_transactions':
          recentTransactions.map((e) => e.toJson()).toList(),
      'active_promotions':
          activePromotions.map((e) => e.toJson()).toList(),
      'stats': stats.toJson(),
    };
  }

  LoyaltyDashboard copyWith({
    LoyaltyMember? member,
    Tier? tier,
    List<PointTransaction>? recentTransactions,
    List<Promotion>? activePromotions,
    LoyaltyStats? stats,
  }) {
    return LoyaltyDashboard(
      member: member ?? this.member,
      tier: tier ?? this.tier,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      activePromotions: activePromotions ?? this.activePromotions,
      stats: stats ?? this.stats,
    );
  }

  @override
  String toString() =>
      'LoyaltyDashboard(member: ${member.fullName}, tier: ${tier.name})';
}
