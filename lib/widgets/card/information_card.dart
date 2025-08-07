import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

class AppInformationCard extends StatelessWidget {
  final Widget? headerIcon;
  final String title;
  final String? description;
  final Widget? content;

  const AppInformationCard({
    Key? key,
    this.headerIcon,
    required this.title,
    this.description,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: Spacing.medium,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacing.small2,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Spacing.medium,
                  children: [
                    if (headerIcon != null) headerIcon!,
                    AppText.titleLarge(title),
                  ]),
              if (description != null)
                AppText.bodyMedium(description!,
                    color: Theme.of(context).colorScheme.outline),
            ],
          ),
          if (content != null) content!,
        ],
      ),
    );
  }
}
