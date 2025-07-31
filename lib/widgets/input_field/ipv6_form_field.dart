import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppIPv6FormField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final String? Function(String?)? validator;
  final String? title;
  final String? forceErrorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder border;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;
  final String? identifier;
  final String? semanticLabel;
  final TextAlign textAlign;
  final FocusNode? focusNode;

  const AppIPv6FormField({
    super.key,
    this.controller,
    this.onChanged,
    this.onFocusChanged,
    this.validator,
    this.title,
    this.forceErrorText,
    this.prefixIcon,
    this.suffixIcon,
    this.border = const UnderlineInputBorder(),
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.identifier,
    this.semanticLabel,
    this.textAlign = TextAlign.start,
    this.focusNode,
  });

  @override
  State<AppIPv6FormField> createState() => _AppIPv6FormFieldState();
}

class _AppIPv6FormFieldState extends State<AppIPv6FormField> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    }
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChanged?.call(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final border = widget.border.copyWith(
        borderSide: widget.border.borderSide
            .copyWith(color: Theme.of(context).colorScheme.outline));
    return Semantics(
      identifier: widget.identifier != null
          ? '${widget.identifier}-ipv6FormField'
          : null,
      label: widget.semanticLabel != null
          ? '${widget.semanticLabel} IPv6 Form Field'
          : null,
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.title,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
              borderSide: border.borderSide
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
          hoverColor: Theme.of(context).colorScheme.onSurface,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
        readOnly: widget.readOnly,
        textAlign: widget.textAlign,
        inputFormatters: [
          // allow only digits
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F:]')),
        ],
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        forceErrorText: widget.forceErrorText,
      ),
    );
  }

}
