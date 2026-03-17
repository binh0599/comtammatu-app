import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../domain/auth_notifier.dart';

/// Login screen with phone + password authentication.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authNotifierProvider.notifier).signIn(
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
          );
      // Navigation handled by auth state listener in router
    } catch (e) {
      setState(() {
        _errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                // Logo / Brand
                const Icon(
                  Icons.restaurant,
                  size: 80,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Cơm Tấm Má Tư',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Đăng nhập để tích điểm và đặt hàng',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 48),

                // Phone field
                AppTextField(
                  controller: _phoneController,
                  label: 'Số điện thoại',
                  hint: '0901234567',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (value.length < 10) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password field
                AppTextField(
                  controller: _passwordController,
                  label: 'Mật khẩu',
                  hint: 'Nhập mật khẩu',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Forgot password flow (Phase 2)
                    },
                    child: const Text('Quên mật khẩu?'),
                  ),
                ),
                const SizedBox(height: 16),

                // Error message
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Login button
                AppButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  isLoading: _isLoading,
                  label: 'Đăng nhập',
                ),
                const SizedBox(height: 16),

                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chưa có tài khoản? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.register),
                      child: const Text('Đăng ký ngay'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
