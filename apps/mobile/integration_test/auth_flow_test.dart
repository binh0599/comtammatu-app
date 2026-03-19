import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'patrol_base.dart';

void main() {
  patrolTest(
    'Auth flow — login screen renders and validates empty fields',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();

      await $.pumpWidgetAndSettle(
        buildTestApp(prefs: prefs, authRepo: mockAuthRepo),
      );

      // The splash screen should redirect to login (unauthenticated)
      await $.pumpAndSettle();

      // Verify login screen is displayed
      expect($(Icons.restaurant), findsOneWidget);
      expect($('Cơm Tấm Má Tư'), findsOneWidget);

      // Verify phone and password fields exist
      expect($('Số điện thoại'), findsOneWidget);
      expect($('Mật khẩu'), findsOneWidget);

      // Tap login without filling fields — should show validation errors
      await $('Đăng nhập').tap();
      await $.pumpAndSettle();

      expect($('Vui lòng nhập số điện thoại'), findsOneWidget);
      expect($('Vui lòng nhập mật khẩu'), findsOneWidget);
    },
  );

  patrolTest(
    'Auth flow — invalid credentials show error message',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = signInFailureMockAuthRepo(
        errorMessage: 'Invalid credentials',
      );

      await $.pumpWidgetAndSettle(
        buildTestApp(prefs: prefs, authRepo: mockAuthRepo),
      );

      // Wait for splash → login redirect
      await $.pumpAndSettle();

      // Fill in phone number
      final phoneField = $(TextFormField).first;
      await phoneField.enterText('0901234567');

      // Fill in password
      final passwordField = $(TextFormField).last;
      await passwordField.enterText('wrongpassword');

      // Tap login
      await $('Đăng nhập').tap();
      await $.pumpAndSettle();

      // Should display the error message
      expect($('Đăng nhập thất bại. Vui lòng thử lại.'), findsOneWidget);
    },
  );

  patrolTest(
    'Auth flow — short phone number shows validation error',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();

      await $.pumpWidgetAndSettle(
        buildTestApp(prefs: prefs),
      );

      await $.pumpAndSettle();

      // Enter a phone number that is too short
      final phoneField = $(TextFormField).first;
      await phoneField.enterText('0901');

      // Enter a valid password
      final passwordField = $(TextFormField).last;
      await passwordField.enterText('password123');

      // Tap login
      await $('Đăng nhập').tap();
      await $.pumpAndSettle();

      expect($('Số điện thoại không hợp lệ'), findsOneWidget);
    },
  );

  patrolTest(
    'Auth flow — short password shows validation error',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();

      await $.pumpWidgetAndSettle(
        buildTestApp(prefs: prefs),
      );

      await $.pumpAndSettle();

      // Enter valid phone
      final phoneField = $(TextFormField).first;
      await phoneField.enterText('0901234567');

      // Enter short password
      final passwordField = $(TextFormField).last;
      await passwordField.enterText('123');

      // Tap login
      await $('Đăng nhập').tap();
      await $.pumpAndSettle();

      expect($('Mật khẩu phải có ít nhất 6 ký tự'), findsOneWidget);
    },
  );

  patrolTest(
    'Auth flow — register link navigates to register screen',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();

      await $.pumpWidgetAndSettle(
        buildTestApp(prefs: prefs),
      );

      await $.pumpAndSettle();

      // Tap "Đăng ký ngay" link
      await $('Đăng ký ngay').tap();
      await $.pumpAndSettle();

      // Verify register screen is shown (it should have different content)
      // The register screen should be visible after navigation
      expect($('Đăng ký'), findsWidgets);
    },
  );
}
