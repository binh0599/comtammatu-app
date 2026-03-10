import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/api_client.dart';
import 'models/delivery_tracking_model.dart';

/// Repository for delivery tracking API calls and realtime subscriptions.
class DeliveryRepository {
  const DeliveryRepository({
    required ApiClient apiClient,
    required SupabaseClient supabase,
  })  : _apiClient = apiClient,
        _supabase = supabase;

  final ApiClient _apiClient;
  final SupabaseClient _supabase;

  /// Fetches the current tracking state for an order via edge function.
  Future<DeliveryTracking> getTracking(String orderId) async {
    return _apiClient.get<DeliveryTracking>(
      '/delivery-tracking',
      queryParameters: {'order_id': orderId},
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        return DeliveryTracking.fromJson(
          map['tracking'] as Map<String, dynamic>,
        );
      },
    );
  }

  /// Subscribes to realtime updates on the delivery_tracking table
  /// filtered by [orderId]. Returns a stream of [DeliveryTracking].
  Stream<DeliveryTracking> subscribeToTracking(String orderId) {
    final controller = StreamController<DeliveryTracking>.broadcast();

    final channel = _supabase
        .channel('delivery_tracking_$orderId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'delivery_tracking',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'order_id',
            value: orderId,
          ),
          callback: (payload) {
            final newRecord = payload.newRecord;
            if (newRecord.isNotEmpty) {
              controller.add(DeliveryTracking.fromJson(newRecord));
            }
          },
        )
        .subscribe();

    controller.onCancel = () {
      _supabase.removeChannel(channel);
    };

    return controller.stream;
  }
}

/// Riverpod provider for [DeliveryRepository].
final deliveryRepositoryProvider = Provider<DeliveryRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final supabase = Supabase.instance.client;
  return DeliveryRepository(apiClient: apiClient, supabase: supabase);
});
