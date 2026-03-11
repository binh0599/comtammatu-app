// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/cart/domain/cart_notifier.dart';
import 'package:comtammatu/features/order/data/order_repository.dart';
import 'package:comtammatu/models/delivery_order.dart';
import 'package:comtammatu/models/menu_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

MenuItem _menuItem({int id = 1, double price = 45000}) {
  return MenuItem(id: id, name: 'Cơm tấm sườn', price: price);
}

DeliveryOrder _sampleDeliveryOrder() {
  return DeliveryOrder(
    orderId: 100,
    deliveryOrderId: 100,
    status: 'pending',
    items: const [
      OrderItem(
        menuItemId: 1,
        name: 'Cơm tấm sườn',
        quantity: 1,
        unitPrice: 45000,
        subtotal: 45000,
      ),
    ],
    subtotal: 45000,
    deliveryFee: 15000,
    discount: 0,
    total: 60000,
    estimatedDeliveryAt: DateTime(2026, 3, 15),
    pointsWillEarn: 60,
    createdAt: DateTime(2026, 3, 10),
  );
}

void main() {
  late CartNotifier notifier;
  late MockOrderRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockRepo = MockOrderRepository();
    notifier = CartNotifier(orderRepository: mockRepo);
  });

  group('CartNotifier.placeOrder', () {
    test('sets orderError when address is missing', () async {
      notifier.addItem(_menuItem());
      // No address set

      await notifier.placeOrder();

      expect(notifier.state.orderError, contains('địa chỉ'));
      expect(notifier.state.isSubmitting, isFalse);
    });

    test('sets isSubmitting during order placement', () async {
      notifier.addItem(_menuItem());
      notifier.setAddress(
        deliveryAddress: '123 Nguyễn Huệ',
        latitude: 10.7769,
        longitude: 106.7009,
      );

      var wasSubmitting = false;
      notifier.addListener((state) {
        if (state.isSubmitting) wasSubmitting = true;
      });

      when(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: any(named: 'deliveryAddress'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            note: any(named: 'note'),
            promotionId: any(named: 'promotionId'),
          )).thenAnswer((_) async => _sampleDeliveryOrder());

      await notifier.placeOrder();

      expect(wasSubmitting, isTrue);
      // After success, cart is cleared so isSubmitting resets
      expect(notifier.state.isSubmitting, isFalse);
    });

    test('clears cart on successful order', () async {
      notifier.addItem(_menuItem());
      notifier.addItem(_menuItem(id: 2, price: 55000));
      notifier.setAddress(
        deliveryAddress: '456 Lê Lợi',
        latitude: 10.7769,
        longitude: 106.7009,
      );
      notifier.setNote('Giao nhanh');

      when(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: any(named: 'deliveryAddress'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            note: any(named: 'note'),
            promotionId: any(named: 'promotionId'),
          )).thenAnswer((_) async => _sampleDeliveryOrder());

      await notifier.placeOrder();

      expect(notifier.state.items, isEmpty);
      expect(notifier.state.note, '');
      expect(notifier.state.paymentMethod, 'cod');
    });

    test('calls createDeliveryOrder with correct parameters', () async {
      notifier.addItem(_menuItem());
      notifier.setAddress(
        deliveryAddress: '789 Phạm Ngũ Lão',
        latitude: 10.77,
        longitude: 106.70,
      );
      notifier.setNote('Thêm nước mắm');

      when(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: any(named: 'deliveryAddress'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            note: any(named: 'note'),
            promotionId: any(named: 'promotionId'),
          )).thenAnswer((_) async => _sampleDeliveryOrder());

      await notifier.placeOrder();

      verify(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: '789 Phạm Ngũ Lão',
            latitude: 10.77,
            longitude: 106.70,
            note: 'Thêm nước mắm',
          )).called(1);
    });

    test('sets orderError on API failure', () async {
      notifier.addItem(_menuItem());
      notifier.setAddress(
        deliveryAddress: '123 Test',
        latitude: 10.0,
        longitude: 106.0,
      );

      when(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: any(named: 'deliveryAddress'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            note: any(named: 'note'),
            promotionId: any(named: 'promotionId'),
          )).thenThrow(Exception('Tạo đơn thất bại'));

      await notifier.placeOrder();

      expect(notifier.state.orderError, contains('Tạo đơn thất bại'));
      expect(notifier.state.isSubmitting, isFalse);
      // Cart should NOT be cleared on error
      expect(notifier.state.items, hasLength(1));
    });

    test('does not send note when note is empty', () async {
      notifier.addItem(_menuItem());
      notifier.setAddress(
        deliveryAddress: '123 Test',
        latitude: 10.0,
        longitude: 106.0,
      );
      // Note is empty by default

      when(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: any(named: 'deliveryAddress'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            note: any(named: 'note'),
            promotionId: any(named: 'promotionId'),
          )).thenAnswer((_) async => _sampleDeliveryOrder());

      await notifier.placeOrder();

      verify(() => mockRepo.createDeliveryOrder(
            items: any(named: 'items'),
            deliveryAddress: any(named: 'deliveryAddress'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).called(1);
    });
  });
}
