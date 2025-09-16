import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/switch/switch.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class QuickToggle extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final String? tips;
  final String semantics;
  final bool value;
  final Function(bool)? onChanged;
  final Function()? onTap;

  const QuickToggle({
    super.key,
    required this.title,
    this.subTitle,
    this.leading,
    this.tips,
    required this.semantics,
    required this.value,
    this.onChanged,
    this.onTap,
    this.padding,
  });

  final EdgeInsetsGeometry? padding;

  @override
  State<QuickToggle> createState() => _QuickToggleState();
}

class _QuickToggleState extends State<QuickToggle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Theme.of(context).colorScheme.primary,
      onTap: widget.onTap,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Wrap(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.labelLarge(widget.title),
                      if (widget.subTitle != null)
                        AppText.bodySmall(widget.subTitle!),
                    ],
                  ),
                  if (widget.leading != null) ...[
                    const SizedBox(
                      width: Spacing.small1,
                    ),
                    widget.leading!,
                  ],
                  const SizedBox(
                    width: Spacing.small2,
                  ),
                  if (widget.tips != null)
                    Tooltip(
                      message: widget.tips!,
                      child: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                ],
              ),
            ),
            AppSwitch(
              key: ValueKey(widget.semantics),
              value: widget.value,
              onChanged: widget.onChanged,
              semanticLabel: widget.semantics,
            ),
          ],
        ),
      ),
    );
  }
}
