import 'package:flutter/material.dart';
import 'package:linksys_widgets/icons/linksys_icons.dart';
import 'package:linksys_widgets/theme/_theme.dart';
import 'package:linksys_widgets/widgets/base/gap.dart';
import 'package:linksys_widgets/widgets/text/app_text.dart';

class AppValidatorWidget extends StatelessWidget {
  final List<Validation> validations;
  final String? description;
  final String textToValidate;
  final Widget? checkedIcon;
  final Widget? uncheckedIcon;
  final Widget? initIcon;
  final double? iconSize;
  final Color? initColor;
  final Color? checkedColor;
  final Color? unCheckedColor;

  AppValidatorWidget({
    super.key,
    required this.validations,
    this.description,
    required this.textToValidate,
    this.initIcon,
    this.checkedIcon,
    this.uncheckedIcon,
    this.iconSize = 16,
    this.initColor,
    this.checkedColor,
    this.unCheckedColor,
  }) : assert(validations.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description != null)
          AppText.bodyMedium(
            description!,
          ),
        const AppGap.small(),
        ...List.generate(
          validations.length,
          (index) {
            return Row(
              children: [
                textToValidate.isEmpty
                    ? _initIcon(context)
                    : validations[index].validator.call(textToValidate)
                        ? _checked(context)
                        : _unChecked(context),
                const AppGap.semiSmall(),
                AppText.bodyMedium(
                  validations[index].description,
                  color: textToValidate.isEmpty
                      ? _initColor(context)
                      : validations[index].validator.call(textToValidate)
                          ? _checkedColor(context)
                          : _unCheckedColor(context),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Color? _initColor(BuildContext context) =>
      initColor ?? Theme.of(context).colorScheme.onSurfaceVariant;
  Color? _checkedColor(BuildContext context) =>
      initColor ?? Theme.of(context).colorSchemeExt.green;

  Color? _unCheckedColor(BuildContext context) =>
      initColor ?? Theme.of(context).colorScheme.error;

  Widget _initIcon(BuildContext context) =>
      initIcon ??
      Icon(
        LinksysIcons.infoCircle,
        color: _initColor(context),
        size: iconSize ?? 16,
      );
  Widget _checked(BuildContext context) =>
      checkedIcon ??
      Icon(
        LinksysIcons.check,
        color: _checkedColor(context),
        size: iconSize ?? 16,
      );

  Widget _unChecked(BuildContext context) =>
      uncheckedIcon ??
      Icon(
        LinksysIcons.close,
        color: _unCheckedColor(context),
        size: iconSize ?? 16,
      );
}

class Validation {
  final String description;
  final bool Function(String text) validator;

  Validation({required this.description, required this.validator});
}
