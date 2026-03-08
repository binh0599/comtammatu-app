import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';

/// A loading indicator that shows either a shimmer effect or a spinner.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.type = LoadingType.spinner,
    this.message,
  });

  final LoadingType type;
  final String? message;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LoadingType.spinner:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppColors.primary,
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ],
          ),
        );
      case LoadingType.shimmer:
        return Shimmer.fromColors(
          baseColor: AppColors.border,
          highlightColor: AppColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}

enum LoadingType { spinner, shimmer }
