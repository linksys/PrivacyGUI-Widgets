// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';

class AppExpansion extends StatelessWidget {
  const AppExpansion({
    Key? key,
    this.initiallyExpanded = true,
    this.title,
    this.subTitle,
    required this.children,
    this.identifier,
  }) : super(key: key);

  final bool initiallyExpanded;
  final String? title;
  final String? subTitle;

  final List<Widget> children;
  final String? identifier;

  @override
  Widget build(BuildContext context) {
    return IdentifierSemantics(
      identifier: identifier,
      child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          initiallyExpanded: initiallyExpanded,
          title: AppText.bodyLarge(title ?? ''),
          subtitle: subTitle == null ? null : AppText.bodyMedium(subTitle!),
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: 16),
          children: [...children]),
    );
  }
}
