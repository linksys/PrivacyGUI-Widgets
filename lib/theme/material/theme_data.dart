import 'package:flutter/material.dart';
import 'package:linksys_widgets/theme/_theme.dart';
import 'package:linksys_widgets/theme/material/color_schemes.dart';
import 'package:linksys_widgets/theme/material/text_schemes.dart';

final linksysLightThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: linksysTextTheme,
  colorScheme: lightColorScheme,
  iconTheme: IconThemeData(
      color: lightColorScheme.onSurface, fill: 0, weight: 400, opticalSize: 24),
  extensions: [
    lightColorSchemeExt,
    textSchemeExt,
  ],
  dialogTheme: DialogTheme(
      backgroundColor: lightColorSchemeExt.surfaceContainerHigh, elevation: 0),
);
final linksysDarkThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: linksysTextTheme,
  colorScheme: darkColorScheme,
  iconTheme: IconThemeData(
      color: darkColorScheme.onSurface, fill: 0, weight: 400, opticalSize: 24),
  extensions: [
    darkColorSchemeExt,
    textSchemeExt,
  ],
  dialogTheme: DialogTheme(
      backgroundColor: darkColorSchemeExt.surfaceContainerHigh, elevation: 0),
);

extension ThemeDataExt on ThemeData {
  ColorSchemeExt get colorSchemeExt => extension<ColorSchemeExt>()!;
}
