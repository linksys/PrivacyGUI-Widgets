import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/toggle/quick_toggle.dart';

class QuickPanelList extends StatelessWidget {
  final List<QuickToggle> children;
  final double? spacing;
  final Widget? separator;

  const QuickPanelList({
    super.key,
    required this.children,
    this.spacing,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children.isEmpty
          ? []
          : List.generate(children.length * 2 - 1, (index) {
              if (index.isEven) {
                return children[index ~/ 2];
              } else {
                return separator ?? SizedBox(height: spacing ?? 0);
              }
            }),
    );
  }
}
