import 'package:flutter_test/flutter_test.dart';
import 'package:tinseltown_iq/main.dart';

void main() {
  testWidgets('Tinseltown IQ app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TinseltownIQApp());
  });
}
