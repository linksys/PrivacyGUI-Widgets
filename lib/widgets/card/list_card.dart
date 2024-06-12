import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';

class AppListCard extends StatelessWidget {
  const AppListCard({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.showBorder = true,
    this.padding,
    this.onTap,
    this.color,
    this.borderColor,
    this.crossAxisAlignment,
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final Widget? description;
  final VoidCallback? onTap;
  final bool showBorder;
  final EdgeInsets? padding;
  final Color? color;
  final Color? borderColor;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      showBorder: showBorder,
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onTap: onTap,
      color: color,
      borderColor: borderColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[leading!, const AppGap.regular()],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (description != null) ...[
                  const AppGap.small(),
                  description!,
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!
        ],
      ),
    );
  }
}
