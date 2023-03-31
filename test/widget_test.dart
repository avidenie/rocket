import 'package:flutter_test/flutter_test.dart';

import 'package:rocket/main.dart';

void main() {
  testWidgets('Home page shows hello world', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('hello world'), findsOneWidget);
  });
}
