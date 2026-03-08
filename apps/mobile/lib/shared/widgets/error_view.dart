import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_button.dart';

/// Displays an error message with an optional retry button.
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.message = 'Đã xảy ra lỗi',
    this.icon = Icons.error_outline,
    this.onRetry,
    this.retryLabel = 'Thử lại',
  });

  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              AppButton(
                label: retryLabel,
                onPressed: onRetry,
                variant: AppButtonVariant.outlined,
                fullWidth: false,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
