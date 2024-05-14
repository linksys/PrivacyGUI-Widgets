import 'package:flutter/material.dart';
import 'package:linksys_widgets/widgets/text/app_text.dart';

class AppTab extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final Widget? onSelectedIcon;
  final bool onSelected;
  final double? iconMargin;

  const AppTab({
    Key? key,
    this.title,
    this.icon,
    this.onSelectedIcon,
    this.onSelected = false,
    this.iconMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    final title = this.title;
    final icon = this.icon;
    final onSelectedIcon = this.onSelectedIcon;
    final iconMargin = this.iconMargin;

    if (onSelected && onSelectedIcon != null) {
      widgets.add(onSelectedIcon);
    } else if (icon != null) {
      widgets.add(icon);
    }
    if (iconMargin != null) {
      widgets.add(SizedBox(
        height: iconMargin,
      ));
    }
    if (title != null) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppText.labelMedium(
          title,
          color: onSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ));
    }
    return Column(
      children: widgets,
    );
  }

  AppTab copyWith({
    String? title,
    Widget? icon,
    Widget? onSelectedIcon,
    bool? onSelected,
    double? iconMargin,
  }) {
    return AppTab(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      onSelectedIcon: onSelectedIcon ?? this.onSelectedIcon,
      onSelected: onSelected ?? this.onSelected,
      iconMargin: iconMargin ?? this.iconMargin,
    );
  }
}
