import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppExpansionCard extends StatefulWidget {
  final String title;
  final IconData? expandedIcon;
  final IconData? collapsedIcon;
  final List<Widget>? children;

  const AppExpansionCard({
    super.key,
    required this.title,
    required this.children,
    this.expandedIcon,
    this.collapsedIcon,
  });

  @override
  State<AppExpansionCard> createState() => _AppExpansionCardState();
}

class _AppExpansionCardState extends State<AppExpansionCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: AppCard(
          child: ExpansionTile(
        iconColor: Theme.of(context).colorScheme.onSurface,
        title: AppText.labelLarge(widget.title),
        trailing:
            Icon(_isExpanded ? widget.collapsedIcon : widget.expandedIcon),
        children: widget.children ?? [],
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
      )),
    );
  }
}