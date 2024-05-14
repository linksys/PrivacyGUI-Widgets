import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linksys_widgets/widgets/input_field/ipv6_form_field.dart';

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

    testWidgets('Input is read only', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPv6FormField(
            controller: controller,
            octet1ReadOnly: true,
            octet2ReadOnly: true,
            octet3ReadOnly: true,
            octet4ReadOnly: true,
            octet5ReadOnly: true,
            octet6ReadOnly: true,
            octet7ReadOnly: true,
            octet8ReadOnly: true,
          ),
        ),
      );

      final firstInput = find.byType(TextField).first;
      expect(tester.widget<TextField>(firstInput).readOnly, isTrue);
      final secondInput = find.byType(TextField).at(1);
      expect(tester.widget<TextField>(secondInput).readOnly, isTrue);
      final thirdInput = find.byType(TextField).at(2);
      expect(tester.widget<TextField>(thirdInput).readOnly, isTrue);
      final fourthInput = find.byType(TextField).at(3);
      expect(tester.widget<TextField>(fourthInput).readOnly, isTrue);
      final fivethInput = find.byType(TextField).at(4);
      expect(tester.widget<TextField>(fivethInput).readOnly, isTrue);
      final sixthInput = find.byType(TextField).at(5);
      expect(tester.widget<TextField>(sixthInput).readOnly, isTrue);
      final seventhInput = find.byType(TextField).at(6);
      expect(tester.widget<TextField>(seventhInput).readOnly, isTrue);
      final eighthInput = find.byType(TextField).at(7);
      expect(tester.widget<TextField>(eighthInput).readOnly, isTrue);
    });
  });
}
