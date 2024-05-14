// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool showBorder;
  final EdgeInsets? padding;
  final Color? color;
  final Color? borderColor;

  const AppCard({
    Key? key,
    this.onTap,
    this.showBorder = true,
    this.padding,
    this.color,
    this.borderColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color,
      shape: showBorder
          ? RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor ??
                      Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: InkWell(
        borderRadius: showBorder ? BorderRadius.circular(8) : null,
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: Container(child: child),
        ),
      ),
    );
  }
}
