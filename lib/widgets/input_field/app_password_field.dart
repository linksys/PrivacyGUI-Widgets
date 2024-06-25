import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/input_field/validator_widget.dart';

class AppPasswordField extends StatefulWidget {
  final String? headerText;
  final String? descriptionText;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? errorText;
  final bool withValidator;
  final List<String>? autofillHint;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final InputBorder border;

  /// Validations
  final void Function(bool isValid)? onValidationChanged;
  final List<Validation>? validations;
  final String? validationLabel;
  final Widget? validationInitIcon;
  final Widget? validationCheckedIcon;
  final Widget? validationUncheckedIcon;
  final Color? initColor;
  final Color? checkedColor;
  final Color? unCheckedColor;

  final bool autofocus;
  final bool readOnly;

  const AppPasswordField({
    super.key,
    this.headerText,
    this.descriptionText,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onFocusChanged,
    this.onValidationChanged,
    this.withValidator = false,
    this.errorText,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.validations,
    this.autofillHint,
    this.onSubmitted,
    this.textInputAction,
    this.border = const UnderlineInputBorder(),
    this.validationLabel,
    this.validationInitIcon,
    this.validationCheckedIcon,
    this.validationUncheckedIcon,
    this.autofocus = false,
    this.initColor,
    this.checkedColor,
    this.unCheckedColor,
    this.readOnly = false,
  });

  AppPasswordField.withValidator({
    super.key,
    this.headerText,
    this.descriptionText,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onFocusChanged,
    this.onValidationChanged,
    this.withValidator = true,
    this.errorText,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.validations,
    this.autofillHint,
    this.onSubmitted,
    this.textInputAction,
    this.border = const UnderlineInputBorder(),
    this.validationLabel,
    this.validationInitIcon,
    this.validationCheckedIcon,
    this.validationUncheckedIcon,
    this.autofocus = false,
    this.initColor,
    this.checkedColor,
    this.unCheckedColor,
    this.readOnly = false,
  }) : assert(validations != null && validations.isNotEmpty);

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          headerText: widget.headerText,
          descriptionText: widget.descriptionText,
          controller: widget.controller,
          hintText: widget.hintText,
          readOnly: widget.readOnly,
          onChanged: (value) {
            setState(() {});
            widget.onChanged?.call(value);
            widget.onValidationChanged
                ?.call(isValid(widget.validations ?? [], value));
          },
          onFocusChanged: widget.onFocusChanged,
          autofillHints: widget.autofillHint,
          secured: _isHidePassword,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: AppIconButton.noPadding(
            icon: _isHidePassword
                ? LinksysIcons.visibility
                : LinksysIcons.visibilityOff,
            onTap: () {
              setState(() {
                _isHidePassword = !_isHidePassword;
              });
            },
          ),
          suffixIconConstraints: widget.suffixIconConstraints,
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          border: widget.border,
          autofocus: widget.autofocus,
        ),
        if (widget.withValidator) const AppGap.large2(),
        if (widget.withValidator)
          AppValidatorWidget(
            validations: widget.validations ?? [],
            description: widget.validationLabel,
            textToValidate: widget.controller?.text ?? '',
            initIcon: widget.validationInitIcon,
            checkedIcon: widget.validationCheckedIcon,
            uncheckedIcon: widget.validationUncheckedIcon,
            initColor: widget.initColor,
            checkedColor: widget.checkedColor,
            unCheckedColor: widget.unCheckedColor,
          ),
      ],
    );
  }

  bool isValid(List<Validation> validations, String textToValidate) {
    for (Validation validation in validations) {
      if (!validation.validator.call(textToValidate)) {
        return false;
      }
    }
    return true;
  }

  void showHidePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }
}
