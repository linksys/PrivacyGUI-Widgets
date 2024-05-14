// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class ColorSchemeExt extends ThemeExtension<ColorSchemeExt> {
  final Color? primaryFixed;
  final Color? primaryFixedDim;
  final Color? onPrimaryFixed;
  final Color? onPrimaryFixedVariant;
  final Color? secondaryFixed;
  final Color? secondaryFixedDim;
  final Color? onSecondaryFixed;
  final Color? onSecondaryFixedVariant;
  final Color? tertiaryFixed;
  final Color? tertiaryFixedDim;
  final Color? onTertiaryFixed;
  final Color? onTertiaryFixedVariant;
  final Color? surfaceDim;
  final Color? surfaceBright;
  final Color? surfaceContainerLowest;
  final Color? surfaceContainerLow;
  final Color? surfaceContainer;
  final Color? surfaceContainerHigh;
  final Color? surfaceContainerHighest;
  // Green
  final Color? green;
  final Color? onGreen;
  final Color? secondaryGreen;
  final Color? onSecondaryGreen;
  // Orange
  final Color? orange;
  final Color? onOrange;
  final Color? secondaryOrange;
  final Color? onSecondaryOrange;

  const ColorSchemeExt({
    this.primaryFixed,
    this.primaryFixedDim,
    this.onPrimaryFixed,
    this.onPrimaryFixedVariant,
    this.secondaryFixed,
    this.secondaryFixedDim,
    this.onSecondaryFixed,
    this.onSecondaryFixedVariant,
    this.tertiaryFixed,
    this.tertiaryFixedDim,
    this.onTertiaryFixed,
    this.onTertiaryFixedVariant,
    this.surfaceDim,
    this.surfaceBright,
    this.surfaceContainerLowest,
    this.surfaceContainerLow,
    this.surfaceContainer,
    this.surfaceContainerHigh,
    this.surfaceContainerHighest,
    this.green,
    this.onGreen,
    this.secondaryGreen,
    this.onSecondaryGreen,
    this.orange,
    this.onOrange,
    this.secondaryOrange,
    this.onSecondaryOrange,
  });

  @override
  ColorSchemeExt copyWith({
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? green,
    Color? onGreen,
    Color? secondaryGreen,
    Color? onSecondaryGreen,
    Color? orange,
    Color? onOrange,
    Color? secondaryOrange,
    Color? onSecondaryOrange,
  }) {
    return ColorSchemeExt(
      primaryFixed: primaryFixed ?? this.primaryFixed,
      primaryFixedDim: primaryFixedDim ?? this.primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed ?? this.onPrimaryFixed,
      onPrimaryFixedVariant:
          onPrimaryFixedVariant ?? this.onPrimaryFixedVariant,
      secondaryFixed: secondaryFixed ?? this.secondaryFixed,
      secondaryFixedDim: secondaryFixedDim ?? this.secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed ?? this.onSecondaryFixed,
      onSecondaryFixedVariant:
          onSecondaryFixedVariant ?? this.onSecondaryFixedVariant,
      tertiaryFixed: tertiaryFixed ?? this.tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim ?? this.tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed ?? this.onTertiaryFixed,
      onTertiaryFixedVariant:
          onTertiaryFixedVariant ?? this.onTertiaryFixedVariant,
      surfaceDim: surfaceDim ?? this.surfaceDim,
      surfaceBright: surfaceBright ?? this.surfaceBright,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      green: green ?? this.green,
      onGreen: onGreen ?? this.onGreen,
      secondaryGreen: secondaryGreen ?? this.secondaryGreen,
      onSecondaryGreen: onSecondaryGreen ?? this.onSecondaryGreen,
      orange: orange ?? this.orange,
      onOrange: onOrange ?? this.onOrange,
      secondaryOrange: secondaryOrange ?? this.secondaryOrange,
      onSecondaryOrange: onSecondaryOrange ?? this.onSecondaryOrange,
    );
  }

  @override
  ColorSchemeExt lerp(ColorSchemeExt? other, double t) {
    if (other is! ColorSchemeExt) {
      return this;
    }
    return ColorSchemeExt(
      primaryFixed: Color.lerp(primaryFixed, other.primaryFixed, t),
      primaryFixedDim: Color.lerp(primaryFixedDim, other.primaryFixedDim, t),
      onPrimaryFixed: Color.lerp(onPrimaryFixed, other.onPrimaryFixed, t),
      onPrimaryFixedVariant:
          Color.lerp(onPrimaryFixedVariant, other.onPrimaryFixedVariant, t),
      secondaryFixed: Color.lerp(secondaryFixed, other.secondaryFixed, t),
      secondaryFixedDim:
          Color.lerp(secondaryFixedDim, other.secondaryFixedDim, t),
      onSecondaryFixed: Color.lerp(onSecondaryFixed, other.onSecondaryFixed, t),
      onSecondaryFixedVariant:
          Color.lerp(onSecondaryFixedVariant, other.onSecondaryFixedVariant, t),
      tertiaryFixed: Color.lerp(tertiaryFixed, other.tertiaryFixed, t),
      tertiaryFixedDim: Color.lerp(tertiaryFixedDim, other.tertiaryFixedDim, t),
      onTertiaryFixed: Color.lerp(onTertiaryFixed, other.onTertiaryFixed, t),
      onTertiaryFixedVariant:
          Color.lerp(onTertiaryFixedVariant, other.onTertiaryFixedVariant, t),
      surfaceDim: Color.lerp(surfaceDim, other.surfaceDim, t),
      surfaceBright: Color.lerp(surfaceBright, other.surfaceBright, t),
      surfaceContainerLowest:
          Color.lerp(surfaceContainerLowest, other.surfaceContainerLowest, t),
      surfaceContainerLow:
          Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t),
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t),
      surfaceContainerHigh:
          Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t),
      surfaceContainerHighest:
          Color.lerp(surfaceContainerHighest, other.surfaceContainerHighest, t),
      green: Color.lerp(green, other.green, t),
      onGreen: Color.lerp(onGreen, other.onGreen, t),
      secondaryGreen: Color.lerp(secondaryGreen, other.secondaryGreen, t),
      onSecondaryGreen: Color.lerp(onSecondaryGreen, other.onSecondaryGreen, t),
      orange: Color.lerp(orange, other.orange, t),
      onOrange: Color.lerp(onOrange, other.onOrange, t),
      secondaryOrange: Color.lerp(secondaryOrange, other.secondaryOrange, t),
      onSecondaryOrange:
          Color.lerp(onSecondaryOrange, other.onSecondaryOrange, t),
    );
  }
}
