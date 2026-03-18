import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../domain/feedback_notifier.dart';
import '../domain/feedback_state.dart';

/// Tag keys used for feedback (stable identifiers for storage).
const _kFeedbackTagKeys = [
  'delicious',
  'fast',
  'clean',
  'friendly',
  'fair_price',
  'large_portions',
];

/// Feedback screen for rating a completed order.
class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({
    required this.orderId,
    super.key,
  });

  final int orderId;

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  int _rating = 0;
  final _commentController = TextEditingController();
  final _selectedTags = <String>{};

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.feedbackSelectRating),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ref.read(feedbackNotifierProvider.notifier).submitFeedback(
          orderId: widget.orderId,
          rating: _rating,
          comment: _commentController.text.trim(),
          tags: _selectedTags.toList(),
        );
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.textOnPrimary,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.feedbackThankYou,
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.feedbackSuccessMessage,
              textAlign: TextAlign.center,
              style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ref.read(feedbackNotifierProvider.notifier).reset();
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(context.l10n.feedbackBack),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<FeedbackState>(feedbackNotifierProvider, (previous, next) {
      if (next is FeedbackSubmitted) {
        _showSuccessDialog();
      } else if (next is FeedbackError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${next.message}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    final feedbackState = ref.watch(feedbackNotifierProvider);
    final isLoading = feedbackState is FeedbackLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.feedbackTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order info header
            _OrderInfoCard(orderId: widget.orderId),

            const SizedBox(height: 16),

            // Star rating section
            _StarRatingCard(
              rating: _rating,
              onRatingChanged: (value) {
                setState(() => _rating = value);
              },
            ),

            const SizedBox(height: 16),

            // Quick feedback tags
            _FeedbackTagsCard(
              selectedTags: _selectedTags,
              onTagToggled: (tag) {
                setState(() {
                  if (_selectedTags.contains(tag)) {
                    _selectedTags.remove(tag);
                  } else {
                    _selectedTags.add(tag);
                  }
                });
              },
            ),

            const SizedBox(height: 16),

            // Comment section
            _CommentCard(controller: _commentController),

            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textOnPrimary,
                        ),
                      )
                    : Text(
                        context.l10n.feedbackSubmit,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// -- Order info card --------------------------------------------------------

class _OrderInfoCard extends StatelessWidget {
  const _OrderInfoCard({required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.feedbackOrderId(orderId.toString()),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.l10n.feedbackShareExperience,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Star rating card -------------------------------------------------------

class _StarRatingCard extends StatelessWidget {
  const _StarRatingCard({
    required this.rating,
    required this.onRatingChanged,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;

  String _ratingLabel(BuildContext context, int rating) {
    return switch (rating) {
      1 => context.l10n.feedbackRatingTerrible,
      2 => context.l10n.feedbackRatingBad,
      3 => context.l10n.feedbackRatingAverage,
      4 => context.l10n.feedbackRatingGood,
      5 => context.l10n.feedbackRatingExcellent,
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              context.l10n.feedbackHowWouldYouRate,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return GestureDetector(
                  onTap: () => onRatingChanged(starIndex),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      starIndex <= rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 40,
                      color: starIndex <= rating
                          ? AppColors.secondary
                          : AppColors.textHint,
                    ),
                  ),
                );
              }),
            ),
            if (rating > 0) ...[
              const SizedBox(height: 8),
              Text(
                _ratingLabel(context, rating),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// -- Feedback tags card -----------------------------------------------------

class _FeedbackTagsCard extends StatelessWidget {
  const _FeedbackTagsCard({
    required this.selectedTags,
    required this.onTagToggled,
  });

  final Set<String> selectedTags;
  final ValueChanged<String> onTagToggled;

  String _tagLabel(BuildContext context, String key) {
    return switch (key) {
      'delicious' => context.l10n.feedbackTagDelicious,
      'fast' => context.l10n.feedbackTagFast,
      'clean' => context.l10n.feedbackTagClean,
      'friendly' => context.l10n.feedbackTagFriendly,
      'fair_price' => context.l10n.feedbackTagFairPrice,
      'large_portions' => context.l10n.feedbackTagLargePortions,
      _ => key,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.feedbackWhatDidYouLike,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _kFeedbackTagKeys.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(_tagLabel(context, tag)),
                  selected: isSelected,
                  onSelected: (_) => onTagToggled(tag),
                  selectedColor: AppColors.primary.withValues(alpha: 0.15),
                  checkmarkColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Comment card -----------------------------------------------------------

class _CommentCard extends StatelessWidget {
  const _CommentCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.feedbackAdditionalComments,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: context.l10n.feedbackCommentHint,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textHint,
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
