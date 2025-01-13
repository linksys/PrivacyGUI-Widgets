import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:privacygui_widgets/theme/material/color_schemes_ext.dart';
import 'package:privacygui_widgets/theme/material/color_tonal_palettes.dart';

class AppColorScheme {
  final TonalPalette primary;
  final TonalPalette secondary;
  final TonalPalette tertiary;
  final TonalPalette error;
  final TonalPalette neutral;
  final TonalPalette neutralVariant;
  final TonalPalette green;
  final TonalPalette orange;

  AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.error,
    required this.neutral,
    required this.neutralVariant,
    required this.green,
    required this.orange,
  });

  factory AppColorScheme.fromSeed({
    required Color seedColor,
    Brightness brightness = Brightness.light,
    DynamicSchemeVariant dynamicSchemeVariant = DynamicSchemeVariant.tonalSpot,
    double contrastLevel = 0.0,
  }) {
    final DynamicScheme scheme = _buildDynamicScheme(
        brightness, seedColor, dynamicSchemeVariant, contrastLevel);

    final primary = MaterialDynamicColors.primary.palette(scheme);
    final secondary = MaterialDynamicColors.secondary.palette(scheme);
    final tertiary = MaterialDynamicColors.tertiary.palette(scheme);
    final error = MaterialDynamicColors.error.palette(scheme);
    final neutral = MaterialDynamicColors.onSurface.palette(scheme);
    final neutralVariant = MaterialDynamicColors.surfaceVariant.palette(scheme);

    return AppColorScheme(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        error: error,
        neutral: neutral,
        neutralVariant: neutralVariant,
        green: greenTonal,
        orange: orangeTonal);
  }
  factory AppColorScheme.main() {
    return AppColorScheme(
        primary: primaryTonal,
        secondary: secondaryTonal,
        tertiary: tertiartyTonal,
        error: errorTonal,
        neutral: neutralTonal,
        neutralVariant: neutralVariantTonal,
        green: greenTonal,
        orange: orangeTonal);
  }

  AppColorScheme copyWith({
    TonalPalette? primary,
    TonalPalette? secondary,
    TonalPalette? tertiary,
    TonalPalette? error,
    TonalPalette? neutral,
    TonalPalette? neutralVariant,
    TonalPalette? green,
    TonalPalette? orange,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      error: error ?? this.error,
      neutral: neutral ?? this.neutral,
      neutralVariant: neutralVariant ?? this.neutralVariant,
      green: green ?? this.green,
      orange: orange ?? this.orange,
    );
  }

  ColorScheme get light => ColorScheme(
        brightness: Brightness.light,
        primary: _primary(false),
        onPrimary: _onPrimary(false),
        primaryContainer: _primaryContainer(false),
        onPrimaryContainer: _onPrimaryContainer(false),
        secondary: _secondary(false),
        onSecondary: _onSecondary(false),
        secondaryContainer: _secondaryContainer(false),
        onSecondaryContainer: _onSecondaryContainer(false),
        tertiary: _tertiary(false),
        onTertiary: _onTertiary(false),
        tertiaryContainer: _tertiaryContainer(false),
        onTertiaryContainer: _onTertiaryContainer(false),
        error: _error(false),
        onError: _onError(false),
        errorContainer: _errorContainer(false),
        onErrorContainer: _onErrorContainer(false),
        background: _background(false),
        onBackground: _onBackground(false),
        surface: _surface(false),
        onSurface: _onSurface(false),
        surfaceVariant: _surfaceVariant(false),
        onSurfaceVariant: _onSurfaceVariant(false),
        surfaceTint: _surfaceTint(false),
        outline: _outline(false),
        outlineVariant: _outlineVariant(false),
        inverseSurface: _inverseSurface(false),
        onInverseSurface: _onInverseSurface(false),
        inversePrimary: _inversePrimary(false),
        shadow: _shadow(false),
        scrim: _scrim(false),
      );

  ColorSchemeExt get lightExt => ColorSchemeExt(
        primaryFixed: _primaryFixed(false),
        primaryFixedDim: _primaryFixedDim(false),
        onPrimaryFixed: _onPrimaryFixed(false),
        onPrimaryFixedVariant: _onPrimaryFixedVariant(false),
        secondaryFixed: _secondaryFixed(false),
        secondaryFixedDim: _secondaryFixedDim(false),
        onSecondaryFixed: _onSecondaryFixed(false),
        onSecondaryFixedVariant: _onSecondaryFixedVariant(false),
        tertiaryFixed: _tertiaryFixed(false),
        tertiaryFixedDim: _tertiaryFixedDim(false),
        onTertiaryFixed: _onTertiaryFixed(false),
        onTertiaryFixedVariant: _onTertiaryFixedVariant(false),
        surfaceDim: _surfaceDim(false),
        surfaceBright: _surfaceBright(false),
        surfaceContainerLowest: _surfaceContainerLowest(false),
        surfaceContainerLow: _surfaceContainerLow(false),
        surfaceContainer: _surfaceContainer(false),
        surfaceContainerHigh: _surfaceContainerHigh(false),
        surfaceContainerHighest: _surfaceContainerHighest(false),
        green: _green(false),
        onGreen: _onGreen(false),
        secondaryGreen: _secondaryGreen(false),
        onSecondaryGreen: _onSecondaryGreen(false),
        orange: _orange(false),
        onOrange: _onOrange(false),
        secondaryOrange: _secondaryOrange(false),
        onSecondaryOrange: _onSecondaryOrange(false),
      );

  ColorScheme get dark => ColorScheme(
        brightness: Brightness.dark,
        primary: _primary(true),
        onPrimary: _onPrimary(true),
        primaryContainer: _primaryContainer(true),
        onPrimaryContainer: _onPrimaryContainer(true),
        secondary: _secondary(true),
        onSecondary: _onSecondary(true),
        secondaryContainer: _secondaryContainer(true),
        onSecondaryContainer: _onSecondaryContainer(true),
        tertiary: _tertiary(true),
        onTertiary: _onTertiary(true),
        tertiaryContainer: _tertiaryContainer(true),
        onTertiaryContainer: _onTertiaryContainer(true),
        error: _error(true),
        onError: _onError(true),
        errorContainer: _errorContainer(true),
        onErrorContainer: _onErrorContainer(true),
        background: _background(true),
        onBackground: _onBackground(true),
        surface: _surface(true),
        onSurface: _onSurface(true),
        surfaceVariant: _surfaceVariant(true),
        onSurfaceVariant: _onSurfaceVariant(true),
        surfaceTint: _surfaceTint(true),
        outline: _outline(true),
        outlineVariant: _outlineVariant(true),
        inverseSurface: _inverseSurface(true),
        onInverseSurface: _onInverseSurface(true),
        inversePrimary: _inversePrimary(true),
        shadow: _shadow(true),
        scrim: _scrim(true),
      );

  ColorSchemeExt get darkExt => ColorSchemeExt(
        primaryFixed: _primaryFixed(true),
        primaryFixedDim: _primaryFixedDim(true),
        onPrimaryFixed: _onPrimaryFixed(true),
        onPrimaryFixedVariant: _onPrimaryFixedVariant(true),
        secondaryFixed: _secondaryFixed(true),
        secondaryFixedDim: _secondaryFixedDim(true),
        onSecondaryFixed: _onSecondaryFixed(true),
        onSecondaryFixedVariant: _onSecondaryFixedVariant(true),
        tertiaryFixed: _tertiaryFixed(true),
        tertiaryFixedDim: _tertiaryFixedDim(true),
        onTertiaryFixed: _onTertiaryFixed(true),
        onTertiaryFixedVariant: _onTertiaryFixedVariant(true),
        surfaceDim: _surfaceDim(true),
        surfaceBright: _surfaceBright(true),
        surfaceContainerLowest: _surfaceContainerLowest(true),
        surfaceContainerLow: _surfaceContainerLow(true),
        surfaceContainer: _surfaceContainer(true),
        surfaceContainerHigh: _surfaceContainerHigh(true),
        surfaceContainerHighest: _surfaceContainerHighest(true),
        green: _green(true),
        onGreen: _onGreen(true),
        secondaryGreen: _secondaryGreen(true),
        onSecondaryGreen: _onSecondaryGreen(true),
        orange: _orange(true),
        onOrange: _onOrange(true),
        secondaryOrange: _secondaryOrange(true),
        onSecondaryOrange: _onSecondaryOrange(true),
      );
  // Color scheme
  Color _primary(bool isDark) =>
      Color(isDark ? primary.get(60) : primary.get(40));
  Color _onPrimary(bool isDark) =>
      Color(isDark ? primary.get(0) : primary.get(100));
  Color _primaryContainer(bool isDark) =>
      Color(isDark ? primary.get(20) : primary.get(90));
  Color _onPrimaryContainer(bool isDark) =>
      Color(isDark ? primary.get(90) : primary.get(10));
  Color _secondary(bool isDark) =>
      Color(isDark ? secondary.get(80) : secondary.get(40));
  Color _onSecondary(bool isDark) =>
      Color(isDark ? secondary.get(20) : secondary.get(90));
  Color _secondaryContainer(bool isDark) =>
      Color(isDark ? secondary.get(20) : secondary.get(90));
  Color _onSecondaryContainer(bool isDark) =>
      Color(isDark ? secondary.get(90) : secondary.get(10));
  Color _tertiary(bool isDark) =>
      Color(isDark ? tertiary.get(80) : tertiary.get(40));
  Color _onTertiary(bool isDark) =>
      Color(isDark ? tertiary.get(20) : tertiary.get(90));
  Color _tertiaryContainer(bool isDark) =>
      Color(isDark ? tertiary.get(20) : tertiary.get(90));
  Color _onTertiaryContainer(bool isDark) =>
      Color(isDark ? tertiary.get(90) : tertiary.get(10));
  Color _error(bool isDark) => Color(isDark ? error.get(80) : error.get(40));
  Color _onError(bool isDark) => Color(isDark ? error.get(20) : error.get(100));
  Color _errorContainer(bool isDark) =>
      Color(isDark ? error.get(30) : error.get(90));
  Color _onErrorContainer(bool isDark) =>
      Color(isDark ? error.get(90) : error.get(10));
  Color _background(bool isDark) =>
      Color(isDark ? neutral.get(10) : neutral.get(100));
  Color _onBackground(bool isDark) =>
      Color(isDark ? neutral.get(90) : neutral.get(10));
  Color _surface(bool isDark) =>
      Color(isDark ? neutral.get(6) : neutral.get(98));
  Color _onSurface(bool isDark) =>
      Color(isDark ? neutral.get(90) : neutral.get(10));
  Color _surfaceVariant(bool isDark) =>
      Color(isDark ? neutralVariant.get(22) : neutralVariant.get(90));
  Color _onSurfaceVariant(bool isDark) =>
      Color(isDark ? neutralVariant.get(80) : neutralVariant.get(30));
  Color _surfaceTint(bool isDark) =>
      Color(isDark ? primary.get(40) : primary.get(40));
  Color _outline(bool isDark) =>
      Color(isDark ? neutralVariant.get(60) : neutralVariant.get(50));
  Color _outlineVariant(bool isDark) =>
      Color(isDark ? neutralVariant.get(30) : neutralVariant.get(80));
  Color _inverseSurface(bool isDark) =>
      Color(isDark ? neutral.get(90) : neutral.get(20));
  Color _onInverseSurface(bool isDark) =>
      Color(isDark ? neutral.get(25) : neutral.get(95));
  Color _inversePrimary(bool isDark) =>
      Color(isDark ? primary.get(80) : primary.get(40));
  Color _shadow(bool isDark) => Color(isDark ? neutral.get(0) : neutral.get(0));
  Color _scrim(bool isDark) => Color(isDark ? neutral.get(0) : neutral.get(0));
  // Color Scheme Ext
  Color _primaryFixed(bool isDark) =>
      Color(isDark ? primary.get(90) : primary.get(90));
  Color _primaryFixedDim(bool isDark) =>
      Color(isDark ? primary.get(80) : primary.get(80));
  Color _onPrimaryFixed(bool isDark) =>
      Color(isDark ? primary.get(10) : primary.get(10));
  Color _onPrimaryFixedVariant(bool isDark) =>
      Color(isDark ? primary.get(30) : primary.get(30));
  Color _secondaryFixed(bool isDark) =>
      Color(isDark ? secondary.get(90) : secondary.get(90));
  Color _secondaryFixedDim(bool isDark) =>
      Color(isDark ? secondary.get(80) : secondary.get(80));
  Color _onSecondaryFixed(bool isDark) =>
      Color(isDark ? secondary.get(10) : secondary.get(10));
  Color _onSecondaryFixedVariant(bool isDark) =>
      Color(isDark ? secondary.get(30) : secondary.get(30));
  Color _tertiaryFixed(bool isDark) =>
      Color(isDark ? tertiary.get(90) : tertiary.get(90));
  Color _tertiaryFixedDim(bool isDark) =>
      Color(isDark ? tertiary.get(80) : tertiary.get(80));
  Color _onTertiaryFixed(bool isDark) =>
      Color(isDark ? tertiary.get(10) : tertiary.get(10));
  Color _onTertiaryFixedVariant(bool isDark) =>
      Color(isDark ? tertiary.get(30) : tertiary.get(30));
  Color _surfaceDim(bool isDark) =>
      Color(isDark ? neutral.get(6) : neutral.get(87));
  Color _surfaceBright(bool isDark) =>
      Color(isDark ? neutral.get(24) : neutral.get(98));
  Color _surfaceContainerLowest(bool isDark) =>
      Color(isDark ? neutral.get(4) : neutral.get(100));
  Color _surfaceContainerLow(bool isDark) =>
      Color(isDark ? neutral.get(10) : neutral.get(96));
  Color _surfaceContainer(bool isDark) =>
      Color(isDark ? neutral.get(12) : neutral.get(94));
  Color _surfaceContainerHigh(bool isDark) =>
      Color(isDark ? neutral.get(17) : neutral.get(92));
  Color _surfaceContainerHighest(bool isDark) =>
      Color(isDark ? neutral.get(22) : neutral.get(90));
  Color _green(bool isDark) => Color(isDark ? green.get(50) : green.get(50));
  Color _onGreen(bool isDark) => Color(isDark ? green.get(0) : green.get(100));
  Color _secondaryGreen(bool isDark) =>
      Color(isDark ? green.get(40) : green.get(90));
  Color _onSecondaryGreen(bool isDark) =>
      Color(isDark ? green.get(90) : green.get(10));
  Color _orange(bool isDark) => Color(isDark ? orange.get(80) : orange.get(40));
  Color _onOrange(bool isDark) =>
      Color(isDark ? orange.get(20) : orange.get(10));
  Color _secondaryOrange(bool isDark) =>
      Color(isDark ? orange.get(30) : orange.get(90));
  Color _onSecondaryOrange(bool isDark) =>
      Color(isDark ? orange.get(90) : orange.get(10));

  //
  static DynamicScheme _buildDynamicScheme(
    Brightness brightness,
    Color seedColor,
    DynamicSchemeVariant schemeVariant,
    double contrastLevel,
  ) {
    assert(
      contrastLevel >= -1.0 && contrastLevel <= 1.0,
      'contrastLevel must be between -1.0 and 1.0 inclusive.',
    );
    final bool isDark = brightness == Brightness.dark;
    final Hct sourceColor = Hct.fromInt(seedColor.value);
    return switch (schemeVariant) {
      DynamicSchemeVariant.tonalSpot => SchemeTonalSpot(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.fidelity => SchemeFidelity(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.content => SchemeContent(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.monochrome => SchemeMonochrome(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.neutral => SchemeNeutral(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.vibrant => SchemeVibrant(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.expressive => SchemeExpressive(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.rainbow => SchemeRainbow(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
      DynamicSchemeVariant.fruitSalad => SchemeFruitSalad(
          sourceColorHct: sourceColor,
          isDark: isDark,
          contrastLevel: contrastLevel),
    };
  }
}

final appMainColorScheme = AppColorScheme.main();
final lightColorScheme = appMainColorScheme.light;
final lightColorSchemeExt = appMainColorScheme.lightExt;
final darkColorScheme = appMainColorScheme.dark;
final darkColorSchemeExt = appMainColorScheme.darkExt;
