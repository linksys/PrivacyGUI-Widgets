import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppTips extends StatefulWidget {
  final Widget child;
  final String? tips;
  final IconData? leadIcon;
  final Color? leadIconColor;
  final Color? background;
  final bool showTips;

  const AppTips({
    super.key,
    required this.child,
    this.tips,
    this.leadIcon,
    this.leadIconColor,
    this.background,
    this.showTips = false,
  });

  @override
  State<AppTips> createState() => _AppTipsState();
}

class _AppTipsState extends State<AppTips> {
  @override
  Widget build(BuildContext context) {
    final hasGlobalKey = widget.child.key is GlobalKey;
    final childKey = widget.child.key as GlobalKey? ?? GlobalKey();
    return Stack(
      children: [
        Visibility(
          visible: widget.showTips,
          child: Positioned(
            top: getOffset(childKey)?.dy, // Calculate desired position
            left: getOffset(childKey)?.dx, // Calculate desired position
            child: Container(
              decoration: BoxDecoration(
                // Style like a tooltip
                color: widget.background ??
                    Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                spacing: Spacing.small1,
                children: [
                  if (widget.leadIcon != null)
                    Icon(
                      widget.leadIcon,
                      color: widget.leadIconColor,
                    ),
                  if (widget.tips != null) AppText.bodySmall(widget.tips!),
                ],
              ),
            ),
          ),
        ),
        if (hasGlobalKey) widget.child,
        if (!hasGlobalKey)
          Container(
            key: childKey,
            child: widget.child,
          )
      ],
    );
  }

  Offset? getOffset(GlobalKey key) {
    return (key.currentContext?.findRenderObject() as RenderBox?)
        ?.localToGlobal(Offset.zero);
  }
}
