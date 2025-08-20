import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class AppLabelText extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? color;
  final Color? borderColor;

  const AppLabelText({
    Key? key,
    required this.label,
    this.labelColor,
    this.color,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.outline.withAlpha(0x10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: AppText.labelLarge(label, color: labelColor),
      ),
    );
  }
}
