// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';

class AppExpansion extends StatelessWidget {
  const AppExpansion({
    Key? key,
    this.initiallyExpanded = true,
    this.title,
    this.subTitle,
    required this.children,
  }) : super(key: key);

  final bool initiallyExpanded;
  final String? title;
  final String? subTitle;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        initiallyExpanded: initiallyExpanded,
        title: AppText.bodyLarge(title ?? ''),
        subtitle: subTitle == null ? null : AppText.bodyMedium(subTitle!),
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 16),
        children: [...children]);
  }
}
