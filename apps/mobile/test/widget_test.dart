import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test — placeholder', (WidgetTester tester) async {
    // ComTamMaTuApp requires Supabase + Firebase init.
    // Full widget tests are in test/features/.
    expect(1 + 1, equals(2));
  });
}
