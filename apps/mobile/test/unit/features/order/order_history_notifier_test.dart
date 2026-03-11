// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/order/data/order_repository.dart';
import 'package:comtammatu/features/order/domain/order_history_notifier.dart';
import 'package:comtammatu/models/delivery_order.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

DeliveryOrder _sampleOrder({
  int orderId = 1,
  String status = 'delivered',
}) {
  return DeliveryOrder(
    orderId: orderId,
    deliveryOrderId: orderId,
    status: status,
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
    estimatedDeliveryAt: DateTime(2026, 3, 10),
    pointsWillEarn: 60,
    createdAt: DateTime(2026, 3, 10),
  );
}

PaginatedOrders _paginatedResponse({
  List<DeliveryOrder>? orders,
  bool hasMore = false,
  String? nextCursor,
}) {
  return PaginatedOrders(
    orders: orders ?? [_sampleOrder()],
    hasMore: hasMore,
    nextCursor: nextCursor,
  );
}

void main() {
  late OrderHistoryNotifier notifier;
  late MockOrderRepository mockRepo;

  setUp(() {
    mockRepo = MockOrderRepository();
    notifier = OrderHistoryNotifier(orderRepository: mockRepo);
  });

  group('OrderHistoryNotifier', () {
    test('initial state is empty with no loading', () {
      expect(notifier.state.orders, isEmpty);
      expect(notifier.state.isLoading, isFalse);
      expect(notifier.state.isLoadingMore, isFalse);
      expect(notifier.state.error, isNull);
      expect(notifier.state.hasMore, isTrue);
    });

    group('loadOrders', () {
      test('loads orders from repository', () async {
        when(() => mockRepo.getOrders())
            .thenAnswer((_) async => _paginatedResponse());

        await notifier.loadOrders();

        expect(notifier.state.orders, hasLength(1));
        expect(notifier.state.isLoading, isFalse);
        expect(notifier.state.error, isNull);
      });

      test('sets isLoading during fetch', () async {
        var wasLoading = false;

        notifier.addListener((state) {
          if (state.isLoading) wasLoading = true;
        });

        when(() => mockRepo.getOrders())
            .thenAnswer((_) async => _paginatedResponse());

        await notifier.loadOrders();

        expect(wasLoading, isTrue);
        expect(notifier.state.isLoading, isFalse);
      });

      test('sets error on failure', () async {
        when(() => mockRepo.getOrders())
            .thenThrow(Exception('Network error'));

        await notifier.loadOrders();

        expect(notifier.state.error, contains('Network error'));
        expect(notifier.state.isLoading, isFalse);
        expect(notifier.state.orders, isEmpty);
      });

      test('stores pagination info', () async {
        when(() => mockRepo.getOrders()).thenAnswer(
          (_) async => _paginatedResponse(
            hasMore: true,
            nextCursor: 'cursor_abc',
          ),
        );

        await notifier.loadOrders();

        expect(notifier.state.hasMore, isTrue);
        expect(notifier.state.nextCursor, 'cursor_abc');
      });
    });

    group('loadMore', () {
      test('appends new orders to existing list', () async {
        // First load
        when(() => mockRepo.getOrders()).thenAnswer(
          (_) async => _paginatedResponse(
            orders: [_sampleOrder()],
            hasMore: true,
            nextCursor: 'cursor_1',
          ),
        );
        await notifier.loadOrders();

        // Load more
        when(() => mockRepo.getOrders(cursor: 'cursor_1'))
            .thenAnswer(
          (_) async => _paginatedResponse(
            orders: [_sampleOrder(orderId: 2)],
          ),
        );
        await notifier.loadMore();

        expect(notifier.state.orders, hasLength(2));
        expect(notifier.state.orders[0].orderId, 1);
        expect(notifier.state.orders[1].orderId, 2);
        expect(notifier.state.hasMore, isFalse);
      });

      test('does nothing when hasMore is false', () async {
        when(() => mockRepo.getOrders())
            .thenAnswer((_) async => _paginatedResponse());
        await notifier.loadOrders();

        // Reset call count after initial load
        clearInteractions(mockRepo);

        await notifier.loadMore();

        verifyZeroInteractions(mockRepo);
      });

      test('does nothing when already loading more', () async {
        when(() => mockRepo.getOrders()).thenAnswer(
          (_) async => _paginatedResponse(hasMore: true, nextCursor: 'c1'),
        );
        await notifier.loadOrders();

        // Simulate concurrent loadMore calls
        when(() => mockRepo.getOrders(cursor: 'c1')).thenAnswer(
          (_) async {
            // Slow response
            await Future<void>.delayed(const Duration(milliseconds: 50));
            return _paginatedResponse();
          },
        );

        final future1 = notifier.loadMore();
        final future2 = notifier.loadMore(); // Should be no-op

        await Future.wait([future1, future2]);

        verify(() => mockRepo.getOrders(cursor: 'c1')).called(1);
      });
    });

    group('setFilter', () {
      test('resets state and loads with new filter', () async {
        // Initial load
        when(() => mockRepo.getOrders()).thenAnswer(
          (_) async => _paginatedResponse(
            orders: [_sampleOrder(), _sampleOrder(orderId: 2)],
          ),
        );
        await notifier.loadOrders();
        expect(notifier.state.orders, hasLength(2));

        // Filter to 'delivering'
        when(() => mockRepo.getOrders(status: 'delivering')).thenAnswer(
          (_) async => _paginatedResponse(
            orders: [_sampleOrder(orderId: 3, status: 'delivering')],
          ),
        );
        notifier.setFilter('delivering');

        // Wait for the async loadOrders triggered by setFilter
        await Future<void>.delayed(Duration.zero);

        expect(notifier.state.statusFilter, 'delivering');
      });

      test('clears filter with null', () async {
        when(() => mockRepo.getOrders(status: 'delivered')).thenAnswer(
          (_) async => _paginatedResponse(),
        );
        notifier.setFilter('delivered');
        await Future<void>.delayed(Duration.zero);

        when(() => mockRepo.getOrders()).thenAnswer(
          (_) async => _paginatedResponse(),
        );
        notifier.setFilter(null);
        await Future<void>.delayed(Duration.zero);

        expect(notifier.state.statusFilter, isNull);
      });
    });

    group('refresh', () {
      test('reloads orders from scratch', () async {
        when(() => mockRepo.getOrders())
            .thenAnswer((_) async => _paginatedResponse());

        await notifier.refresh();

        verify(() => mockRepo.getOrders()).called(1);
        expect(notifier.state.orders, hasLength(1));
      });
    });
  });
}
