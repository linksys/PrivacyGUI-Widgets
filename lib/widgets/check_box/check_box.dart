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
    this.explicitChildNodes = false,
    this.excludeSemantics = false,
    this.identifier,
    this.semanticLabel,
  });

  final bool? value;
  final bool tristate;
  final bool isError;
  final String? text;
  final void Function(bool?)? onChanged;
  final bool explicitChildNodes;
  final bool excludeSemantics;
  final String? identifier;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          explicitChildNodes: explicitChildNodes,
          excludeSemantics: excludeSemantics,
          identifier: identifier != null ? '$identifier-checkbox' : null,
          label: semanticLabel != null ? '$semanticLabel checkbox' : null,
          child: Checkbox(
            value: value,
            isError: isError,
            tristate: tristate,
            onChanged: onChanged,
          ),
        ),
        ..._buildText(text, onChanged != null),
      ],
    );
  }

  List<Widget> _buildText(String? text, bool enabled) {
    if (text != null) {
      final textWidget = AppText.bodyMedium(text, identifier: identifier);
      return [const AppGap.small3(), Flexible(child: textWidget)];
    } else {
      return [];
    }
  }
}
