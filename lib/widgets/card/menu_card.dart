import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';

class AppMenuCard extends StatelessWidget {
  const AppMenuCard({
    super.key,
    this.iconData,
    this.title,
    this.description,
    this.onTap,
    this.color,
    this.borderColor,
  });

  final IconData? iconData;
  final String? title;
  final String? description;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      color: color,
      borderColor: borderColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tooltip(
            message: title ?? '',
            waitDuration: const Duration(milliseconds: 500),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                iconData,
                size: 24,
              ),
            ),
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AppText.titleSmall(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: AppText.bodySmall(
                description ?? '',
                overflow: TextOverflow.ellipsis,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
        ],
      ),
    );
  }
}
