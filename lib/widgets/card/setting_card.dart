import 'package:flutter/material.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';
import 'package:linksys_widgets/widgets/card/list_card.dart';

class AppSettingCard extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final bool showBorder;
  final EdgeInsets? padding;
  final Color? color;
  final Color? borderColor;

  const AppSettingCard({
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
  });

  factory AppSettingCard.noBorder({
    Widget? leading,
    Widget? trailing,
    required String title,
    String? description,
    VoidCallback? onTap,
    EdgeInsets? padding,
    Color? color,
    Color? borderColor,
  }) {
    return AppSettingCard(
      leading: leading,
      trailing: trailing,
      title: title,
      description: description,
      showBorder: false,
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onTap: onTap,
      color: color,
      borderColor: borderColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleWidget = description != null
        ? AppText.bodyMedium(title)
        : AppText.labelLarge(title);
    final desc = description;
    final descWidget = desc != null ? AppText.labelLarge(desc) : null;
    return AppListCard(
      leading: leading,
      trailing: trailing,
      title: titleWidget,
      description: descWidget,
      showBorder: showBorder,
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onTap: onTap,
      color: color,
    );
  }
}
