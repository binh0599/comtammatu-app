import 'package:freezed_annotation/freezed_annotation.dart';

import 'loyalty_member.dart';
import 'point_transaction.dart';
import 'promotion.dart';
import 'tier.dart';

part 'loyalty_dashboard.freezed.dart';
part 'loyalty_dashboard.g.dart';

@freezed
class LoyaltyStats with _$LoyaltyStats {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LoyaltyStats({
    required int totalCheckinsThisMonth,
    required int totalOrdersThisMonth,
    required int streakDays,
  }) = _LoyaltyStats;

  factory LoyaltyStats.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyStatsFromJson(json);
}

@freezed
class LoyaltyDashboard with _$LoyaltyDashboard {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LoyaltyDashboard({
    required LoyaltyMember member,
    required Tier tier,
    required List<PointTransaction> recentTransactions,
    required List<Promotion> activePromotions,
    required LoyaltyStats stats,
  }) = _LoyaltyDashboard;

  factory LoyaltyDashboard.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyDashboardFromJson(json);
}
