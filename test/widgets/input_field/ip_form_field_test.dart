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
  });
}
