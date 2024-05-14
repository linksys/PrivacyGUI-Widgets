import 'package:flutter/material.dart';
import 'package:linksys_widgets/icons/linksys_icons.dart';
import 'package:linksys_widgets/theme/const/spacing.dart';
import 'package:linksys_widgets/widgets/text/app_text.dart';

class BorderListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? subTitle;
  const BorderListTile({
    super.key,
    required this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: Theme.of(context).colorScheme.onBackground),
      ),
      title: AppText.titleMedium(title),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: subTitle != null ? AppText.bodyMedium(subTitle!) : null,
      ),
      trailing: const Icon(LinksysIcons.chevronRight),
      contentPadding: const EdgeInsets.all(Spacing.semiBig),
    );
  }
}
