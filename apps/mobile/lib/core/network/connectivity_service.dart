import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lightweight wrapper around [Connectivity] for reactive online/offline
/// status across the app.
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  /// Emits `true` when the device has network access, `false` otherwise.
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(
      (results) => results.any((r) => r != ConnectivityResult.none),
    );
  }

  /// One-shot check — returns `true` if the device currently has network.
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}

/// Provides the singleton [ConnectivityService].
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

/// Reactive stream of online/offline status.
///
/// Usage:
/// ```dart
/// final online = ref.watch(isOnlineProvider);
/// online.when(
///   data: (isOnline) => isOnline ? OnlineWidget() : OfflineBanner(),
///   loading: () => SizedBox.shrink(),
///   error: (_, __) => SizedBox.shrink(),
/// );
/// ```
final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onConnectivityChanged;
});
