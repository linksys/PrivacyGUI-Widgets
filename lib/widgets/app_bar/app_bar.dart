import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/const/spacing.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class LinksysAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? trailing;
  final EdgeInsets padding;
  final double toolbarHeight;
  final Color? backgroundColor;

  @override
  final Size preferredSize;

  LinksysAppBar({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.toolbarHeight = kToolbarHeight,
    this.backgroundColor,
    this.padding =
        const EdgeInsets.only(left: Spacing.regular, right: Spacing.regular),
  }) : preferredSize = _PreferredAppBarSize(toolbarHeight, 0);

  LinksysAppBar.withBack({
    super.key,
    required BuildContext context,
    this.title,
    this.trailing,
    this.toolbarHeight = kToolbarHeight,
    this.backgroundColor,
    this.padding = const EdgeInsets.only(left: 0, right: 0),
    bool showBack = true,
    VoidCallback? onBackTap,
  })  : leading = showBack
            ? AppIconButton.noPadding(
                icon: LinksysIcons.arrowBack,
                onTap: onBackTap,
                alignment: Alignment.centerLeft,
              )
            : null,
        preferredSize = _PreferredAppBarSize(toolbarHeight, 0);

  LinksysAppBar.withClose({
    super.key,
    required BuildContext context,
    this.title,
    this.leading,
    this.toolbarHeight = kToolbarHeight,
    this.backgroundColor,
    this.padding =
        const EdgeInsets.only(left: Spacing.regular, right: Spacing.regular),
    bool showBack = true,
    VoidCallback? onBackTap,
  })  : trailing = showBack
            ? [
                AppIconButton.noPadding(
                  icon: LinksysIcons.close,
                  alignment: Alignment.centerRight,
                  onTap: onBackTap,
                )
              ]
            : null,
        preferredSize = _PreferredAppBarSize(toolbarHeight, 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        height: toolbarHeight,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _barLayout(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _barLayout(BuildContext context) {
    final leading = this.leading;
    final title = this.title;

    return [
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (leading != null)
            Container(
              constraints: const BoxConstraints(minWidth: Spacing.big),
              child: leading,
            ),
          if (title != null)
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Spacing.regular),
                child: FittedBox(fit: BoxFit.contain, child: title)),
        ],
      ),
      _buildTrailing(context),
    ];
  }

  Widget _buildTrailing(BuildContext context) {
    final trailing = this.trailing ?? [];
    return Container(
      constraints: const BoxConstraints(minWidth: Spacing.big),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [...trailing.map((e) => e).toList()],
      ),
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
