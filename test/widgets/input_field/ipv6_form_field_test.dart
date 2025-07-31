import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/input_field/ipv6_form_field.dart';

void main() {
  group('AppIPv6FormField', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(),
          ),
        ),
      );

      expect(find.byType(AppIPv6FormField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered',
        (WidgetTester tester) async {
      String? changedValue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '2001:db8::');
      await tester.pump();

      expect(changedValue, '2001:db8::');
    });

    testWidgets('calls onFocusChanged when focus changes',
        (WidgetTester tester) async {
      bool? hasFocus;
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppIPv6FormField(
                  focusNode: focusNode,
                  onFocusChanged: (value) {
                    hasFocus = value;
                  },
                ),
                TextFormField(),
              ],
            ),
          ),
        ),
      );

      final textField = find.byType(AppIPv6FormField);
      await tester.tap(textField);
      await tester.pump();
      expect(hasFocus, isTrue);

      await tester.tap(find.byType(TextFormField).last);
      await tester.pump();
      expect(hasFocus, isFalse);
    });

    testWidgets('shows validator error', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppIPv6FormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Error';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('shows forceErrorText', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              forceErrorText: 'Forced Error',
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Forced Error'), findsOneWidget);
    });

    testWidgets('displays prefix and suffix icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              prefixIcon: Icon(Icons.add),
              suffixIcon: Icon(Icons.remove),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('is readOnly when specified', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              readOnly: true,
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.readOnly, isTrue);
    });

    testWidgets('filters input according to IPv6 format', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '2001:db8::g');
      await tester.pump();

      expect(controller.text, '2001:db8::');
    });

    testWidgets('has correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              identifier: 'my-ipv6',
              semanticLabel: 'My IPv6',
            ),
          ),
        ),
      );

      final semantics = find.bySemanticsLabel('My IPv6 IPv6 Form Field');
      expect(semantics, findsOneWidget);
    });

    testWidgets('aligns text correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIPv6FormField(
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.textAlign, TextAlign.center);
    });
  });
}