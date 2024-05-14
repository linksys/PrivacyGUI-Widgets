import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linksys_widgets/widgets/radios/radio_list.dart';

import '../../util.dart';

void main() {
  group('AppRadioList', () {
    testWidgets('renders radio buttons and selects initial value',
        (WidgetTester tester) async {
      // Create sample items
      final items = [
        AppRadioListItem(title: 'Option 1', value: 1),
        AppRadioListItem(title: 'Option 2', value: 2),
      ];

      // Build the widget with initial selection
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppRadioList(
            items: items,
            initial: 2,
          ),
        ),
      );

      // Find radio buttons and verify their states
      final radio1 = find
          .byWidgetPredicate((widget) => widget is Radio && widget.value == 1);
      final radio2 = find
          .byWidgetPredicate((widget) => widget is Radio && widget.value == 2);

      expect((radio1.evaluate().single.widget as Radio).groupValue, 2);
      expect((radio2.evaluate().single.widget as Radio).groupValue, 2);

      // Tap on the first radio button
      await tester.tap(radio1);
      await tester.pump();

      // Verify selection changed
      expect(
          (radio1.evaluate().single.widget as Radio).groupValue, 1); // Selected
      expect((radio2.evaluate().single.widget as Radio).groupValue,
          1); // Not selected
    });

    testWidgets('calls onChanged callback on tap', (WidgetTester tester) async {
      // Setup mock callback
      int? selectedIndex;
      int? selectedValue;
      onChanged(int index, int? value) {
        selectedIndex = index;
        selectedValue = value;
      }

      // Create sample items
      final items = [
        AppRadioListItem(title: 'Option 1', value: 1),
        AppRadioListItem(title: 'Option 2', value: 2),
      ];

      // Build the widget
      // Build the widget with initial selection
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppRadioList(
            items: items,
            onChanged: onChanged,
          ),
        ),
      );

      // Tap on the second radio button
      await tester.tap(find
          .byWidgetPredicate((widget) => widget is Radio && widget.value == 2));
      await tester.pump();

      // Verify callback was called with correct values
      expect(selectedIndex, 1);
      expect(selectedValue, 2);
    });

  });
}
