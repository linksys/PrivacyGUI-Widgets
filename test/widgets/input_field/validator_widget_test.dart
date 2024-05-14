import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linksys_widgets/icons/linksys_icons.dart';
import 'package:linksys_widgets/theme/custom_theme.dart';
import 'package:linksys_widgets/widgets/input_field/validator_widget.dart';

import '../../util.dart';

void main() {
  group('AppValidatorWidget', () {});
  testWidgets('Test AppValidatorWidget display correct text', (tester) async {
    final mockValidations = [
      Validation(
        description: 'At least 10 characters',
        validator: (text) => true,
      ),
      Validation(
        description: 'Upper and lowercase letters',
        validator: (text) => true,
      ),
      Validation(
        description: '1 number',
        validator: (text) => true,
      ),
      Validation(
        description: '1 special character',
        validator: (text) => false,
      ),
    ];
    await tester.pumpWidget(testableMaterialWidget(
        child: AppValidatorWidget(
            description: 'new password',
            validations: mockValidations,
            textToValidate: 'test')));

    expect(find.text('new password'), findsOneWidget);

    expect(find.text('At least 10 characters'), findsOneWidget);
    expect(find.text('Upper and lowercase letters'), findsOneWidget);
    expect(find.text('1 number'), findsOneWidget);
    expect(find.text('1 special character'), findsOneWidget);
  });

  testWidgets('Test AppValidatorWidget display correct validation status',
      (tester) async {
    final mockValidations = [
      Validation(
        description: 'At least 10 characters',
        validator: (text) => true,
      ),
      Validation(
        description: 'Upper and lowercase letters',
        validator: (text) => false,
      ),
      Validation(
        description: '1 number',
        validator: (text) => true,
      ),
      Validation(
        description: '1 special character',
        validator: (text) => false,
      ),
    ];
    await tester.pumpWidget(testableMaterialWidget(
        child: AppValidatorWidget(
            description: 'new password',
            validations: mockValidations,
            textToValidate: 'test')));

    BuildContext context = tester.element(find.byType(AppValidatorWidget));

    expect(find.byIcon(LinksysIcons.check),
        findsNWidgets(2));
    expect(find.byIcon(LinksysIcons.close),
        findsNWidgets(2));
  });

  testWidgets('Test AppValidatorWidget validation', (tester) async {
    final mockValidations = [
      Validation(
        description: 'At least 10 characters',
        validator: (text) => text.length >= 10,
      ),
      Validation(
        description: 'Upper and lowercase letters',
        validator: (text) =>
            text.toLowerCase() != text && text.toUpperCase() != text,
      ),
    ];
    await tester.pumpWidget(testableMaterialWidget(
        child: AppValidatorWidget(
            description: 'new password',
            validations: mockValidations,
            textToValidate: 'test')));

    BuildContext context = tester.element(find.byType(AppValidatorWidget));

    expect(find.byIcon(LinksysIcons.close),
        findsNWidgets(2));
  });

  testWidgets('Test AppValidatorWidget custom checked image', (tester) async {
    final mockValidations = [
      Validation(
        description: 'At least 10 characters',
        validator: (text) => text.length >= 10,
      ),
      Validation(
        description: 'Upper and lowercase letters',
        validator: (text) =>
            text.toLowerCase() != text && text.toUpperCase() != text,
      ),
    ];
    const customChecked = Icon(Icons.check);
    await tester.pumpWidget(testableMaterialWidget(
        child: AppValidatorWidget(
      description: 'new password',
      validations: mockValidations,
      textToValidate: 'ThisIsTestPassword',
      checkedIcon: customChecked,
    )));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Icon && widget.icon == Icons.check),
        findsNWidgets(2));
  });

  testWidgets('Test AppValidatorWidget custom unchecked image', (tester) async {
    final mockValidations = [
      Validation(
        description: 'At least 10 characters',
        validator: (text) => text.length >= 10,
      ),
      Validation(
        description: 'Upper and lowercase letters',
        validator: (text) =>
            text.toLowerCase() != text && text.toUpperCase() != text,
      ),
    ];
    const customUnchecked = Icon(Icons.circle);
    await tester.pumpWidget(testableMaterialWidget(
        child: AppValidatorWidget(
      description: 'new password',
      validations: mockValidations,
      textToValidate: 'password',
      uncheckedIcon: customUnchecked,
    )));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Icon && widget.icon == Icons.circle),
        findsNWidgets(2));
  });
}
