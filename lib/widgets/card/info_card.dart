// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/list_card.dart';

class AppInfoCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? trailing;
  final String? band;
  final VoidCallback? onTap;
  final void Function(bool)? onSelected;
  final bool isSelected;
  final bool showBorder;
  final EdgeInsets? padding;
  final Color? color;
  final Color? borderColor;
  final bool? excludeSemantics;
  final bool? explicitChildNodes;
  final String? identifier;
  final String? semanticLabel;

  const AppInfoCard({
    Key? key,
    required this.title,
    this.description,
    this.trailing,
    this.band,
    this.isSelected = false,
    this.onTap,
    this.onSelected,
    this.showBorder = true,
    this.padding,
    this.color,
    this.borderColor,
    this.excludeSemantics,
    this.explicitChildNodes,
    this.identifier,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppListCard(
      color: color,
      borderColor: borderColor,
      title: AppText.labelLarge(
        title,
        identifier: identifier,
      ),
      description: description != null
          ? AppText.bodyMedium(
              description!,
              identifier: identifier,
            )
          : null,
      trailing: trailing,
      showBorder: showBorder,
      padding: padding,
      onTap: onTap,
      explicitChildNodes: explicitChildNodes,
      excludeSemantics: excludeSemantics,
      identifier: identifier,
      semanticLabel: semanticLabel,
    );
  }
}
