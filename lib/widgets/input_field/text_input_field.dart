import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    Key? key,
    this.controller,
    this.hintText,
    this.label,
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
    this.errorText,
    this.helperText,
    this.border = const UnderlineInputBorder(),
    this.inputFormatters,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType inputType;
  final void Function(String text)? onChanged;
  final void Function(bool hasFocus)? onFocusChanged;
  final bool secured;
  final bool readOnly;
  final bool enable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final List<String>? autofillHints;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final String? label;
  final String? errorText;
  final String? helperText;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool? expands;

  @override
  TextInputFieldState createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();

    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();

    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onChanged(String value) {
    widget.onChanged?.call(value);
  }

  void _onFocusChange() {
    widget.onFocusChanged?.call(_focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enable,
      readOnly: widget.readOnly,
      obscureText: widget.secured,
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        border: widget.border,
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        errorText: widget.errorText,
        helperText: widget.helperText,
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIconConstraints: widget.suffixIconConstraints,
      ),
      onChanged: _onChanged,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: widget.inputType,
      focusNode: _focus,
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus,
      maxLines: widget.secured ? 1 : widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands ?? false,
    );
  }
}
