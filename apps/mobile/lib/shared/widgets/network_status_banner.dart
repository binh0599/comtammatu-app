import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A banner that shows when the device is offline.
/// Wrap your Scaffold body with this widget.
class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({
    super.key,
    required this.isOffline,
    required this.child,
  });

  final bool isOffline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isOffline ? 32 : 0,
          color: AppColors.warning,
          child: isOffline
              ? const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, size: 16, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Không có kết nối mạng · Đang dùng dữ liệu cũ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(child: child),
      ],
    );
  }
}
