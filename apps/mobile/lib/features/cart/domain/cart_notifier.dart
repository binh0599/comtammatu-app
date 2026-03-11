import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/cart_item.dart';
import '../../../models/menu_item.dart';
import '../../order/data/order_repository.dart';
import 'cart_state.dart';

/// Manages shopping cart state.
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const CartState());

  final OrderRepository _orderRepository;

  /// Add a menu item to cart.
  void addItem(MenuItem menuItem, {String? note}) {
    final existingIndex =
        state.items.indexWhere((item) => item.menuItem.id == menuItem.id);

    if (existingIndex >= 0) {
      final updatedItems = [...state.items];
      final existing = updatedItems[existingIndex];
      updatedItems[existingIndex] = CartItem(
        menuItem: existing.menuItem,
        quantity: existing.quantity + 1,
        note: note ?? existing.note,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          CartItem(menuItem: menuItem, quantity: 1, note: note)
        ],
      );
    }
  }

  /// Remove a menu item from cart entirely.
  void removeItem(int menuItemId) {
    state = state.copyWith(
      items:
          state.items.where((item) => item.menuItem.id != menuItemId).toList(),
    );
  }

  /// Update quantity of a cart item.
  void updateQuantity(int menuItemId, int quantity) {
    if (quantity <= 0) {
      removeItem(menuItemId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.menuItem.id == menuItemId) {
        return CartItem(
          menuItem: item.menuItem,
          quantity: quantity,
          note: item.note,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  /// Update note for a cart item.
  void updateNote(int menuItemId, String note) {
    final updatedItems = state.items.map((item) {
      if (item.menuItem.id == menuItemId) {
        return CartItem(
          menuItem: item.menuItem,
          quantity: item.quantity,
          note: note,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  /// Set payment method.
  void setPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method);
  }

  /// Set delivery address with coordinates.
  void setAddress({
    required String deliveryAddress,
    required double latitude,
    required double longitude,
  }) {
    state = state.copyWith(
      deliveryAddress: deliveryAddress,
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Set order note.
  void setNote(String note) {
    state = state.copyWith(note: note);
  }

  /// Apply coupon code.
  void applyCoupon(String code) {
    state = state.copyWith(couponCode: code);
  }

  /// Clear all items from cart.
  void clearCart() {
    state = const CartState();
  }

  /// Place the delivery order.
  Future<void> placeOrder() async {
    final address = state.deliveryAddress;
    final lat = state.latitude;
    final lng = state.longitude;

    if (address == null || lat == null || lng == null) {
      throw StateError('Vui lòng chọn địa chỉ giao hàng');
    }

    await _orderRepository.createDeliveryOrder(
      items: state.items,
      deliveryAddress: address,
      latitude: lat,
      longitude: lng,
      note: state.note.isEmpty ? null : state.note,
      promotionId: state.promotionId,
    );

    clearCart();
  }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) {
  final orderRepo = ref.watch(orderRepositoryProvider);
  return CartNotifier(orderRepository: orderRepo);
});
