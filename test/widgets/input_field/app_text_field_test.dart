import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

import '../../util.dart';

void main() {
  group('AppTextField', () {
    testWidgets('Text prefix icon display properly', (tester) async {
      const custom = Icon(Icons.search);
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        prefixIcon: custom,
      )));

      expect(find.byIcon(Icons.search), findsOneWidget);
    });
    testWidgets('Text prefix icon display properly', (tester) async {
      const custom = Icon(Icons.search);
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        suffixIcon: custom,
      )));

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('Text hint display properly', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        hintText: 'This is a hint',
      )));

      expect(find.text('This is a hint'), findsOneWidget);
    });

    testWidgets('Text error display properly', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        errorText: 'This is an error',
      )));
      final errorFinder = find.text('This is an error');

      BuildContext context = tester.element(errorFinder);
      expect(errorFinder, findsOneWidget);
      final errorWidget = tester.widget<Text>(errorFinder);
      expect(errorWidget.style?.color, Theme.of(context).colorScheme.error);
    });

    testWidgets('Text field focusable', (tester) async {
      bool? isFocus;
      await tester.pumpWidget(testableMaterialWidget(child: AppTextField(
        onFocusChanged: (value) {
          isFocus = value;
        },
      )));
      final textFieldFinder = find.byType(TextField);

      expect(textFieldFinder, findsOneWidget);
      await tester.tap(textFieldFinder);
      expect(isFocus, isNotNull);
    });

    testWidgets('Text field with description', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        descriptionText: 'description here',
      )));

      expect(find.text('description here'), findsOneWidget);
    });

    testWidgets('Text field is secured', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        secured: true,
      )));
      final textFieldFinder = find.byType(TextField);
      expect(tester.widget<TextField>(textFieldFinder).obscureText, isTrue);
    });

    testWidgets('Text field is read only', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppTextField(
        readOnly: true,
      )));
      final textFieldFinder = find.byType(TextField);
      expect(tester.widget<TextField>(textFieldFinder).readOnly, isTrue);
    });
  });
}
