import 'package:comtammatu/features/order/data/order_repository.dart';
import 'package:comtammatu/features/order/domain/order_history_notifier.dart';
import 'package:comtammatu/features/order/presentation/order_history_screen.dart';
import 'package:comtammatu/models/delivery_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

DeliveryOrder _sampleOrder({
  int orderId = 101,
  String status = 'delivered',
  double total = 95000,
}) {
  return DeliveryOrder(
    orderId: orderId,
    deliveryOrderId: orderId + 1000,
    status: status,
    items: [
      const OrderItem(
        menuItemId: 1,
        name: 'Cơm tấm sườn',
        quantity: 2,
        unitPrice: 45000,
        subtotal: 90000,
      ),
    ],
    subtotal: 90000,
    deliveryFee: 15000,
    discount: 10000,
    total: total,
    estimatedDeliveryAt: DateTime(2026, 3, 11, 12),
    pointsWillEarn: 95,
    createdAt: DateTime(2026, 3, 10, 18, 30),
  );
}

void main() {
  late MockOrderRepository mockOrderRepo;

  setUp(() {
    mockOrderRepo = MockOrderRepository();
  });

  /// Build OrderHistoryScreen with a pre-loaded [OrderHistoryState].
  Widget buildSubject({OrderHistoryState? initialState}) {
    return ProviderScope(
      overrides: [
        orderRepositoryProvider.overrideWithValue(mockOrderRepo),
        if (initialState != null)
          orderHistoryNotifierProvider.overrideWith(
            (ref) {
              // We need a custom notifier that starts with the given state.
              // Because the constructor always starts with default state, we
              // use a tiny helper subclass.
              return _PreloadedOrderHistoryNotifier(
                orderRepository: mockOrderRepo,
                preloadedState: initialState,
              );
            },
          ),
      ],
      child: const MaterialApp(
        home: OrderHistoryScreen(),
      ),
    );
  }

  group('OrderHistoryScreen', () {
    testWidgets('shows loading shimmer on initial load', (tester) async {
      // Without override, initState triggers loadOrders on the notifier.
      // Mock getOrders to hang so loading state persists.
      when(() => mockOrderRepo.getOrders(
            status: any(named: 'status'),
            cursor: any(named: 'cursor'),
            limit: any(named: 'limit'),
          )).thenAnswer(
        (_) async {
          await Future<void>.delayed(const Duration(seconds: 30));
          return const PaginatedOrders(orders: [], hasMore: false);
        },
      );

      await tester.pumpWidget(buildSubject(
        initialState: const OrderHistoryState(isLoading: true),
      ));

      // Shimmer cards are rendered as Cards with Container placeholders
      // The loading shimmer renders 4 Card widgets
      expect(find.byType(Card), findsAtLeast(4));
    });

    testWidgets('shows empty state when no orders', (tester) async {
      when(() => mockOrderRepo.getOrders(
            status: any(named: 'status'),
            cursor: any(named: 'cursor'),
            limit: any(named: 'limit'),
          )).thenAnswer(
        (_) async => const PaginatedOrders(orders: [], hasMore: false),
      );

      await tester.pumpWidget(buildSubject(
        initialState: const OrderHistoryState(
          hasMore: false,
        ),
      ));

      expect(find.text('Chưa có đơn hàng nào'), findsOneWidget);
    });

    testWidgets('shows order cards when orders exist', (tester) async {
      final orders = [
        _sampleOrder(),
        _sampleOrder(orderId: 102, status: 'delivering', total: 50000),
      ];

      when(() => mockOrderRepo.getOrders(
            status: any(named: 'status'),
            cursor: any(named: 'cursor'),
            limit: any(named: 'limit'),
          )).thenAnswer(
        (_) async => PaginatedOrders(orders: orders, hasMore: false),
      );

      await tester.pumpWidget(buildSubject(
        initialState: OrderHistoryState(
          orders: orders,
          hasMore: false,
        ),
      ));

      expect(find.textContaining('Đơn #101'), findsOneWidget);
      expect(find.textContaining('Đơn #102'), findsOneWidget);
      // "Hoàn thành" appears in both the filter chip and the order status badge
      expect(find.text('Hoàn thành'), findsAtLeast(1));
      // "Đang giao" appears in filter chip and potentially in order status
      expect(find.text('Đang giao'), findsAtLeast(1));
    });
  });
}

/// Helper subclass to inject a pre-loaded state into OrderHistoryNotifier.
class _PreloadedOrderHistoryNotifier extends OrderHistoryNotifier {
  _PreloadedOrderHistoryNotifier({
    required super.orderRepository,
    required OrderHistoryState preloadedState,
  }) {
    state = preloadedState;
  }

  // Override loadOrders to be a no-op when pre-loaded, so initState's
  // post-frame callback doesn't reset the state.
  @override
  Future<void> loadOrders() async {
    // no-op: state was preloaded
  }
}
