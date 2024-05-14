import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privacygui_widgets/theme/_theme.dart';

enum CustomColorMode {
  light,
  dark,
  highContrast,
}

/// Updates automatically the [CustomTheme] regarding the current [MediaQuery],
/// as soon as the [theme] isn't overriden.
class CustomResponsive extends StatelessWidget {
  const CustomResponsive({
    Key? key,
    required this.child,
    this.colorMode,
  }) : super(key: key);

  final CustomColorMode? colorMode;
  final Widget child;

  static CustomColorMode colorModeOf(BuildContext context) {
    final platformBrightness = Theme.of(context).brightness;
    final useDarkTheme = platformBrightness == ui.Brightness.dark;
    if (useDarkTheme) {
      return CustomColorMode.dark;
    }
    final highContrast = MediaQuery.highContrastOf(context);
    if (highContrast) {
      return CustomColorMode.highContrast;
    }

    return CustomColorMode.light;
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomThemeData.regular();

    /// Updating the colors for the current brightness
    final colorMode = this.colorMode ?? colorModeOf(context);
    switch (colorMode) {
      case CustomColorMode.dark:
        theme = CustomThemeData.withImage(AppImagesData.dark());
        break;
      case CustomColorMode.highContrast:
        break;
      case CustomColorMode.light:
        break;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: colorMode == CustomColorMode.light
            ? Brightness.dark
            : Brightness.light, // dark text for status bar
        statusBarColor: Colors.transparent));

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);

    return CustomTheme(
        data: theme,
        child: Container(
          // color: backgroundColor ?? theme.colors.background,
          child: child,
        ));
  }
}
