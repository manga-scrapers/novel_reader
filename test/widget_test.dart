// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child ui in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/main.dart';

void main() {
  testWidgets('Search screen appbar and home screen appbar tests',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Favorites page
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Tap the 'search' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // Verify that our search screen shows
    expect(find.text('Search'), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pump();

    // Favorites page
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
