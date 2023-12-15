// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_todo/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Enter 'pay bills' into the TextField.
    await tester.enterText(find.byType(TextField), 'pay bills');

    // Rebuild the widget with the new item.
    await tester.pump();

    // Expect to find the item on screen.
    expect(find.text('pay bills'), findsOneWidget);

    //
    // final checkboxFinder = find.byType(Checkbox);
    // var checkbox = tester.firstWidget<Checkbox>(checkboxFinder);
    // expect(checkbox.value, false);
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    // checkbox = tester.firstWidget<Checkbox>(checkboxFinder);
    // expect(checkbox.value, true);
  });
}
