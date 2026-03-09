import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/store_model.dart';
import 'store_repository.dart';

// -- State ------------------------------------------------------------------

abstract class StoreState {
  const StoreState();
}

class StoreInitial extends StoreState {
  const StoreInitial();
}

class StoreLoading extends StoreState {
  const StoreLoading();
}

class StoreLoaded extends StoreState {
  const StoreLoaded(this.stores);

  final List<StoreInfo> stores;
}

class StoreError extends StoreState {
  const StoreError(this.message);

  final String message;
}

// -- Notifier ---------------------------------------------------------------

class StoreNotifier extends StateNotifier<StoreState> {
  StoreNotifier({required StoreRepository repository})
      : _repository = repository,
        super(const StoreInitial());

  final StoreRepository _repository;

  /// Loads all stores.
  Future<void> loadStores() async {
    state = const StoreLoading();
    try {
      final stores = await _repository.getStores();
      state = StoreLoaded(stores);
    } catch (e) {
      state = StoreError(e.toString());
    }
  }

  /// Loads stores sorted by distance from the given coordinates.
  Future<void> loadNearbyStores(double lat, double lng) async {
    state = const StoreLoading();
    try {
      final stores = await _repository.getNearbyStores(lat, lng);
      state = StoreLoaded(stores);
    } catch (e) {
      state = StoreError(e.toString());
    }
  }
}

// -- Providers --------------------------------------------------------------

final storeNotifierProvider =
    StateNotifierProvider<StoreNotifier, StoreState>((ref) {
  final repository = ref.watch(storeRepositoryProvider);
  return StoreNotifier(repository: repository);
});

/// Hardcoded sample stores in Ho Chi Minh City for development.
final sampleStoresProvider = Provider<List<StoreInfo>>((ref) {
  return const [
    StoreInfo(
      id: 1,
      name: 'Cơm Tấm Má Tư - Quận 1',
      address: '123 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP.HCM',
      phone: '0901234567',
      latitude: 10.7769,
      longitude: 106.7009,
      openingTime: '06:00',
      closingTime: '22:00',
      isActive: true,
    ),
    StoreInfo(
      id: 2,
      name: 'Cơm Tấm Má Tư - Quận 3',
      address: '456 Võ Văn Tần, Phường 5, Quận 3, TP.HCM',
      phone: '0907654321',
      latitude: 10.7834,
      longitude: 106.6867,
      openingTime: '06:00',
      closingTime: '22:00',
      isActive: true,
    ),
    StoreInfo(
      id: 3,
      name: 'Cơm Tấm Má Tư - Quận 7',
      address: '789 Nguyễn Thị Thập, Phường Tân Phú, Quận 7, TP.HCM',
      phone: '0912345678',
      latitude: 10.7340,
      longitude: 106.7218,
      openingTime: '06:00',
      closingTime: '21:30',
      isActive: true,
    ),
    StoreInfo(
      id: 4,
      name: 'Cơm Tấm Má Tư - Bình Thạnh',
      address: '321 Điện Biên Phủ, Phường 15, Quận Bình Thạnh, TP.HCM',
      phone: '0923456789',
      latitude: 10.8025,
      longitude: 106.7106,
      openingTime: '05:30',
      closingTime: '22:00',
      isActive: true,
    ),
    StoreInfo(
      id: 5,
      name: 'Cơm Tấm Má Tư - Gò Vấp',
      address: '654 Quang Trung, Phường 11, Quận Gò Vấp, TP.HCM',
      phone: '0934567890',
      latitude: 10.8388,
      longitude: 106.6652,
      openingTime: '06:00',
      closingTime: '21:00',
      isActive: true,
    ),
  ];
});
