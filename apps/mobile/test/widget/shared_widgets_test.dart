import 'package:comtammatu/shared/widgets/app_button.dart';
import 'package:comtammatu/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Đăng nhập',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Đăng nhập'), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Đăng nhập',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Label should not be visible when loading
      expect(find.text('Đăng nhập'), findsNothing);
    });

    testWidgets('button is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Đăng nhập',
            ),
          ),
        ),
      );

      final elevatedButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(elevatedButton.onPressed, isNull);
    });

    testWidgets('primary variant renders ElevatedButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Primary',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('outlined variant renders OutlinedButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Outlined',
              variant: AppButtonVariant.outlined,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('text variant renders TextButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Text',
              variant: AppButtonVariant.text,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('AppTextField', () {
    testWidgets('renders label and hint', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Số điện thoại',
              hint: '0901234567',
            ),
          ),
        ),
      );

      expect(find.text('Số điện thoại'), findsOneWidget);
      expect(find.text('0901234567'), findsOneWidget);
    });

    testWidgets('shows validation error via errorText', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Email',
              errorText: 'Email không hợp lệ',
            ),
          ),
        ),
      );

      expect(find.text('Email không hợp lệ'), findsOneWidget);
    });

    testWidgets('shows validation error from validator on form submit',
        (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  AppTextField(
                    label: 'Tên',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState!.validate(),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Vui lòng nhập tên'), findsOneWidget);
    });

    testWidgets('renders prefix icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Điện thoại',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.phone), findsOneWidget);
    });

    testWidgets('field is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Disabled',
              enabled: false,
            ),
          ),
        ),
      );

      final textFormField = tester.widget<TextFormField>(
        find.byType(TextFormField),
      );
      expect(textFormField.enabled, isFalse);
    });
  });
}
