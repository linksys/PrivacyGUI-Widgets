import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    this.text,
    this.isError = false,
    this.tristate = false,
    this.onChanged,
    this.semanticLabel,
  });

  final bool? value;
  final bool tristate;
  final bool isError;
  final String? text;
  final void Function(bool?)? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          semanticLabel: '$semanticLabel checkbox',
          isError: isError,
          tristate: tristate,
          onChanged: onChanged,
        ),
        ..._buildText(text, onChanged != null),
      ],
    );
  }

  List<Widget> _buildText(String? text, bool enabled) {
    if (text != null) {
      final textWidget = AppText.bodyMedium(text);
      return [const AppGap.small3(), Flexible(child: textWidget)];
    } else {
      return [];
    }
  }
}
