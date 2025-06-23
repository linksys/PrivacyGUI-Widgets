import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class AppPinCodeInput extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onSubmitted;
  final int length;
  final bool enabled;
  final TextEditingController? controller;
  final String? identifier;
  final String? semanticLabel;
  final PinTheme? pinTheme;
  final double? size;

  const AppPinCodeInput({
    super.key,
    this.onChanged,
    this.onSubmitted,
    required this.length,
    this.enabled = true,
    this.controller,
    this.identifier,
    this.semanticLabel,
    this.pinTheme,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = pinTheme ??
        PinTheme(
          height: size ?? 56,
          width: size ?? 56,
          textStyle: Theme.of(context).textTheme.titleLarge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        );
    return Semantics(
      identifier: identifier,
      label: semanticLabel,
      child: Pinput(
        onChanged: onChanged,
        length: length,
        controller: controller,
        closeKeyboardWhenCompleted: false,
        autofocus: true,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyDecorationWith(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
