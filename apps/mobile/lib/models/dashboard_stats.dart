import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats.freezed.dart';
part 'dashboard_stats.g.dart';

@freezed
class DailyRevenue with _$DailyRevenue {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DailyRevenue({
    @Default('') String day,
    @Default(0) int amount,
  }) = _DailyRevenue;

  factory DailyRevenue.fromJson(Map<String, dynamic> json) =>
      _$DailyRevenueFromJson(json);
}

@freezed
class PopularItem with _$PopularItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PopularItem({
    @Default('') String name,
    @Default(0) int count,
    @Default(0) int revenue,
  }) = _PopularItem;

  factory PopularItem.fromJson(Map<String, dynamic> json) =>
      _$PopularItemFromJson(json);
}

@freezed
class DashboardStats with _$DashboardStats {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DashboardStats({
    @Default(0) int todayRevenue,
    @Default(0) int todayOrders,
    @Default(0) int avgOrderValue,
    @JsonKey(name: 'completed_count') @Default(0) int completedOrders,
    @JsonKey(name: 'cancelled_count') @Default(0) int cancelledOrders,
    @JsonKey(name: 'pending_count') @Default(0) int pendingOrders,
    @Default([]) List<DailyRevenue> weeklyRevenue,
    @Default([]) List<PopularItem> popularItems,
    @Default(0) int customerCount,
    @Default(0) int newCustomersToday,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}
