import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/delivery_order.dart';
import '../data/order_repository.dart';

/// State for order history with pagination, filtering, and loading states.
class OrderHistoryState {
  const OrderHistoryState({
    this.orders = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.nextCursor,
    this.hasMore = true,
    this.statusFilter,
  });

  final List<DeliveryOrder> orders;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String? nextCursor;
  final bool hasMore;
  final String? statusFilter;

  OrderHistoryState copyWith({
    List<DeliveryOrder>? orders,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? nextCursor,
    bool? hasMore,
    String? statusFilter,
  }) {
    return OrderHistoryState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }
}

/// Notifier that manages order history fetching, pagination, and filtering.
class OrderHistoryNotifier extends StateNotifier<OrderHistoryState> {
  OrderHistoryNotifier({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const OrderHistoryState());

  final OrderRepository _orderRepository;

  /// Loads the first page of orders (resets pagination).
  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _orderRepository.getOrders(
        status: state.statusFilter,
      );
      state = state.copyWith(
        isLoading: false,
        orders: result.orders,
        nextCursor: result.nextCursor,
        hasMore: result.hasMore,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Loads the next page of orders (appends to existing list).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final result = await _orderRepository.getOrders(
        cursor: state.nextCursor,
        status: state.statusFilter,
      );
      state = state.copyWith(
        isLoadingMore: false,
        orders: [...state.orders, ...result.orders],
        nextCursor: result.nextCursor,
        hasMore: result.hasMore,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  /// Sets the status filter and reloads from scratch.
  void setFilter(String? status) {
    state = OrderHistoryState(statusFilter: status);
    loadOrders();
  }

  /// Pull-to-refresh alias.
  Future<void> refresh() => loadOrders();
}

/// Provider for [OrderHistoryNotifier].
final orderHistoryNotifierProvider =
    StateNotifierProvider.autoDispose<OrderHistoryNotifier, OrderHistoryState>(
        (ref) {
  final orderRepo = ref.watch(orderRepositoryProvider);
  return OrderHistoryNotifier(orderRepository: orderRepo);
});
