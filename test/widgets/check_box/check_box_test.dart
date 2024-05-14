import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:privacygui_widgets/widgets/check_box/check_box.dart';

import '../../util.dart';

void main() {
  group('AppCheckbox', () {
    testWidgets('AppCheckbox displays correctly', (WidgetTester tester) async {
      // Pump the widget with initial values
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppCheckbox(value: true),
        ),
      );

      // Find the checkbox and text elements
      final checkboxFinder = find.byType(Checkbox);
      final textFinder = find.byType(Text);

      // Verify checkbox state and tristate
      expect(tester.firstWidget<Checkbox>(checkboxFinder).value, true);
      // (Optional) Check tristate if applicable

      // Verify text label
      expect(textFinder, findsNothing); // No text initially
    });
    testWidgets('AppCheckbox with text displays correctly',
        (WidgetTester tester) async {
      // Pump the widget with initial values
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppCheckbox(
            value: true,
            text: 'label 1',
          ),
        ),
      );

      // Find the checkbox and text elements
      final checkboxFinder = find.byType(Checkbox);
      final textFinder = find.byType(Text);

      final BuildContext context = tester.element(textFinder);

      // Verify checkbox state and tristate
      expect(tester.firstWidget<Checkbox>(checkboxFinder).value, true);

      // Verify text label
      expect(tester.firstWidget<Text>(textFinder).data, 'label 1');
      // Verify text style
      expect(tester.firstWidget<Text>(textFinder).style,
          Theme.of(context).textTheme.bodyMedium);
    });

    testWidgets('AppCheckbox calls onChanged on tap',
        (WidgetTester tester) async {
      bool? changedValue;
      // Pump the widget with initial values
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppCheckbox(
            value: false,
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(changedValue, isNull); // Initially unchanged

      await tester.tap(checkboxFinder);
      await tester.pump();

      expect(changedValue, true);
    });

    testWidgets('AppCheckbox calls onChanged on uncheck',
        (WidgetTester tester) async {
      bool? changedValue;
      // Pump the widget with initial values
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppCheckbox(
            value: true,
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(changedValue, isNull); // Initially unchanged

      await tester.tap(checkboxFinder);
      await tester.pump();

      expect(changedValue, false);
    });

    testWidgets('AppCheckbox is disabled when value is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppCheckbox(value: false),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      // Verify the checkbox can not interactive when onChanged is null
      expect(
          (tester.state(checkboxFinder) as ToggleableStateMixin).isInteractive,
          false);
    });

    testWidgets('AppCheckbox shows gap with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppCheckbox(
            value: false,
            text: 'Label 1',
          ),
        ),
      );

      final gapFinder = find.byType(Gap);

      expect(gapFinder, findsOneWidget);
    });

    testWidgets('AppCheckbox hides gap without text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppCheckbox(value: false),
        ),
      );

      final gapFinder = find.byType(Gap);

      expect(gapFinder, findsNothing);
    });

    testWidgets('AppCheckbox shows error styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppCheckbox(
            value: false,
            isError: true,
          ),
        ),
      );
      final checkboxFinder = find.byType(Checkbox);
      // Check for specific error style properties (color, border, etc.)
      final checkbox = tester.widget<Checkbox>(checkboxFinder);
      expect(checkbox.isError, isTrue);
      // nothing to test because we're using default material checkbox
    });
  });
}
