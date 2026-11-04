// Tests for every part of the app. Run with: flutter test
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:globly/main.dart';

Finder _field(int index) => find.byType(TextFormField).at(index);
Finder _button(String text) => find.widgetWithText(FilledButton, text);

void main() {
  group('Part 1: authentication/registration frontend', () {
    testWidgets('empty fields are rejected', (t) async {
      await t.pumpWidget(const GloblyApp());
      await t.tap(_button('Ievadīt'));
      await t.pump();
      expect(find.text('Obligāts lauks'), findsNWidgets(2));
    });

    testWidgets('the toggle switches between login and registration', (t) async {
      await t.pumpWidget(const GloblyApp());
      await t.tap(find.text('Reģistrēties'));
      await t.pump();
      expect(_button('Reģistrēties'), findsOneWidget);
      await t.tap(find.text('Autentificēties'));
      await t.pump();
      expect(_button('Ievadīt'), findsOneWidget);
    });

    testWidgets('logging in opens the home screen, logging out returns', (t) async {
      await t.pumpWidget(const GloblyApp());
      await t.enterText(_field(0), 'anna');
      await t.enterText(_field(1), 'parole');
      await t.tap(_button('Ievadīt'));
      await t.pumpAndSettle();
      expect(find.text('anna'), findsOneWidget);
      expect(find.text('Publicējumi parādīsies šeit.'), findsOneWidget);

      await t.tap(find.byTooltip('Iziet'));
      await t.pumpAndSettle();
      expect(_button('Ievadīt'), findsOneWidget);
    });
  });
}
