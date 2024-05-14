import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/custom_theme.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/input_field/validator_widget.dart';

import '../../util.dart';

void main() {
  group('AppPasswordTextField', () {
    testWidgets('app password field header display', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
      )));

      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('app password field description display', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
      )));

      expect(find.text('Input your password'), findsOneWidget);
    });

    testWidgets('app password field hint display', (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
      )));

      expect(find.text('Password Hint'), findsOneWidget);
    });
    testWidgets('app password field has show password icon as default',
        (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
      )));
      expect(find.byIcon(LinksysIcons.visibility), findsOneWidget);
    });

    testWidgets(
        'app password field display hide password by tapping show password',
        (tester) async {
      await tester.pumpWidget(testableMaterialWidget(
          child: const AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
      )));
      BuildContext context = tester.element(find.byType(AppPasswordField));
      await tester.tap(find.byIcon(LinksysIcons.visibility));
      await tester.pumpAndSettle();
      expect(find.byIcon(LinksysIcons.visibilityOff), findsOneWidget);
    });

    testWidgets('app password field verify onChanged callback', (tester) async {
      String verifyChanged = '';
      await tester.pumpWidget(testableMaterialWidget(
          child: AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
        onChanged: (value) {
          verifyChanged = value;
        },
      )));
      final inputFinder = find.byType(TextField);
      await tester.enterText(inputFinder, 'password123!');

      expect(find.text('password123!'), findsOneWidget);
      expect(verifyChanged, 'password123!');
    });

    testWidgets('app password field verify onFocusChanged callback',
        (tester) async {
      bool? verifyChanged;
      await tester.pumpWidget(testableMaterialWidget(
          child: AppPasswordField(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
        onFocusChanged: (value) {
          verifyChanged = value;
        },
      )));
      final inputFinder = find.byType(TextField);
      await tester.tap(inputFinder);

      expect(verifyChanged, isTrue);
    });

    testWidgets('app password field verify validation display', (tester) async {
      final validations = [
        Validation(
          description: 'length >= 10',
          validator: (text) => text.length >= 10,
        ),
        Validation(
          description: 'includes upper and lower case',
          validator: (text) =>
              text != text.toLowerCase() && text != text.toUpperCase(),
        )
      ];
      await tester.pumpWidget(testableMaterialWidget(
          child: AppPasswordField.withValidator(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
        validationLabel: 'The password must have',
        validations: validations,
      )));
      BuildContext context = tester.element(find.byType(AppPasswordField));

      expect(find.text('The password must have'), findsOneWidget);
      expect(find.text('length >= 10'), findsOneWidget);
      expect(find.text('includes upper and lower case'), findsOneWidget);
      expect(find.byIcon(LinksysIcons.infoCircle), findsNWidgets(2));
    });

    testWidgets('app password field verify validation changed callback',
        (tester) async {
      bool? verifyIsValid;

      final validations = [
        Validation(
          description: 'length >= 10',
          validator: (text) => text.length >= 10,
        ),
        Validation(
          description: 'includes upper and lower case',
          validator: (text) =>
              text != text.toLowerCase() && text != text.toUpperCase(),
        )
      ];
      await tester.pumpWidget(testableMaterialWidget(
          child: AppPasswordField.withValidator(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
        validationLabel: 'The password must have',
        validations: validations,
        onValidationChanged: (isValid) {
          verifyIsValid = isValid;
        },
      )));

      final textFieldFinder = find.byType(TextField);
      await tester.enterText(textFieldFinder, 'password');
      expect(verifyIsValid, isFalse);
      await tester.enterText(textFieldFinder, 'AValidPassword');
      expect(verifyIsValid, isTrue);
    });

    testWidgets('app password field verify validation display with input',
        (tester) async {
      final validations = [
        Validation(
          description: 'length >= 10',
          validator: (text) => text.length >= 10,
        ),
        Validation(
          description: 'includes upper and lower case',
          validator: (text) =>
              text != text.toLowerCase() && text != text.toUpperCase(),
        )
      ];
      await tester.pumpWidget(testableMaterialWidget(
          child: AppPasswordField.withValidator(
        headerText: 'Password',
        descriptionText: 'Input your password',
        hintText: 'Password Hint',
        validationLabel: 'The password must have',
        validations: validations,
        onValidationChanged: (isValid) {},
        controller: TextEditingController(),
      )));
      BuildContext context = tester.element(find.byType(AppPasswordField));

      expect(find.byIcon(LinksysIcons.infoCircle), findsNWidgets(2));

      final textFieldFinder = find.byType(TextField);
      await tester.enterText(textFieldFinder, 'password123');
      await tester.pumpAndSettle();
      expect(find.byIcon(LinksysIcons.close), findsNWidgets(1));
      expect(find.byIcon(LinksysIcons.check), findsNWidgets(1));
      await tester.enterText(textFieldFinder, 'AValidPassword');
      await tester.pumpAndSettle();

      expect(
          find.image(CustomTheme.of(context).images.iconEllipse), findsNothing);
      expect(find.byIcon(LinksysIcons.check), findsNWidgets(2));
    });
  });
}
