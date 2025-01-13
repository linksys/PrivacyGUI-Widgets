// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

class AppCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool showBorder;
  final EdgeInsets? padding;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? margin;
  final Clip? clipBehavior;
  final bool? excludeSemantics;
  final bool explicitChildNodes;
  final String? identifier;
  final String? semanticLabel;

  const AppCard({
    Key? key,
    this.onTap,
    this.showBorder = true,
    this.padding,
    this.color,
    this.borderColor,
    this.margin,
    this.clipBehavior,
    this.excludeSemantics = false,
    this.explicitChildNodes = true,
    this.identifier,
    this.semanticLabel,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      elevation: 0,
      color: color,
      margin: margin ?? const EdgeInsets.only(),
      shape: showBorder
          ? RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor ??
                      Theme.of(context).colorScheme.outlineVariant),
              borderRadius:
                  CustomTheme.of(context).radius.asBorderRadius().medium,
            )
          : null,
      clipBehavior: clipBehavior,
      child: onTap == null
          ? _buildChild(padding, child)
          : InkWell(
              borderRadius: showBorder
                  ? CustomTheme.of(context).radius.asBorderRadius().medium
                  : null,
              splashColor: Theme.of(context).colorScheme.primary,
              focusColor: Colors.transparent,
              onTap: onTap,
              child: _buildChild(padding, child),
            ),
    );
  }

  Widget _buildChild(EdgeInsets? padding, Widget child) => Padding(
      padding: padding ?? const EdgeInsets.all(Spacing.medium), child: child);
}
