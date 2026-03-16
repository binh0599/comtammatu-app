import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

// -- Screen ---------------------------------------------------------------

/// Settings screen with notification toggles, display options, and app info.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Notification toggles
  bool _pushNotifications = true;
  bool _promoNotifications = true;
  bool _orderNotifications = true;

  // Display toggles
  bool _darkMode = false;

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Chức năng đang phát triển'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa tài khoản'),
        content: const Text(
          'Bạn có chắc chắn muốn xóa tài khoản? '
          'Hành động này không thể hoàn tác và toàn bộ dữ liệu '
          'của bạn sẽ bị xóa vĩnh viễn.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Chức năng đang phát triển'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            child: const Text(
              'Xóa tài khoản',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications section
            const _SectionHeader(title: 'Thông báo'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                SwitchListTile(
                  title: const Text('Thông báo đẩy'),
                  subtitle: const Text('Nhận thông báo từ ứng dụng'),
                  value: _pushNotifications,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() => _pushNotifications = value);
                  },
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('Thông báo khuyến mãi'),
                  subtitle: const Text('Ưu đãi và chương trình đặc biệt'),
                  value: _promoNotifications,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() => _promoNotifications = value);
                  },
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('Thông báo đơn hàng'),
                  subtitle: const Text('Cập nhật trạng thái đơn hàng'),
                  value: _orderNotifications,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() => _orderNotifications = value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Display section
            const _SectionHeader(title: 'Hiển thị'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                SwitchListTile(
                  title: const Text('Chế độ tối'),
                  subtitle: const Text('Chuyển sang giao diện tối'),
                  value: _darkMode,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() => _darkMode = value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Language section
            const _SectionHeader(title: 'Ngôn ngữ'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                ListTile(
                  title: const Text('Ngôn ngữ'),
                  subtitle: const Text('Tiếng Việt'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                  ),
                  onTap: _showComingSoon,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // About section
            const _SectionHeader(title: 'Về ứng dụng'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Điều khoản sử dụng'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                  ),
                  onTap: _showComingSoon,
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Chính sách bảo mật'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                  ),
                  onTap: _showComingSoon,
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.star_outline),
                  title: const Text('Đánh giá ứng dụng'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                  ),
                  onTap: _showComingSoon,
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Phiên bản'),
                  trailing: Text(
                    '1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Account section
            const _SectionHeader(title: 'Tài khoản'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever_outlined,
                    color: AppColors.error,
                  ),
                  title: const Text(
                    'Xóa tài khoản',
                    style: TextStyle(color: AppColors.error),
                  ),
                  onTap: _showDeleteAccountDialog,
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// -- Section header -------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
    );
  }
}

// -- Settings card --------------------------------------------------------

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}
