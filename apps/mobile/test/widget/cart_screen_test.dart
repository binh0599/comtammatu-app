import 'package:comtammatu/features/cart/domain/cart_notifier.dart';
import 'package:comtammatu/features/cart/domain/cart_state.dart';
import 'package:comtammatu/features/cart/presentation/cart_screen.dart';
import 'package:comtammatu/features/order/data/order_repository.dart';
import 'package:comtammatu/models/cart_item.dart';
import 'package:comtammatu/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

MenuItem _menuItem({
  int id = 1,
  String name = 'Cơm tấm sườn',
  double price = 45000,
}) {
  return MenuItem(id: id, name: name, price: price);
}

void main() {
  late MockOrderRepository mockOrderRepo;

  setUp(() {
    mockOrderRepo = MockOrderRepository();
  });

  Widget buildSubject({CartState? initialState}) {
    return ProviderScope(
      overrides: [
        orderRepositoryProvider.overrideWithValue(mockOrderRepo),
        if (initialState != null)
          cartNotifierProvider.overrideWith(
            (ref) {
              final notifier = CartNotifier(orderRepository: mockOrderRepo);
              // Set initial items by adding them
              for (final item in initialState.items) {
                notifier.addItem(item.menuItem);
                if (item.quantity > 1) {
                  notifier.updateQuantity(item.menuItem.id, item.quantity);
                }
                if (item.note != null) {
                  notifier.updateNote(item.menuItem.id, item.note!);
                }
              }
              return notifier;
            },
          ),
      ],
      child: const MaterialApp(
        home: CartScreen(),
      ),
    );
  }

  group('CartScreen', () {
    testWidgets('shows empty cart message when no items', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text('Giỏ hàng trống'), findsOneWidget);
      expect(find.text('Xem thực đơn'), findsOneWidget);
    });

    testWidgets('shows cart items when items exist', (tester) async {
      final items = [
        CartItem(menuItem: _menuItem(), quantity: 2),
        CartItem(
          menuItem: _menuItem(id: 2, name: 'Cơm tấm bì', price: 40000),
          quantity: 1,
        ),
      ];

      await tester.pumpWidget(
        buildSubject(initialState: CartState(items: items)),
      );

      expect(find.text('Cơm tấm sườn'), findsOneWidget);
      expect(find.text('Cơm tấm bì'), findsOneWidget);
    });

    testWidgets('shows total price correctly', (tester) async {
      // 45000 * 2 = 90000 + 40000 * 1 = 40000 => 130000
      final items = [
        CartItem(menuItem: _menuItem(), quantity: 2),
        CartItem(
          menuItem: _menuItem(id: 2, name: 'Cơm tấm bì', price: 40000),
          quantity: 1,
        ),
      ];

      await tester.pumpWidget(
        buildSubject(initialState: CartState(items: items)),
      );

      // The total is displayed as formatted price (130.000₫)
      // It appears in both the summary card and the bottom bar
      expect(find.text('130.000₫'), findsAtLeast(1));
    });
  });
}
