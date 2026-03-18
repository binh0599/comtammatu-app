import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../domain/auth_notifier.dart';

/// Registration screen with form validation.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final phone = _phoneController.text.trim();

    try {
      await ref.read(authNotifierProvider.notifier).signUp(
            phone: phone,
            password: _passwordController.text,
            fullName: _nameController.text.trim(),
          );
      // Navigate to OTP verification screen
      if (mounted) {
        context.push(AppRoutes.otp, extra: phone);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Đăng ký thất bại. Vui lòng thử lại.';
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
      appBar: AppBar(
        title: Text(context.l10n.register),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // Header
                const Icon(
                  Icons.restaurant,
                  size: 64,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  context.l10n.authCreateAccount,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  context.l10n.authRegisterSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 32),

                // Full name
                AppTextField(
                  controller: _nameController,
                  label: context.l10n.authFullName,
                  hint: context.l10n.authFullNameHint,
                  prefixIcon: const Icon(Icons.person_outlined),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.authFullNameRequired;
                    }
                    if (value.trim().length < 2) {
                      return context.l10n.authFullNameMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone
                AppTextField(
                  controller: _phoneController,
                  label: context.l10n.authPhone,
                  hint: context.l10n.authPhoneHint,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.authPhoneRequired;
                    }
                    if (value.length < 10) {
                      return context.l10n.authPhoneInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                AppTextField(
                  controller: _passwordController,
                  label: context.l10n.authPassword,
                  hint: context.l10n.authPasswordHintShort,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.authPasswordRequired;
                    }
                    if (value.length < 6) {
                      return context.l10n.authPasswordMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm password
                AppTextField(
                  controller: _confirmPasswordController,
                  label: context.l10n.authConfirmPassword,
                  hint: context.l10n.authConfirmPasswordHint,
                  obscureText: _obscureConfirm,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.authConfirmPasswordRequired;
                    }
                    if (value != _passwordController.text) {
                      return context.l10n.authPasswordMismatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Referral code
                AppTextField(
                  controller: _referralController,
                  label: context.l10n.authReferralCode,
                  hint: context.l10n.authReferralCodeHint,
                  prefixIcon: const Icon(Icons.card_giftcard_outlined),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),

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

                // Register button
                AppButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  isLoading: _isLoading,
                  label: context.l10n.register,
                ),
                const SizedBox(height: 16),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.authHasAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(context.l10n.login),
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
