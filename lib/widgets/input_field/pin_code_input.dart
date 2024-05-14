import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinCodeInput extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String?)? onCompleted;
  final int length;
  final bool enabled;
  final TextEditingController? controller;

  const AppPinCodeInput({
    super.key,
    this.onChanged,
    this.onCompleted,
    required this.length,
    this.enabled = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
        key: const Key('otp_input_view_input_field_code'),
        controller: controller,
        onChanged: onChanged ?? (String? value) {},
        onCompleted: (String? value) {},
        length: length,
        enabled: enabled,
        appContext: context,
        keyboardType: TextInputType.number,
        hintCharacter: '-',
        enableActiveFill: true,
        autoDisposeControllers: false,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          // fieldHeight: 102,
          // fieldWidth: 88,
          activeFillColor: Theme.of(context).colorScheme.primaryContainer,
          inactiveFillColor: Theme.of(context).colorScheme.primaryContainer,
          selectedFillColor: Theme.of(context).colorScheme.primaryContainer,
          inactiveColor: Theme.of(context).colorScheme.primaryContainer,
          activeColor: Theme.of(context).colorScheme.primaryContainer,
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
        ));
  }
}
