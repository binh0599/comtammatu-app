class DailyRevenue {
  const DailyRevenue({
    required this.day,
    required this.amount,
  });

  final String day;
  final int amount;

  factory DailyRevenue.fromJson(Map<String, dynamic> json) {
    return DailyRevenue(
      day: json['day'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ??
          (json['revenue'] as num?)?.toInt() ??
          0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'amount': amount,
    };
  }
}

class PopularItem {
  const PopularItem({
    required this.name,
    required this.count,
    required this.revenue,
  });

  final String name;
  final int count;
  final int revenue;

  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      name: json['name'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ??
          (json['total_quantity'] as num?)?.toInt() ??
          0,
      revenue: (json['revenue'] as num?)?.toInt() ??
          (json['total_revenue'] as num?)?.toInt() ??
          0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'count': count,
      'revenue': revenue,
    };
  }
}

class DashboardStats {
  const DashboardStats({
    required this.todayRevenue,
    required this.todayOrders,
    required this.avgOrderValue,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.pendingOrders,
    required this.weeklyRevenue,
    required this.popularItems,
    required this.customerCount,
    required this.newCustomersToday,
  });

  final int todayRevenue;
  final int todayOrders;
  final int avgOrderValue;
  final int completedOrders;
  final int cancelledOrders;
  final int pendingOrders;
  final List<DailyRevenue> weeklyRevenue;
  final List<PopularItem> popularItems;
  final int customerCount;
  final int newCustomersToday;

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      todayRevenue: (json['today_revenue'] as num?)?.toInt() ?? 0,
      todayOrders: (json['today_orders'] as num?)?.toInt() ?? 0,
      avgOrderValue: (json['avg_order_value'] as num?)?.toInt() ?? 0,
      completedOrders: (json['completed_count'] as num?)?.toInt() ?? 0,
      cancelledOrders: (json['cancelled_count'] as num?)?.toInt() ?? 0,
      pendingOrders: (json['pending_count'] as num?)?.toInt() ?? 0,
      weeklyRevenue: (json['weekly_revenue'] as List<dynamic>?)
              ?.map((e) => DailyRevenue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      popularItems: (json['popular_items'] as List<dynamic>?)
              ?.map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      customerCount: (json['customer_count'] as num?)?.toInt() ?? 0,
      newCustomersToday: (json['new_customers_today'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today_revenue': todayRevenue,
      'today_orders': todayOrders,
      'avg_order_value': avgOrderValue,
      'completed_orders': completedOrders,
      'cancelled_orders': cancelledOrders,
      'pending_orders': pendingOrders,
      'weekly_revenue': weeklyRevenue.map((e) => e.toJson()).toList(),
      'popular_items': popularItems.map((e) => e.toJson()).toList(),
      'customer_count': customerCount,
      'new_customers_today': newCustomersToday,
    };
  }

  DashboardStats copyWith({
    int? todayRevenue,
    int? todayOrders,
    int? avgOrderValue,
    int? completedOrders,
    int? cancelledOrders,
    int? pendingOrders,
    List<DailyRevenue>? weeklyRevenue,
    List<PopularItem>? popularItems,
    int? customerCount,
    int? newCustomersToday,
  }) {
    return DashboardStats(
      todayRevenue: todayRevenue ?? this.todayRevenue,
      todayOrders: todayOrders ?? this.todayOrders,
      avgOrderValue: avgOrderValue ?? this.avgOrderValue,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      weeklyRevenue: weeklyRevenue ?? this.weeklyRevenue,
      popularItems: popularItems ?? this.popularItems,
      customerCount: customerCount ?? this.customerCount,
      newCustomersToday: newCustomersToday ?? this.newCustomersToday,
    );
  }

  @override
  String toString() =>
      'DashboardStats(revenue: $todayRevenue, orders: $todayOrders)';
}
