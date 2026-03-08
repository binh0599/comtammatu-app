import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/feedback_model.dart';

/// Repository for feedback-related API calls.
class FeedbackRepository {
  FeedbackRepository(this._client);
  final ApiClient _client;

  /// Submit feedback for a completed order.
  Future<void> submitFeedback({
    required int orderId,
    required int rating,
    required String comment,
    List<String> tags = const [],
  }) async {
    await _client.post('/feedback', data: {
      'order_id': orderId,
      'rating': rating,
      'comment': comment,
      'tags': tags,
    });
  }

  /// Fetch all feedback submitted by the current user.
  Future<List<FeedbackModel>> getMyFeedback() async {
    final response = await _client.get<List<dynamic>>('/feedback/me');
    return response
        .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  return FeedbackRepository(ref.watch(apiClientProvider));
});
