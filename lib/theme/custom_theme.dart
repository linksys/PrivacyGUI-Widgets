import 'package:flutter/material.dart';
import 'package:linksys_widgets/theme/_theme.dart';

class CustomTheme extends InheritedWidget {
  const CustomTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final CustomThemeData data;

  static CustomThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<CustomTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant CustomTheme oldWidget) {
    return data != oldWidget.data;
  }
}
