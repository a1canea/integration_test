import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_project/resocoder_integration_test/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Not inputting a text and wanting to go to the display page shows "
    "an error and prevents from going to the display page.",
    (widgetTester) async {
      await widgetTester.pumpWidget(MyApp());
      await widgetTester.tap(find.byType(FloatingActionButton));

      // for waiting all animations finished
      await widgetTester.pumpAndSettle();

      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      expect(find.text('Input at least one character'), findsOneWidget);
    },
  );

  testWidgets(
    "After inputting a text, go to the display page which contains that same text "
    "and then navigate back to the typing page where the input should be clear",
    (widgetTester) async {
      await widgetTester.pumpWidget(MyApp());
      const inputText = 'Some random input from user';
      await widgetTester.enterText(find.byKey(Key('your-text-field')), inputText);
      await widgetTester.tap(find.byType(FloatingActionButton));

      // for waiting all animations finished
      await widgetTester.pumpAndSettle();

      expect(find.byType(TypingPage), findsNothing);
      expect(find.byType(DisplayPage), findsOneWidget);
      expect(find.text(inputText), findsOneWidget);

      await widgetTester.tap(find.byType(BackButton));

      // for waiting all animations finished
      await widgetTester.pumpAndSettle();

      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);

      expect(find.text(inputText), findsNothing);
    },
  );
}
