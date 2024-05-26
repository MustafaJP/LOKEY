import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lokey/input_page.dart';
import 'package:lokey/main.dart';
import 'package:lokey/output_page.dart';

void main() {
  testWidgets('Full app navigation and interaction test',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the Welcome Page is displayed.
    expect(find.text('GetStarted'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the button to navigate to the Form Page.
    await tester.tap(find.byKey(const Key('navigateToFormButton')));
    await tester.pumpAndSettle();

    // Verify that the Form Page is displayed.
    expect(find.byType(InputPage), findsOneWidget);

    // Fill out the form.
    await tester.enterText(find.byKey(const Key('annualIncome')), '50000');

    await tester.tap(find.byKey(const Key('monthlyExpensesDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('12').last);
    await tester.pumpAndSettle();

    for (int i = 1; i <= 12; i++) {
      await tester.enterText(find.byKey(Key('monthlyExpense$i')), '3000');
    }

    await tester.enterText(find.byKey(const Key('emergencyFund')), '69850');

    await tester.tap(find.byKey(const Key('jobTypeDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Engineering').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('dependencies')), '2');

    // Submit the form.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that the Result Page is displayed.
    expect(find.byType(OutputPage), findsOneWidget);
    expect(find.textContaining('Result'), findsOneWidget);

    // Verify the presence of the recommendation button.
    expect(find.byKey(const Key('showRecommendationButton')), findsOneWidget);
  });
}
