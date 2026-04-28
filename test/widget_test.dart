import 'package:flutter_test/flutter_test.dart';

import 'package:projek1/main.dart';

void main() {
  testWidgets('Splash screen shows app branding', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('MoodSpace'), findsOneWidget);
    expect(find.text('Track your feelings beautifully'), findsOneWidget);
  });
}
