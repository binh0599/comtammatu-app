import 'dart:convert';

import 'package:comtammatu/models/address_model.dart';
import 'package:comtammatu/models/cart_item.dart';
import 'package:comtammatu/models/checkin_result.dart';
import 'package:comtammatu/models/dashboard_stats.dart';
import 'package:comtammatu/models/delivery_order.dart';
import 'package:comtammatu/models/feedback_model.dart';
import 'package:comtammatu/models/inventory_item.dart';
import 'package:comtammatu/models/loyalty_dashboard.dart';
import 'package:comtammatu/models/loyalty_member.dart';
import 'package:comtammatu/models/menu_item.dart';
import 'package:comtammatu/models/notification_model.dart';
import 'package:comtammatu/models/point_transaction.dart';
import 'package:comtammatu/models/promotion.dart';
import 'package:comtammatu/models/staff_member.dart';
import 'package:comtammatu/models/tier.dart';
import 'package:comtammatu/models/user_profile.dart';
import 'package:comtammatu/models/voucher_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper: encode to JSON string then decode back to Map to simulate a real
/// network round-trip. This ensures nested objects (even without
/// explicitToJson) are properly serialised via [jsonEncode].
Map<String, dynamic> _roundTripJson(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;

void main() {
  final fixedDate = DateTime(2024, 1, 15, 10, 30);
  final fixedDate2 = DateTime(2024, 6, 20, 14);

  // ---------------------------------------------------------------------------
  // MenuItem
  // ---------------------------------------------------------------------------
  group('MenuItem', () {
    test('round-trip with all fields populated', () {
      const item = MenuItem(
        id: 1,
        name: 'Com Tam Suon Bi Cha',
        price: 55000.0,
        description: 'Delicious broken rice',
        imageUrl: 'https://example.com/img.png',
        category: 'Com Tam',
        tags: ['best-seller', 'lunch'],
      );

      final json = _roundTripJson(item.toJson());
      final restored = MenuItem.fromJson(json);

      expect(restored, equals(item));
      expect(json['base_price'], 55000.0);
      expect(json['is_available'], true);
    });

    test('round-trip with nullable fields as null', () {
      const item = MenuItem(
        id: 2,
        name: 'Nuoc Mia',
        price: 15000.0,
      );

      final json = _roundTripJson(item.toJson());
      final restored = MenuItem.fromJson(json);

      expect(restored, equals(item));
      expect(restored.description, isNull);
      expect(restored.imageUrl, isNull);
      expect(restored.tags, isNull);
    });

    test('copyWith works correctly', () {
      const item = MenuItem(id: 1, name: 'A', price: 10000.0);
      final updated = item.copyWith(name: 'B', price: 20000.0);

      expect(updated.id, 1);
      expect(updated.name, 'B');
      expect(updated.price, 20000.0);
    });
  });

  // ---------------------------------------------------------------------------
  // MenuCategory
  // MenuCategory has a custom fromJson (uses MenuItem.fromApiJson), so we
  // test by constructing JSON manually and verifying fromJson parses it.
  // ---------------------------------------------------------------------------
  group('MenuCategory', () {
    test('fromJson parses correctly with all fields', () {
      final json = <String, dynamic>{
        'name': 'Com Tam',
        'id': 10,
        'items': [
          {
            'id': 1,
            'name': 'Suon Bi Cha',
            'base_price': 55000.0,
            'description': null,
            'image_url': null,
            'category': 'Com Tam',
            'is_available': true,
            'tags': null,
          },
        ],
      };

      final restored = MenuCategory.fromJson(json);

      expect(restored.name, 'Com Tam');
      expect(restored.id, 10);
      expect(restored.items.length, 1);
      expect(restored.items.first.name, 'Suon Bi Cha');
      expect(restored.items.first.price, 55000.0);
      // Custom fromJson overrides category from parent name
      expect(restored.items.first.category, 'Com Tam');
    });

    test('fromJson with nullable id as null', () {
      final json = <String, dynamic>{
        'name': 'Drinks',
        'items': <dynamic>[],
      };

      final restored = MenuCategory.fromJson(json);

      expect(restored.name, 'Drinks');
      expect(restored.id, isNull);
      expect(restored.items, isEmpty);
    });

    test('fromJson uses parent category name for items via fromApiJson', () {
      final json = <String, dynamic>{
        'name': 'Nuoc Uong',
        'items': [
          {
            'id': 5,
            'name': 'Tra Da',
            'price': 8000.0, // uses 'price' fallback, not 'base_price'
          },
        ],
      };

      final restored = MenuCategory.fromJson(json);

      expect(restored.items.first.category, 'Nuoc Uong');
      expect(restored.items.first.price, 8000.0);
    });

    test('copyWith works correctly', () {
      const category = MenuCategory(name: 'A', items: []);
      final updated = category.copyWith(name: 'B', id: 5);

      expect(updated.name, 'B');
      expect(updated.id, 5);
    });
  });

  // ---------------------------------------------------------------------------
  // CartItem
  // ---------------------------------------------------------------------------
  group('CartItem', () {
    test('round-trip with all fields populated', () {
      const cart = CartItem(
        menuItem: MenuItem(id: 1, name: 'Com Tam', price: 50000.0),
        quantity: 3,
        note: 'Extra sauce',
      );

      final json = _roundTripJson(cart.toJson());
      final restored = CartItem.fromJson(json);

      expect(restored.menuItem.id, cart.menuItem.id);
      expect(restored.menuItem.name, cart.menuItem.name);
      expect(restored.menuItem.price, cart.menuItem.price);
      expect(restored.quantity, cart.quantity);
      expect(restored.note, cart.note);
    });

    test('round-trip with nullable note as null', () {
      const cart = CartItem(
        menuItem: MenuItem(id: 2, name: 'Nuoc Mia', price: 15000.0),
        quantity: 1,
      );

      final json = _roundTripJson(cart.toJson());
      final restored = CartItem.fromJson(json);

      expect(restored.note, isNull);
      expect(restored.quantity, 1);
    });

    test('copyWith works correctly', () {
      const cart = CartItem(
        menuItem: MenuItem(id: 1, name: 'A', price: 10000.0),
        quantity: 1,
      );
      final updated = cart.copyWith(quantity: 5, note: 'No spice');

      expect(updated.quantity, 5);
      expect(updated.note, 'No spice');
    });
  });

  // ---------------------------------------------------------------------------
  // OrderItem
  // ---------------------------------------------------------------------------
  group('OrderItem', () {
    test('round-trip with all fields populated', () {
      const item = OrderItem(
        menuItemId: 10,
        name: 'Suon Nuong',
        quantity: 2,
        unitPrice: 55000.0,
        subtotal: 110000.0,
      );

      final json = _roundTripJson(item.toJson());
      final restored = OrderItem.fromJson(json);

      expect(restored, equals(item));
    });

    test('copyWith works correctly', () {
      const item = OrderItem(
        menuItemId: 1,
        name: 'A',
        quantity: 1,
        unitPrice: 10000.0,
        subtotal: 10000.0,
      );
      final updated = item.copyWith(quantity: 3, subtotal: 30000.0);

      expect(updated.quantity, 3);
      expect(updated.subtotal, 30000.0);
    });
  });

  // ---------------------------------------------------------------------------
  // DeliveryOrder
  // ---------------------------------------------------------------------------
  group('DeliveryOrder', () {
    test('round-trip with all fields populated', () {
      final order = DeliveryOrder(
        orderId: 100,
        deliveryOrderId: 200,
        status: 'preparing',
        items: const [
          OrderItem(
            menuItemId: 1,
            name: 'Com Tam',
            quantity: 2,
            unitPrice: 55000.0,
            subtotal: 110000.0,
          ),
        ],
        subtotal: 110000.0,
        deliveryFee: 15000.0,
        discount: 10000.0,
        total: 115000.0,
        estimatedDeliveryAt: fixedDate,
        pointsWillEarn: 115,
        createdAt: fixedDate2,
      );

      final json = _roundTripJson(order.toJson());
      final restored = DeliveryOrder.fromJson(json);

      expect(restored.orderId, order.orderId);
      expect(restored.deliveryOrderId, order.deliveryOrderId);
      expect(restored.status, order.status);
      expect(restored.items.length, 1);
      expect(restored.items.first.name, 'Com Tam');
      expect(restored.subtotal, order.subtotal);
      expect(restored.deliveryFee, order.deliveryFee);
      expect(restored.discount, order.discount);
      expect(restored.total, order.total);
      expect(restored.estimatedDeliveryAt, fixedDate);
      expect(restored.pointsWillEarn, order.pointsWillEarn);
      expect(restored.createdAt, fixedDate2);
    });

    test('copyWith works correctly', () {
      final order = DeliveryOrder(
        orderId: 1,
        deliveryOrderId: 2,
        status: 'pending',
        items: const [],
        subtotal: 0,
        deliveryFee: 0,
        discount: 0,
        total: 0,
        estimatedDeliveryAt: fixedDate,
        pointsWillEarn: 0,
        createdAt: fixedDate,
      );
      final updated = order.copyWith(status: 'delivered', total: 100000.0);

      expect(updated.status, 'delivered');
      expect(updated.total, 100000.0);
    });
  });

  // ---------------------------------------------------------------------------
  // Voucher
  // ---------------------------------------------------------------------------
  group('Voucher', () {
    test('round-trip with all fields populated', () {
      final voucher = Voucher(
        id: 1,
        code: 'GIAM20PT',
        title: 'Giam 20%',
        description: 'Ap dung cho tat ca mon',
        discountType: 'percentage',
        discountValue: 20,
        minOrderAmount: 50000,
        expiresAt: fixedDate,
        pointsCost: 200,
        maxDiscount: 40000,
      );

      final json = _roundTripJson(voucher.toJson());
      final restored = Voucher.fromJson(json);

      expect(restored, equals(voucher));
    });

    test('round-trip with nullable maxDiscount as null', () {
      final voucher = Voucher(
        id: 2,
        code: 'GIAM30K',
        title: 'Giam 30K',
        description: 'Don hang tu 80K',
        discountType: 'fixed',
        discountValue: 30000,
        minOrderAmount: 80000,
        expiresAt: fixedDate,
        pointsCost: 300,
      );

      final json = _roundTripJson(voucher.toJson());
      final restored = Voucher.fromJson(json);

      expect(restored, equals(voucher));
      expect(restored.maxDiscount, isNull);
      expect(restored.isUsed, false);
    });

    test('copyWith works correctly', () {
      final voucher = Voucher(
        id: 1,
        code: 'A',
        title: 'T',
        description: 'D',
        discountType: 'fixed',
        discountValue: 10000,
        minOrderAmount: 20000,
        expiresAt: fixedDate,
        pointsCost: 100,
      );
      final updated = voucher.copyWith(isUsed: true, maxDiscount: 50000);

      expect(updated.isUsed, true);
      expect(updated.maxDiscount, 50000);
    });
  });

  // ---------------------------------------------------------------------------
  // UserProfile
  // ---------------------------------------------------------------------------
  group('UserProfile', () {
    test('round-trip with all fields populated', () {
      const profile = UserProfile(
        id: 'uuid-123',
        phone: '0901234567',
        fullName: 'Nguyen Van A',
        role: 'customer',
        avatarUrl: 'https://example.com/avatar.png',
      );

      final json = _roundTripJson(profile.toJson());
      final restored = UserProfile.fromJson(json);

      expect(restored, equals(profile));
    });

    test('round-trip with nullable avatarUrl as null', () {
      const profile = UserProfile(
        id: 'uuid-456',
        phone: '0907654321',
        fullName: 'Tran Thi B',
        role: 'staff',
      );

      final json = _roundTripJson(profile.toJson());
      final restored = UserProfile.fromJson(json);

      expect(restored, equals(profile));
      expect(restored.avatarUrl, isNull);
    });

    test('copyWith works correctly', () {
      const profile = UserProfile(
        id: 'uuid-1',
        phone: '0901111111',
        fullName: 'A',
        role: 'customer',
      );
      final updated = profile.copyWith(
        fullName: 'B',
        avatarUrl: 'https://example.com/new.png',
      );

      expect(updated.fullName, 'B');
      expect(updated.avatarUrl, 'https://example.com/new.png');
    });
  });

  // ---------------------------------------------------------------------------
  // Address
  // ---------------------------------------------------------------------------
  group('Address', () {
    test('round-trip with all fields populated', () {
      const address = Address(
        label: 'home',
        addressLine: '123 Nguyen Hue',
        ward: 'Ben Nghe',
        district: 'Quan 1',
        city: 'Ho Chi Minh',
        id: 42,
        isDefault: true,
        lat: 10.7769,
        lng: 106.7009,
      );

      final json = _roundTripJson(address.toJson());
      final restored = Address.fromJson(json);

      expect(restored, equals(address));
    });

    test('round-trip with nullable fields as null', () {
      const address = Address(
        label: 'work',
        addressLine: '456 Le Loi',
        ward: 'Ben Thanh',
        district: 'Quan 1',
        city: 'Ho Chi Minh',
      );

      final json = _roundTripJson(address.toJson());
      final restored = Address.fromJson(json);

      expect(restored, equals(address));
      expect(restored.id, isNull);
      expect(restored.lat, isNull);
      expect(restored.lng, isNull);
      expect(restored.isDefault, false);
    });

    test('copyWith works correctly', () {
      const address = Address(
        label: 'home',
        addressLine: 'A',
        ward: 'W',
        district: 'D',
        city: 'C',
      );
      final updated = address.copyWith(isDefault: true, id: 99);

      expect(updated.isDefault, true);
      expect(updated.id, 99);
    });
  });

  // ---------------------------------------------------------------------------
  // LoyaltyStats
  // ---------------------------------------------------------------------------
  group('LoyaltyStats', () {
    test('round-trip with all fields populated', () {
      const stats = LoyaltyStats(
        totalCheckinsThisMonth: 12,
        totalOrdersThisMonth: 8,
        streakDays: 5,
      );

      final json = _roundTripJson(stats.toJson());
      final restored = LoyaltyStats.fromJson(json);

      expect(restored, equals(stats));
    });

    test('copyWith works correctly', () {
      const stats = LoyaltyStats(
        totalCheckinsThisMonth: 1,
        totalOrdersThisMonth: 2,
        streakDays: 3,
      );
      final updated = stats.copyWith(streakDays: 10);

      expect(updated.streakDays, 10);
      expect(updated.totalCheckinsThisMonth, 1);
    });
  });

  // ---------------------------------------------------------------------------
  // LoyaltyMember
  // ---------------------------------------------------------------------------
  group('LoyaltyMember', () {
    test('round-trip with all fields populated', () {
      const member = LoyaltyMember(
        id: 1,
        fullName: 'Nguyen Van A',
        phone: '0901234567',
        totalPoints: 1500.0,
        availablePoints: 1200.0,
        lifetimePoints: 5000.0,
        version: 3,
        avatarUrl: 'https://example.com/avatar.png',
      );

      final json = _roundTripJson(member.toJson());
      final restored = LoyaltyMember.fromJson(json);

      expect(restored, equals(member));
    });

    test('round-trip with nullable avatarUrl as null', () {
      const member = LoyaltyMember(
        id: 2,
        fullName: 'Tran B',
        phone: '0907654321',
        totalPoints: 0.0,
        availablePoints: 0.0,
        lifetimePoints: 0.0,
        version: 1,
      );

      final json = _roundTripJson(member.toJson());
      final restored = LoyaltyMember.fromJson(json);

      expect(restored, equals(member));
      expect(restored.avatarUrl, isNull);
    });

    test('copyWith works correctly', () {
      const member = LoyaltyMember(
        id: 1,
        fullName: 'A',
        phone: '0900000000',
        totalPoints: 100.0,
        availablePoints: 50.0,
        lifetimePoints: 200.0,
        version: 1,
      );
      final updated = member.copyWith(availablePoints: 75.0, version: 2);

      expect(updated.availablePoints, 75.0);
      expect(updated.version, 2);
    });
  });

  // ---------------------------------------------------------------------------
  // PointTransaction
  // ---------------------------------------------------------------------------
  group('PointTransaction', () {
    test('round-trip with all fields populated', () {
      final tx = PointTransaction(
        id: 10,
        type: 'earn',
        points: 150.0,
        balanceAfter: 1350.0,
        description: 'Order #100 cashback',
        createdAt: fixedDate,
        referenceType: 'order',
        referenceId: 100,
      );

      final json = _roundTripJson(tx.toJson());
      final restored = PointTransaction.fromJson(json);

      expect(restored, equals(tx));
    });

    test('round-trip with nullable fields as null', () {
      final tx = PointTransaction(
        id: 11,
        type: 'redeem',
        points: -200.0,
        balanceAfter: 1150.0,
        description: 'Voucher redemption',
        createdAt: fixedDate,
      );

      final json = _roundTripJson(tx.toJson());
      final restored = PointTransaction.fromJson(json);

      expect(restored, equals(tx));
      expect(restored.referenceType, isNull);
      expect(restored.referenceId, isNull);
    });

    test('copyWith works correctly', () {
      final tx = PointTransaction(
        id: 1,
        type: 'earn',
        points: 10.0,
        balanceAfter: 10.0,
        description: 'test',
        createdAt: fixedDate,
      );
      final updated = tx.copyWith(points: 20.0, referenceId: 5);

      expect(updated.points, 20.0);
      expect(updated.referenceId, 5);
    });
  });

  // ---------------------------------------------------------------------------
  // NotificationItem
  // ---------------------------------------------------------------------------
  group('NotificationItem', () {
    test('round-trip with all fields populated', () {
      final notification = NotificationItem(
        id: 'notif-001',
        title: 'Don hang moi',
        body: 'Don hang #100 da duoc xac nhan',
        type: 'order',
        isRead: false,
        createdAt: fixedDate,
        data: {'order_id': 100, 'status': 'confirmed'},
      );

      final json = _roundTripJson(notification.toJson());
      final restored = NotificationItem.fromJson(json);

      expect(restored.id, notification.id);
      expect(restored.title, notification.title);
      expect(restored.body, notification.body);
      expect(restored.type, notification.type);
      expect(restored.isRead, notification.isRead);
      expect(restored.createdAt, fixedDate);
      expect(restored.data, {'order_id': 100, 'status': 'confirmed'});
    });

    test('round-trip with nullable data as null', () {
      final notification = NotificationItem(
        id: 'notif-002',
        title: 'System message',
        body: 'Welcome',
        type: 'system',
        isRead: true,
        createdAt: fixedDate,
      );

      final json = _roundTripJson(notification.toJson());
      final restored = NotificationItem.fromJson(json);

      expect(restored.id, notification.id);
      expect(restored.data, isNull);
    });

    test('copyWith works correctly', () {
      final notification = NotificationItem(
        id: 'n1',
        title: 'T',
        body: 'B',
        type: 'system',
        isRead: false,
        createdAt: fixedDate,
      );
      final updated = notification.copyWith(isRead: true);

      expect(updated.isRead, true);
      expect(updated.id, 'n1');
    });
  });

  // ---------------------------------------------------------------------------
  // FeedbackModel
  // ---------------------------------------------------------------------------
  group('FeedbackModel', () {
    test('round-trip with all fields populated', () {
      final feedback = FeedbackModel(
        id: 1,
        orderId: 100,
        rating: 5,
        comment: 'Rat ngon!',
        createdAt: fixedDate,
        tags: ['food-quality', 'fast-delivery'],
      );

      final json = _roundTripJson(feedback.toJson());
      final restored = FeedbackModel.fromJson(json);

      expect(restored, equals(feedback));
    });

    test('round-trip with default empty tags', () {
      final feedback = FeedbackModel(
        id: 2,
        orderId: 101,
        rating: 3,
        comment: 'Binh thuong',
        createdAt: fixedDate,
      );

      final json = _roundTripJson(feedback.toJson());
      final restored = FeedbackModel.fromJson(json);

      expect(restored, equals(feedback));
      expect(restored.tags, isEmpty);
    });

    test('copyWith works correctly', () {
      final feedback = FeedbackModel(
        id: 1,
        orderId: 1,
        rating: 4,
        comment: 'Good',
        createdAt: fixedDate,
      );
      final updated = feedback.copyWith(rating: 5, tags: ['excellent']);

      expect(updated.rating, 5);
      expect(updated.tags, ['excellent']);
    });
  });

  // ---------------------------------------------------------------------------
  // DailyRevenue
  // ---------------------------------------------------------------------------
  group('DailyRevenue', () {
    test('round-trip with all fields populated', () {
      const revenue = DailyRevenue(day: '2024-01-15', amount: 5000000);

      final json = _roundTripJson(revenue.toJson());
      final restored = DailyRevenue.fromJson(json);

      expect(restored, equals(revenue));
    });

    test('round-trip with defaults', () {
      const revenue = DailyRevenue();

      final json = _roundTripJson(revenue.toJson());
      final restored = DailyRevenue.fromJson(json);

      expect(restored, equals(revenue));
      expect(restored.day, '');
      expect(restored.amount, 0);
    });

    test('copyWith works correctly', () {
      const revenue = DailyRevenue(day: 'Mon', amount: 100);
      final updated = revenue.copyWith(amount: 200);

      expect(updated.day, 'Mon');
      expect(updated.amount, 200);
    });
  });

  // ---------------------------------------------------------------------------
  // PopularItem
  // ---------------------------------------------------------------------------
  group('PopularItem', () {
    test('round-trip with all fields populated', () {
      const item = PopularItem(name: 'Com Tam', count: 150, revenue: 8250000);

      final json = _roundTripJson(item.toJson());
      final restored = PopularItem.fromJson(json);

      expect(restored, equals(item));
    });

    test('round-trip with defaults', () {
      const item = PopularItem();

      final json = _roundTripJson(item.toJson());
      final restored = PopularItem.fromJson(json);

      expect(restored, equals(item));
    });

    test('copyWith works correctly', () {
      const item = PopularItem(name: 'A', count: 10, revenue: 500);
      final updated = item.copyWith(count: 20);

      expect(updated.count, 20);
      expect(updated.name, 'A');
    });
  });

  // ---------------------------------------------------------------------------
  // DashboardStats
  // ---------------------------------------------------------------------------
  group('DashboardStats', () {
    test('round-trip with all fields populated', () {
      const stats = DashboardStats(
        todayRevenue: 12000000,
        todayOrders: 85,
        avgOrderValue: 141000,
        completedOrders: 70,
        cancelledOrders: 5,
        pendingOrders: 10,
        weeklyRevenue: [
          DailyRevenue(day: 'Mon', amount: 10000000),
          DailyRevenue(day: 'Tue', amount: 11000000),
        ],
        popularItems: [
          PopularItem(name: 'Com Tam Suon', count: 50, revenue: 2750000),
        ],
        customerCount: 200,
        newCustomersToday: 15,
      );

      final json = _roundTripJson(stats.toJson());
      final restored = DashboardStats.fromJson(json);

      expect(restored.todayRevenue, stats.todayRevenue);
      expect(restored.todayOrders, stats.todayOrders);
      expect(restored.avgOrderValue, stats.avgOrderValue);
      expect(restored.completedOrders, stats.completedOrders);
      expect(restored.cancelledOrders, stats.cancelledOrders);
      expect(restored.pendingOrders, stats.pendingOrders);
      expect(restored.weeklyRevenue.length, 2);
      expect(restored.weeklyRevenue.first.day, 'Mon');
      expect(restored.popularItems.length, 1);
      expect(restored.popularItems.first.name, 'Com Tam Suon');
      expect(restored.customerCount, stats.customerCount);
      expect(restored.newCustomersToday, stats.newCustomersToday);
    });

    test('round-trip with defaults', () {
      const stats = DashboardStats();

      final json = _roundTripJson(stats.toJson());
      final restored = DashboardStats.fromJson(json);

      expect(restored, equals(stats));
      expect(restored.weeklyRevenue, isEmpty);
      expect(restored.popularItems, isEmpty);
    });

    test('copyWith works correctly', () {
      const stats = DashboardStats();
      final updated = stats.copyWith(todayRevenue: 5000000, todayOrders: 30);

      expect(updated.todayRevenue, 5000000);
      expect(updated.todayOrders, 30);
    });
  });

  // ---------------------------------------------------------------------------
  // InventoryItem
  // ---------------------------------------------------------------------------
  group('InventoryItem', () {
    test('round-trip with all fields populated', () {
      final item = InventoryItem(
        id: 1,
        name: 'Gao',
        category: 'Nguyen lieu',
        unit: 'kg',
        currentStock: 50.0,
        minStock: 10.0,
        maxStock: 100.0,
        lastRestocked: fixedDate,
        pricePerUnit: 20000,
        supplierId: 5,
        supplierName: 'Cong ty ABC',
      );

      final json = _roundTripJson(item.toJson());
      final restored = InventoryItem.fromJson(json);

      expect(restored, equals(item));
    });

    test('round-trip with nullable fields as null', () {
      final item = InventoryItem(
        id: 2,
        name: 'Nuoc Mam',
        category: 'Gia vi',
        unit: 'lit',
        currentStock: 5.0,
        minStock: 2.0,
        maxStock: 20.0,
        lastRestocked: fixedDate,
        pricePerUnit: 35000,
      );

      final json = _roundTripJson(item.toJson());
      final restored = InventoryItem.fromJson(json);

      expect(restored, equals(item));
      expect(restored.supplierId, isNull);
      expect(restored.supplierName, isNull);
    });

    test('copyWith works correctly', () {
      final item = InventoryItem(
        id: 1,
        name: 'A',
        category: 'C',
        unit: 'kg',
        currentStock: 10.0,
        minStock: 5.0,
        maxStock: 50.0,
        lastRestocked: fixedDate,
        pricePerUnit: 10000,
      );
      final updated = item.copyWith(currentStock: 25.0, supplierId: 3);

      expect(updated.currentStock, 25.0);
      expect(updated.supplierId, 3);
    });
  });

  // ---------------------------------------------------------------------------
  // StaffMember
  // ---------------------------------------------------------------------------
  group('StaffMember', () {
    test('round-trip with all fields populated', () {
      final staff = StaffMember(
        id: 1,
        name: 'Nguyen Van A',
        phone: '0901234567',
        role: StaffRole.chef,
        hireDate: fixedDate,
        branchId: 1,
        branchName: 'Chi nhanh Quan 1',
        avatarUrl: 'https://example.com/staff.png',
      );

      final json = _roundTripJson(staff.toJson());
      final restored = StaffMember.fromJson(json);

      expect(restored, equals(staff));
      expect(json['role'], 'chef');
    });

    test('round-trip with nullable avatarUrl as null and default isActive', () {
      final staff = StaffMember(
        id: 2,
        name: 'Tran B',
        phone: '0907654321',
        role: StaffRole.cashier,
        hireDate: fixedDate,
        branchId: 2,
        branchName: 'Chi nhanh Quan 3',
      );

      final json = _roundTripJson(staff.toJson());
      final restored = StaffMember.fromJson(json);

      expect(restored, equals(staff));
      expect(restored.avatarUrl, isNull);
      expect(restored.isActive, true);
    });

    test('all StaffRole enum values round-trip correctly', () {
      for (final role in StaffRole.values) {
        final staff = StaffMember(
          id: 1,
          name: 'Test',
          phone: '0900000000',
          role: role,
          hireDate: fixedDate,
          branchId: 1,
          branchName: 'Test',
        );

        final json = _roundTripJson(staff.toJson());
        final restored = StaffMember.fromJson(json);

        expect(restored.role, role, reason: 'Failed for role: ${role.name}');
      }
    });

    test('copyWith works correctly', () {
      final staff = StaffMember(
        id: 1,
        name: 'A',
        phone: '0900000000',
        role: StaffRole.waiter,
        hireDate: fixedDate,
        branchId: 1,
        branchName: 'B1',
      );
      final updated = staff.copyWith(role: StaffRole.manager, isActive: false);

      expect(updated.role, StaffRole.manager);
      expect(updated.isActive, false);
    });
  });

  // ---------------------------------------------------------------------------
  // Branch
  // ---------------------------------------------------------------------------
  group('Branch', () {
    test('round-trip with all fields populated', () {
      const branch = Branch(
        id: 1,
        name: 'Chi nhanh Quan 1',
        address: '123 Nguyen Hue, Q1, HCM',
      );

      final json = _roundTripJson(branch.toJson());
      final restored = Branch.fromJson(json);

      expect(restored, equals(branch));
    });

    test('copyWith works correctly', () {
      const branch = Branch(id: 1, name: 'A', address: 'Addr');
      final updated = branch.copyWith(name: 'B');

      expect(updated.name, 'B');
      expect(updated.id, 1);
    });
  });

  // ---------------------------------------------------------------------------
  // CheckinStreak
  // ---------------------------------------------------------------------------
  group('CheckinStreak', () {
    test('round-trip with all fields populated', () {
      const streak = CheckinStreak(
        current: 5,
        bonus: 50,
        nextMilestone: 7,
        nextMilestoneBonus: 100,
      );

      final json = _roundTripJson(streak.toJson());
      final restored = CheckinStreak.fromJson(json);

      expect(restored, equals(streak));
    });

    test('copyWith works correctly', () {
      const streak = CheckinStreak(
        current: 1,
        bonus: 10,
        nextMilestone: 3,
        nextMilestoneBonus: 30,
      );
      final updated = streak.copyWith(current: 2);

      expect(updated.current, 2);
      expect(updated.bonus, 10);
    });
  });

  // ---------------------------------------------------------------------------
  // CheckinResult
  // ---------------------------------------------------------------------------
  group('CheckinResult', () {
    test('round-trip with all fields populated', () {
      final result = CheckinResult(
        checkinId: 42,
        branch: const Branch(id: 1, name: 'Q1', address: '123 Nguyen Hue'),
        pointsEarned: 10.0,
        newBalance: 1510.0,
        streak: const CheckinStreak(
          current: 5,
          bonus: 50,
          nextMilestone: 7,
          nextMilestoneBonus: 100,
        ),
        checkedInAt: fixedDate,
      );

      final json = _roundTripJson(result.toJson());
      final restored = CheckinResult.fromJson(json);

      expect(restored.checkinId, result.checkinId);
      expect(restored.branch.id, 1);
      expect(restored.branch.name, 'Q1');
      expect(restored.pointsEarned, result.pointsEarned);
      expect(restored.newBalance, result.newBalance);
      expect(restored.streak.current, 5);
      expect(restored.checkedInAt, fixedDate);
    });

    test('copyWith works correctly', () {
      final result = CheckinResult(
        checkinId: 1,
        branch: const Branch(id: 1, name: 'A', address: 'Addr'),
        pointsEarned: 5.0,
        newBalance: 100.0,
        streak: const CheckinStreak(
          current: 1,
          bonus: 0,
          nextMilestone: 3,
          nextMilestoneBonus: 30,
        ),
        checkedInAt: fixedDate,
      );
      final updated = result.copyWith(pointsEarned: 20.0, newBalance: 120.0);

      expect(updated.pointsEarned, 20.0);
      expect(updated.newBalance, 120.0);
    });
  });

  // ---------------------------------------------------------------------------
  // Promotion
  // ---------------------------------------------------------------------------
  group('Promotion', () {
    test('round-trip with all fields populated', () {
      final promo = Promotion(
        id: 1,
        name: 'Tet Sale',
        description: 'Giam gia dip Tet',
        cashbackType: 'percentage',
        cashbackValue: 10.0,
        startDate: fixedDate,
        endDate: fixedDate2,
        eligible: true,
        imageUrl: 'https://example.com/promo.png',
      );

      final json = _roundTripJson(promo.toJson());
      final restored = Promotion.fromJson(json);

      expect(restored, equals(promo));
    });

    test('round-trip with nullable imageUrl as null', () {
      final promo = Promotion(
        id: 2,
        name: 'Summer',
        description: 'Summer sale',
        cashbackType: 'fixed',
        cashbackValue: 5000.0,
        startDate: fixedDate,
        endDate: fixedDate2,
        eligible: false,
      );

      final json = _roundTripJson(promo.toJson());
      final restored = Promotion.fromJson(json);

      expect(restored, equals(promo));
      expect(restored.imageUrl, isNull);
    });

    test('copyWith works correctly', () {
      final promo = Promotion(
        id: 1,
        name: 'A',
        description: 'D',
        cashbackType: 'percentage',
        cashbackValue: 5.0,
        startDate: fixedDate,
        endDate: fixedDate2,
        eligible: false,
      );
      final updated = promo.copyWith(eligible: true, cashbackValue: 15.0);

      expect(updated.eligible, true);
      expect(updated.cashbackValue, 15.0);
    });
  });

  // ---------------------------------------------------------------------------
  // TierProgress
  // ---------------------------------------------------------------------------
  group('TierProgress', () {
    test('round-trip with all fields populated', () {
      const progress = TierProgress(
        name: 'Gold',
        tierCode: 'GOLD',
        minPoints: 1000.0,
        pointsNeeded: 500.0,
        progressPercent: 0.5,
      );

      final json = _roundTripJson(progress.toJson());
      final restored = TierProgress.fromJson(json);

      expect(restored, equals(progress));
    });

    test('copyWith works correctly', () {
      const progress = TierProgress(
        name: 'Silver',
        tierCode: 'SILVER',
        minPoints: 500.0,
        pointsNeeded: 200.0,
        progressPercent: 0.6,
      );
      final updated = progress.copyWith(progressPercent: 0.8);

      expect(updated.progressPercent, 0.8);
      expect(updated.name, 'Silver');
    });
  });

  // ---------------------------------------------------------------------------
  // Tier
  // ---------------------------------------------------------------------------
  group('Tier', () {
    test('round-trip with all fields populated', () {
      const tier = Tier(
        id: 1,
        name: 'Silver',
        tierCode: 'SILVER',
        pointMultiplier: 1.5,
        cashbackPercent: 3.0,
        benefits: ['Free delivery', '10% off'],
        nextTier: TierProgress(
          name: 'Gold',
          tierCode: 'GOLD',
          minPoints: 1000.0,
          pointsNeeded: 500.0,
          progressPercent: 0.5,
        ),
      );

      final json = _roundTripJson(tier.toJson());
      final restored = Tier.fromJson(json);

      expect(restored.id, tier.id);
      expect(restored.name, tier.name);
      expect(restored.tierCode, tier.tierCode);
      expect(restored.pointMultiplier, tier.pointMultiplier);
      expect(restored.cashbackPercent, tier.cashbackPercent);
      expect(restored.benefits, tier.benefits);
      expect(restored.nextTier, isNotNull);
      expect(restored.nextTier!.name, 'Gold');
      expect(restored.nextTier!.pointsNeeded, 500.0);
    });

    test('round-trip with nullable nextTier as null', () {
      const tier = Tier(
        id: 3,
        name: 'Diamond',
        tierCode: 'DIAMOND',
        pointMultiplier: 3.0,
        cashbackPercent: 10.0,
        benefits: ['VIP access', 'Free everything'],
      );

      final json = _roundTripJson(tier.toJson());
      final restored = Tier.fromJson(json);

      expect(restored.id, tier.id);
      expect(restored.name, tier.name);
      expect(restored.nextTier, isNull);
      expect(restored.benefits, tier.benefits);
    });

    test('copyWith works correctly', () {
      const tier = Tier(
        id: 1,
        name: 'Bronze',
        tierCode: 'BRONZE',
        pointMultiplier: 1.0,
        cashbackPercent: 1.0,
        benefits: [],
      );
      final updated = tier.copyWith(
        pointMultiplier: 1.2,
        benefits: ['Benefit A'],
      );

      expect(updated.pointMultiplier, 1.2);
      expect(updated.benefits, ['Benefit A']);
    });
  });

  // ---------------------------------------------------------------------------
  // LoyaltyDashboard (composite — depends on many other models)
  // ---------------------------------------------------------------------------
  group('LoyaltyDashboard', () {
    test('round-trip with all fields populated', () {
      final dashboard = LoyaltyDashboard(
        member: const LoyaltyMember(
          id: 1,
          fullName: 'Nguyen Van A',
          phone: '0901234567',
          totalPoints: 1500.0,
          availablePoints: 1200.0,
          lifetimePoints: 5000.0,
          version: 3,
          avatarUrl: 'https://example.com/avatar.png',
        ),
        tier: const Tier(
          id: 2,
          name: 'Gold',
          tierCode: 'GOLD',
          pointMultiplier: 2.0,
          cashbackPercent: 5.0,
          benefits: ['Free delivery'],
          nextTier: TierProgress(
            name: 'Platinum',
            tierCode: 'PLATINUM',
            minPoints: 5000.0,
            pointsNeeded: 3500.0,
            progressPercent: 0.3,
          ),
        ),
        recentTransactions: [
          PointTransaction(
            id: 1,
            type: 'earn',
            points: 100.0,
            balanceAfter: 1300.0,
            description: 'Order cashback',
            createdAt: fixedDate,
          ),
        ],
        activePromotions: [
          Promotion(
            id: 1,
            name: 'Tet Sale',
            description: 'Tet promo',
            cashbackType: 'percentage',
            cashbackValue: 10.0,
            startDate: fixedDate,
            endDate: fixedDate2,
            eligible: true,
          ),
        ],
        stats: const LoyaltyStats(
          totalCheckinsThisMonth: 10,
          totalOrdersThisMonth: 8,
          streakDays: 5,
        ),
      );

      final json = _roundTripJson(dashboard.toJson());
      final restored = LoyaltyDashboard.fromJson(json);

      expect(restored.member.id, 1);
      expect(restored.member.fullName, 'Nguyen Van A');
      expect(restored.tier.name, 'Gold');
      expect(restored.tier.nextTier!.name, 'Platinum');
      expect(restored.recentTransactions.length, 1);
      expect(restored.recentTransactions.first.type, 'earn');
      expect(restored.activePromotions.length, 1);
      expect(restored.activePromotions.first.name, 'Tet Sale');
      expect(restored.stats.streakDays, 5);
    });

    test('round-trip with empty lists', () {
      const dashboard = LoyaltyDashboard(
        member: LoyaltyMember(
          id: 1,
          fullName: 'B',
          phone: '0900000000',
          totalPoints: 0.0,
          availablePoints: 0.0,
          lifetimePoints: 0.0,
          version: 1,
        ),
        tier: Tier(
          id: 1,
          name: 'Bronze',
          tierCode: 'BRONZE',
          pointMultiplier: 1.0,
          cashbackPercent: 1.0,
          benefits: [],
        ),
        recentTransactions: [],
        activePromotions: [],
        stats: LoyaltyStats(
          totalCheckinsThisMonth: 0,
          totalOrdersThisMonth: 0,
          streakDays: 0,
        ),
      );

      final json = _roundTripJson(dashboard.toJson());
      final restored = LoyaltyDashboard.fromJson(json);

      expect(restored.recentTransactions, isEmpty);
      expect(restored.activePromotions, isEmpty);
    });

    test('copyWith works correctly', () {
      const dashboard = LoyaltyDashboard(
        member: LoyaltyMember(
          id: 1,
          fullName: 'A',
          phone: '0900000000',
          totalPoints: 0.0,
          availablePoints: 0.0,
          lifetimePoints: 0.0,
          version: 1,
        ),
        tier: Tier(
          id: 1,
          name: 'Bronze',
          tierCode: 'BRONZE',
          pointMultiplier: 1.0,
          cashbackPercent: 1.0,
          benefits: [],
        ),
        recentTransactions: [],
        activePromotions: [],
        stats: LoyaltyStats(
          totalCheckinsThisMonth: 0,
          totalOrdersThisMonth: 0,
          streakDays: 0,
        ),
      );
      final updated = dashboard.copyWith(
        stats: const LoyaltyStats(
          totalCheckinsThisMonth: 5,
          totalOrdersThisMonth: 3,
          streakDays: 2,
        ),
      );

      expect(updated.stats.totalCheckinsThisMonth, 5);
      expect(updated.member.id, 1);
    });
  });
}
