import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

import '../../util.dart';

void main() {
  group('AppSwitch', () {
    testWidgets('AppSwitch changes state on tap', (WidgetTester tester) async {
      bool switchValue = false;
      void onChanged(bool value) {
        switchValue = value;
      }

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppSwitch(
            value: switchValue,
            onChanged: onChanged,
          ),
        ),
      );

      // Find the switch
      final switchWidget = find.byType(AppSwitch);

      // Tap the switch
      await tester.tap(switchWidget);
      // Verify state change
      expect(switchValue, true);
    });
    testWidgets('Uses default checked icon', (tester) async {
      const customIcon = Icon(Icons.check);
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppSwitch(
            value: true,
            checkedIcon: customIcon,
            showIcon: true,
          ),
        ),
      );
      final switchWidget = find.byWidgetPredicate((widget) =>
          widget is Switch &&
          widget.thumbIcon?.resolve({MaterialState.selected})?.icon ==
              Icons.check);
      expect(switchWidget, findsOneWidget);
    });
    testWidgets('Uses default unchecked icon', (tester) async {
      const customIcon = Icon(Icons.close);
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppSwitch(
            value: true,
            uncheckIcon: customIcon,
            showIcon: true,
          ),
        ),
      );
      final switchWidget = find.byWidgetPredicate((widget) =>
          widget is Switch &&
          widget.thumbIcon?.resolve({})?.icon == Icons.close);
      expect(switchWidget, findsOneWidget);
    });
    testWidgets('Uses custom checked icon', (tester) async {
      const customIcon = Icon(Icons.star);
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppSwitch(
            value: true,
            checkedIcon: customIcon,
            showIcon: true,
          ),
        ),
      );
      final switchWidget = find.byWidgetPredicate((widget) =>
          widget is Switch &&
          widget.thumbIcon?.resolve({MaterialState.selected})?.icon ==
              Icons.star);
      expect(switchWidget, findsOneWidget);
    });
    testWidgets('Uses custom unchecked icon', (tester) async {
      const customIcon = Icon(Icons.lightbulb);
      await tester.pumpWidget(
        testableMaterialWidget(
          child: const AppSwitch(
            value: true,
            uncheckIcon: customIcon,
            showIcon: true,
          ),
        ),
      );
      final switchWidget = find.byWidgetPredicate((widget) =>
          widget is Switch &&
          widget.thumbIcon?.resolve({})?.icon == Icons.lightbulb);
      expect(switchWidget, findsOneWidget);
    });

    testWidgets('Uses custom unchecked icon but not showing icon',
        (tester) async {
      const customIcon = Icon(Icons.lightbulb);
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppSwitch(
            value: false,
            showIcon: false,
            uncheckIcon: customIcon,
            onChanged: (value) {},
          ),
        ),
      );
      final switchWidget = find.byWidgetPredicate(
          (widget) => widget is Switch && widget.thumbIcon == null);

      expect(switchWidget, findsOneWidget);
    });
  });
}
