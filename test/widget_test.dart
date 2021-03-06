// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/main.dart';

void main() {
  testWidgets('Add and remove todo test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('todo'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'todo');
    await tester.tap(find.text('OK'));
    await tester.pump();

    expect(find.text('todo'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('todo'), findsNothing);
  });
}
