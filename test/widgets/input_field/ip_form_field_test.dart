import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/input_field/ip_form_field.dart';

import '../../util.dart';

void main() {
  group('AppIPFormField Test', () {
    testWidgets('Renders correctly with header', (WidgetTester tester) async {
      final controller = TextEditingController();
      const headerText = 'Enter IP Address';
      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPFormField(
            header: const Text(headerText),
            controller: controller,
          ),
        ),
      );
      final ipFormFieldFinder = find.byType(AppIPFormField);
      expect(
          find.descendant(
              of: ipFormFieldFinder, matching: find.text(headerText)),
          findsOneWidget);
    });

    testWidgets('Displays initial values', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPFormField(
            controller: controller,
          ),
        ),
      );

      expect(find.text(''), findsNWidgets(4));
    });

    testWidgets('Updates UI on user input', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPFormField(
            controller: controller,
          ),
        ),
      );
      await tester.enterText(find.text('').first, '1');
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(controller.text, '1...');
    });

    testWidgets('Formats IP address correctly', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPFormField(
            controller: controller,
          ),
        ),
      );

      await tester.enterText(find.text('').first, '123');
      await tester.pump();
      await tester.enterText(find.text('').first, '124');
      await tester.pump();
      await tester.enterText(find.text('').first, '125');
      await tester.pump();
      await tester.enterText(find.text('').first, '126');
      await tester.pump();
      expect(find.text('123'), findsOneWidget);
      expect(controller.text, '123.124.125.126');
    });

    testWidgets('Enforces length limit', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPFormField(
            controller: controller,
          ),
        ),
      );

      final firstInput = find.byType(TextField).first;
      await tester.enterText(firstInput, '1234');
      await tester.pump();
      // It should be the same value because the value is invalid.
      expect(tester.widget<TextField>(firstInput).controller?.text, '0');
      await tester.enterText(firstInput, '1');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, '1');
      await tester.enterText(firstInput, '1234');
      await tester.pump();
      expect(tester.widget<TextField>(firstInput).controller?.text, '0');
    });

    testWidgets('Input invalid chars', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        testableMaterialWidget(
          child: AppIPFormField(
            controller: controller,
          ),
        ),
      );

      final firstInput = find.byType(TextField).first;
      await tester.enterText(firstInput, 'a');
      await tester.pump();
      // It should be the same value because the value is invalid.
      expect(tester.widget<TextField>(firstInput).controller?.text, '');
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
          child: AppIPFormField(
            controller: controller,
            octet1ReadOnly: true,
            octet2ReadOnly: true,
            octet3ReadOnly: true,
            octet4ReadOnly: true,
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
    });
  });
}
