import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privacygui_widgets/widgets/input_field/input_formatters.dart';
import 'package:privacygui_widgets/widgets/input_field/text_input_field.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.controller,
    this.headerText,
    this.hintText,
    this.errorText,
    this.descriptionText,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.onFocusChanged,
    this.secured = false,
    this.readOnly = false,
    this.enable = true,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.autofillHints,
    this.onSubmitted,
    this.textInputAction,
    this.border = const UnderlineInputBorder(),
    this.inputFormatters,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands,
  }) : super(key: key);

  const AppTextField.outline({
    Key? key,
    this.controller,
    this.headerText,
    this.hintText,
    this.errorText,
    this.descriptionText,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.onFocusChanged,
    this.secured = false,
    this.readOnly = false,
    this.enable = true,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.autofillHints,
    this.onSubmitted,
    this.textInputAction,
    this.inputFormatters,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands,
  })  : border = const OutlineInputBorder(),
        super(key: key);

  factory AppTextField.macAddress({
    Key? key,
    TextEditingController? controller,
    String? headerText,
    String? hintText,
    String? errorText,
    String? descriptionText,
    TextInputType inputType = TextInputType.text,
    void Function(String text)? onChanged,
    void Function(bool hasFocus)? onFocusChanged,
    bool secured = false,
    bool readOnly = false,
    bool enable = true,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    List<String>? autofillHints,
    void Function(String)? onSubmitted,
    TextInputAction? textInputAction,
    InputBorder border = const UnderlineInputBorder(),
    bool autofocus = false,
  }) =>
      AppTextField(
        controller: controller,
        headerText: headerText,
        hintText: hintText,
        errorText: errorText,
        descriptionText: descriptionText,
        inputType: inputType,
        onChanged: onChanged,
        onFocusChanged: onFocusChanged,
        secured: secured,
        readOnly: readOnly,
        enable: enable,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        autofillHints: autofillHints,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        border: border,
        inputFormatters: [
          // allow only digits
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]')),
          // custom class to format entered data from textField
          MacAddressFormatter(),
          // restrict user to enter max 16 characters
          LengthLimitingTextInputFormatter(17)
        ],
        autofocus: autofocus,
      );

  factory AppTextField.minMaxNumber({
    Key? key,
    TextEditingController? controller,
    String? headerText,
    String? hintText,
    String? errorText,
    String? descriptionText,
    TextInputType inputType = TextInputType.text,
    void Function(String text)? onChanged,
    void Function(bool hasFocus)? onFocusChanged,
    bool secured = false,
    bool readOnly = false,
    bool enable = true,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    List<String>? autofillHints,
    void Function(String)? onSubmitted,
    TextInputAction? textInputAction,
    InputBorder border = const UnderlineInputBorder(),
    int min = 0,
    required int max,
    bool autofocus = false,
    bool acceptEmpty = false,
  }) =>
      AppTextField(
        controller: controller,
        headerText: headerText,
        hintText: hintText,
        errorText: errorText,
        descriptionText: descriptionText,
        inputType: TextInputType.number,
        onChanged: onChanged,
        onFocusChanged: onFocusChanged,
        secured: secured,
        readOnly: readOnly,
        enable: enable,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        autofillHints: autofillHints,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        border: border,
        inputFormatters: [
          // allow only digits
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          // custom class to format entered data from textField
          MinMaxNumberFormatter(min: min, max: max, acceptEmpty: acceptEmpty),
        ],
        autofocus: autofocus,
      );

  final TextEditingController? controller;
  final String? headerText;
  final String? hintText;
  final String? errorText;
  final String? descriptionText;
  final TextInputType inputType;
  final void Function(String text)? onChanged;
  final void Function(bool hasFocus)? onFocusChanged;
  final bool secured;
  final bool readOnly;
  final bool enable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<String>? autofillHints;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final InputBorder border;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextInputField(
      controller: widget.controller,
      hintText: widget.hintText,
      inputType: widget.inputType,
      onChanged: widget.onChanged,
      onFocusChanged: widget.onFocusChanged,
      secured: widget.secured,
      readOnly: widget.readOnly,
      enable: widget.enable,
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: widget.prefixIconConstraints,
      suffixIcon: widget.suffixIcon,
      suffixIconConstraints: widget.suffixIconConstraints,
      autofillHints: widget.autofillHints,
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      label: widget.headerText,
      errorText: widget.errorText,
      helperText: widget.descriptionText,
      border: widget.border,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
    );
  }
}
