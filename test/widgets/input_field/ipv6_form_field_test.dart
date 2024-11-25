import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/input_field/ipv6_form_field.dart';

import '../../util.dart';

void main() {
  group('AppIPv6FormField', () {
    testWidgets('Renders correctly with header', (WidgetTester tester) async {
      final controller = TextEditingController();
      const headerText = 'Enter IP Address';
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            header: const Text(headerText),
            controller: controller,
          ),
        ),
      );
      final ipFormFieldFinder = find.byType(AppIPv6FormField);
      expect(
          find.descendant(
              of: ipFormFieldFinder, matching: find.text(headerText)),
          findsOneWidget);
    });

    testWidgets('Displays initial values', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            controller: controller,
          ),
        ),
      );

      expect(find.text(''), findsNWidgets(8));
    });

    testWidgets('Updates UI on user input', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            controller: controller,
          ),
        ),
      );
      await tester.enterText(find.byType(TextField).first, '1');
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(controller.text, '1:::::::');
    });

    testWidgets('Formats IP address correctly', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            controller: controller,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'ace0');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(1), 'ace1');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(2), 'ace2');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(3), 'ace3');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(4), 'ace4');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(5), 'ace5');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(6), 'ace6');
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(7), 'ace7');
      await tester.pump();
      expect(find.text('ace0'), findsOneWidget);
      expect(controller.text, 'ace0:ace1:ace2:ace3:ace4:ace5:ace6:ace7');
    });

    testWidgets('Enforces length limit', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            controller: controller,
          ),
        ),
      );

      final firstInput = find.byType(TextField).first;
      await tester.enterText(firstInput, '1234');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, '1234');
      await tester.enterText(firstInput, '1');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, '1');
      await tester.enterText(firstInput, '12345');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, 'ffff');
    });

    testWidgets('Input invalid chars', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            controller: controller,
          ),
        ),
      );

      final firstInput = find.byType(TextField).first;
      await tester.enterText(firstInput, 'a');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, 'a');
      await tester.enterText(firstInput, 'A');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, 'A');
      await tester.enterText(firstInput, '&');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, '');
      await tester.enterText(firstInput, 'V');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, '');
    });
  });
}
