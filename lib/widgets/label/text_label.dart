import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';

class AppLabelText extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? color;
  final Color? borderColor;
  final String? identifier;

  const AppLabelText({
    Key? key,
    required this.label,
    this.labelColor,
    this.color,
    this.borderColor,
    this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdentifierSemantics(
      identifier: identifier,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.outline.withAlpha(0x10),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: AppText.labelLarge(label, color: labelColor),
        ),
      ),
    );
  }
}
