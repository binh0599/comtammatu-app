import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'delivery_repository.dart';
import 'models/delivery_tracking_model.dart';

// -- State ------------------------------------------------------------------

abstract class DeliveryState {
  const DeliveryState();
}

class DeliveryInitial extends DeliveryState {
  const DeliveryInitial();
}

class DeliveryLoading extends DeliveryState {
  const DeliveryLoading();
}

class DeliveryLoaded extends DeliveryState {
  const DeliveryLoaded(this.tracking);

  final DeliveryTracking tracking;
}

class DeliveryError extends DeliveryState {
  const DeliveryError(this.message);

  final String message;
}

// -- Notifier ---------------------------------------------------------------

class DeliveryNotifier extends StateNotifier<DeliveryState> {
  DeliveryNotifier({required DeliveryRepository repository})
      : _repository = repository,
        super(const DeliveryInitial());

  final DeliveryRepository _repository;
  StreamSubscription<DeliveryTracking>? _subscription;

  /// Loads the current tracking data for the given order.
  Future<void> loadTracking(String orderId) async {
    state = const DeliveryLoading();
    try {
      final tracking = await _repository.getTracking(orderId);
      state = DeliveryLoaded(tracking);
    } catch (e) {
      state = DeliveryError(e.toString());
    }
  }

  /// Subscribes to realtime updates for the given order.
  /// Each update replaces the current state with the latest tracking data.
  void subscribeToUpdates(String orderId) {
    _subscription?.cancel();
    _subscription = _repository.subscribeToTracking(orderId).listen(
      (tracking) {
        state = DeliveryLoaded(tracking);
      },
      onError: (Object error) {
        state = DeliveryError(error.toString());
      },
    );
  }

  /// Cancels the realtime subscription.
  void unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

// -- Providers --------------------------------------------------------------

final deliveryNotifierProvider =
    StateNotifierProvider.autoDispose<DeliveryNotifier, DeliveryState>((ref) {
  final repository = ref.watch(deliveryRepositoryProvider);
  return DeliveryNotifier(repository: repository);
});
