// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/cart/domain/cart_notifier.dart';
import 'package:comtammatu/features/order/data/order_repository.dart';
import 'package:comtammatu/models/menu_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

MenuItem _menuItem(
    {int id = 1, String name = 'Com tam suon', double price = 45000}) {
  return MenuItem(id: id, name: name, price: price);
}

void main() {
  late CartNotifier notifier;
  late MockOrderRepository mockOrderRepo;

  setUp(() {
    mockOrderRepo = MockOrderRepository();
    notifier = CartNotifier(orderRepository: mockOrderRepo);
  });

  group('CartNotifier', () {
    test('initial state is empty', () {
      expect(notifier.state.items, isEmpty);
      expect(notifier.state.isEmpty, isTrue);
      expect(notifier.state.subtotal, 0);
      expect(notifier.state.total, 0);
      expect(notifier.state.itemCount, 0);
    });

    group('addItem', () {
      test('adds a new item to cart', () {
        final item = _menuItem();
        notifier.addItem(item);

        expect(notifier.state.items, hasLength(1));
        expect(notifier.state.items.first.menuItem.id, 1);
        expect(notifier.state.items.first.quantity, 1);
      });

      test('increments quantity when adding existing item', () {
        final item = _menuItem();
        notifier.addItem(item);
        notifier.addItem(item);

        expect(notifier.state.items, hasLength(1));
        expect(notifier.state.items.first.quantity, 2);
      });

      test('adds item with note', () {
        final item = _menuItem();
        notifier.addItem(item, note: 'Khong hanh');

        expect(notifier.state.items.first.note, 'Khong hanh');
      });

      test('updates note when adding existing item with new note', () {
        final item = _menuItem();
        notifier.addItem(item, note: 'note 1');
        notifier.addItem(item, note: 'note 2');

        expect(notifier.state.items.first.note, 'note 2');
        expect(notifier.state.items.first.quantity, 2);
      });

      test('keeps original note when adding existing item without note', () {
        final item = _menuItem();
        notifier.addItem(item, note: 'original note');
        notifier.addItem(item);

        expect(notifier.state.items.first.note, 'original note');
      });

      test('adds multiple different items', () {
        notifier.addItem(_menuItem(name: 'Item 1'));
        notifier.addItem(_menuItem(id: 2, name: 'Item 2'));

        expect(notifier.state.items, hasLength(2));
      });
    });

    group('removeItem', () {
      test('removes item by menu item id', () {
        notifier.addItem(_menuItem());
        notifier.addItem(_menuItem(id: 2));
        notifier.removeItem(1);

        expect(notifier.state.items, hasLength(1));
        expect(notifier.state.items.first.menuItem.id, 2);
      });

      test('does nothing when removing non-existent item', () {
        notifier.addItem(_menuItem());
        notifier.removeItem(999);

        expect(notifier.state.items, hasLength(1));
      });
    });

    group('updateQuantity', () {
      test('updates quantity of existing item', () {
        notifier.addItem(_menuItem());
        notifier.updateQuantity(1, 5);

        expect(notifier.state.items.first.quantity, 5);
      });

      test('removes item when quantity is set to zero', () {
        notifier.addItem(_menuItem());
        notifier.updateQuantity(1, 0);

        expect(notifier.state.items, isEmpty);
      });

      test('removes item when quantity is negative', () {
        notifier.addItem(_menuItem());
        notifier.updateQuantity(1, -1);

        expect(notifier.state.items, isEmpty);
      });

      test('preserves note when updating quantity', () {
        notifier.addItem(_menuItem(), note: 'extra sauce');
        notifier.updateQuantity(1, 3);

        expect(notifier.state.items.first.note, 'extra sauce');
        expect(notifier.state.items.first.quantity, 3);
      });
    });

    group('clearCart', () {
      test('removes all items and resets state', () {
        notifier.addItem(_menuItem());
        notifier.addItem(_menuItem(id: 2));
        notifier.setPaymentMethod('momo');
        notifier.setNote('giao nhanh');
        notifier.clearCart();

        expect(notifier.state.items, isEmpty);
        expect(notifier.state.paymentMethod, 'cod');
        expect(notifier.state.note, '');
      });
    });

    group('total calculation', () {
      test('calculates subtotal correctly', () {
        notifier.addItem(_menuItem());
        notifier.addItem(_menuItem(id: 2, price: 55000));

        expect(notifier.state.subtotal, 100000);
      });

      test('calculates subtotal with multiple quantities', () {
        notifier.addItem(_menuItem());
        notifier.updateQuantity(1, 3);

        expect(notifier.state.subtotal, 135000);
      });

      test('calculates total with delivery fee and discount', () {
        notifier.addItem(_menuItem(price: 50000));
        // We can only set deliveryFee/discount via copyWith on the state,
        // but the notifier doesn't expose setters for those directly.
        // Instead, test the CartState computation directly.
        final stateWithFees = notifier.state.copyWith(
          deliveryFee: 15000,
          discount: 5000,
        );

        expect(stateWithFees.subtotal, 50000);
        expect(stateWithFees.total, 60000); // 50000 + 15000 - 5000
      });

      test('itemCount sums all quantities', () {
        notifier.addItem(_menuItem());
        notifier.addItem(_menuItem(id: 2));
        notifier.updateQuantity(1, 3);

        expect(notifier.state.itemCount, 4); // 3 + 1
      });
    });
  });
}
