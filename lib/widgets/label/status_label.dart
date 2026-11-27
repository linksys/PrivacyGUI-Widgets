import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppStatusLabel extends StatelessWidget {
  final String label;
  final String offLabel;
  final bool isOff;
  final Color? onColor;
  final Color? offColor;
  final String? identifier;

  const AppStatusLabel({
    super.key,
    this.label = 'On',
    this.offLabel = 'Off',
    this.isOff = false,
    this.onColor,
    this.offColor,
    this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    final color = isOff
        ? (offColor ?? Theme.of(context).colorScheme.outline)
        : (onColor ?? Theme.of(context).colorSchemeExt.green);
    return IdentifierSemantics(
      identifier: identifier,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            LinksysIcons.circle,
            color: color,
            size: 16,
          ),
          const AppGap.small2(),
          AppText.bodyMedium(
            isOff ? offLabel : label,
            color: color,
          )
        ],
      ),
    );
  }
}
