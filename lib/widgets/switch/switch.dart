import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.showIcon = false,
    this.checkedIcon,
    this.uncheckIcon,
    this.identifier,
    this.semanticLabel,
  });

  const AppSwitch.withIcon({
    super.key,
    required this.value,
    this.onChanged,
    this.checkedIcon,
    this.uncheckIcon,
    this.identifier,
    this.semanticLabel,
  }) : showIcon = true;

  final bool showIcon;
  final bool value;
  final void Function(bool)? onChanged;
  final Icon? checkedIcon;
  final Icon? uncheckIcon;
  final String? identifier;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final thumbIcon = showIcon
        ? () {
            return MaterialStateProperty.resolveWith<Icon?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return checkedIcon ?? const Icon(Icons.check);
                }
                return uncheckIcon ?? const Icon(Icons.close);
              },
            );
          }()
        : null;
    if (kIsWeb) {
      return Semantics(
        identifier: identifier != null ? '$identifier-switch' : null,
        label: semanticLabel != null ? '$semanticLabel switch' : null,
        child: Switch(
          value: value,
          onChanged: onChanged,
          thumbIcon: thumbIcon,
        ),
      );
    } else {
      return Semantics(
        identifier: identifier != null ? '$identifier-switch' : null,
        label: semanticLabel != null ? '$semanticLabel switch' : null,
        child: Switch(
          value: value,
          onChanged: onChanged,
          thumbIcon: thumbIcon,
        ),
      );
    }
  }
}
