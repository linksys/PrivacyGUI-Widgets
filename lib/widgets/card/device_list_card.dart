// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/list_card.dart';

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppListCard(
      color: color,
      borderColor: borderColor,
      title: AppText.labelLarge(title),
      description: description != null ? AppText.bodySmall(description!) : null,
      leading: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...onSelected != null
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: AppCheckbox(
                      value: isSelected,
                      onChanged: (value) => onSelected?.call(value ?? false),
                    ),
                  ),
                ]
              : [],
          Icon(leading),
        ],
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (band != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText.labelLarge(band!),
            ),
          ],
          if (trailing != null) Icon(trailing),
        ],
      ),
      onTap: onTap,
    );
  }
}
