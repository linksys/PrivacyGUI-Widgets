// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/list_card.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

class AppDeviceListCard extends StatelessWidget {
  final IconData leading;
  final String title;
  final String? description;
  final IconData? trailing;
  final String? band;
  final VoidCallback? onTap;
  final void Function(bool)? onSelected;
  final bool isSelected;
  final Color? color;
  final Color? borderColor;
  final bool? explicitChildNodes;
  final bool? excludeSemantics;
  final String? identifier;
  final String? semanticLabel;

  const AppDeviceListCard({
    Key? key,
    required this.leading,
    required this.title,
    this.description,
    required this.trailing,
    this.band,
    this.isSelected = false,
    this.color,
    this.borderColor,
    this.onTap,
    this.onSelected,
    this.explicitChildNodes,
    this.excludeSemantics,
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
          ? AppText.bodySmall(
              description!,
              identifier: identifier,
            )
          : null,
      leading: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...onSelected != null
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: Spacing.medium),
                    child: AppCheckbox(
                      identifier: identifier,
                      semanticLabel: semanticLabel,
                      value: isSelected,
                      onChanged: (value) => onSelected?.call(value ?? false),
                    ),
                  ),
                ]
              : [],
          Padding(
            padding: const EdgeInsets.all(Spacing.small2),
            child: Semantics(
              identifier: identifier != null ? '$identifier-leading' : null,
              label: semanticLabel != null ? '$semanticLabel leading' : null,
              child: Icon(leading),
            ),
          ),
        ],
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (band != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.small2),
              child: AppText.labelLarge(
                band!,
                identifier: identifier,
              ),
            ),
          ],
          if (trailing != null)
            Semantics(
              identifier: identifier != null ? '$identifier-trailing' : null,
              label: semanticLabel != null ? '$semanticLabel trailing' : null,
              child: Icon(trailing),
            ),
        ],
      ),
      onTap: onTap,
      explicitChildNodes: explicitChildNodes,
      excludeSemantics: excludeSemantics,
      identifier: identifier,
      semanticLabel: semanticLabel,
    );
  }
}
