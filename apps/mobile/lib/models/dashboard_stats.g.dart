// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRevenueImpl _$$DailyRevenueImplFromJson(Map<String, dynamic> json) =>
    _$DailyRevenueImpl(
      day: json['day'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DailyRevenueImplToJson(_$DailyRevenueImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'amount': instance.amount,
    };

_$PopularItemImpl _$$PopularItemImplFromJson(Map<String, dynamic> json) =>
    _$PopularItemImpl(
      name: json['name'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
      revenue: (json['revenue'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PopularItemImplToJson(_$PopularItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'revenue': instance.revenue,
    };

_$DashboardStatsImpl _$$DashboardStatsImplFromJson(Map<String, dynamic> json) =>
    _$DashboardStatsImpl(
      todayRevenue: (json['today_revenue'] as num?)?.toInt() ?? 0,
      todayOrders: (json['today_orders'] as num?)?.toInt() ?? 0,
      avgOrderValue: (json['avg_order_value'] as num?)?.toInt() ?? 0,
      completedOrders: (json['completed_count'] as num?)?.toInt() ?? 0,
      cancelledOrders: (json['cancelled_count'] as num?)?.toInt() ?? 0,
      pendingOrders: (json['pending_count'] as num?)?.toInt() ?? 0,
      weeklyRevenue: (json['weekly_revenue'] as List<dynamic>?)
              ?.map((e) => DailyRevenue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      popularItems: (json['popular_items'] as List<dynamic>?)
              ?.map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      customerCount: (json['customer_count'] as num?)?.toInt() ?? 0,
      newCustomersToday: (json['new_customers_today'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DashboardStatsImplToJson(
        _$DashboardStatsImpl instance) =>
    <String, dynamic>{
      'today_revenue': instance.todayRevenue,
      'today_orders': instance.todayOrders,
      'avg_order_value': instance.avgOrderValue,
      'completed_count': instance.completedOrders,
      'cancelled_count': instance.cancelledOrders,
      'pending_count': instance.pendingOrders,
      'weekly_revenue': instance.weeklyRevenue,
      'popular_items': instance.popularItems,
      'customer_count': instance.customerCount,
      'new_customers_today': instance.newCustomersToday,
    };
