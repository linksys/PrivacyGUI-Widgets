import 'dart:ui';

import 'package:material_color_utilities/hct/hct.dart';
import 'package:material_color_utilities/palettes/tonal_palette.dart';

const _primarySeed = Color(0xFF0870EA);
const _secondarySeed = Color(0xFF6C7790);
const _tertiarySeed = Color(0xFF001F52);
const _errorSeed = Color(0xFFDE3730);
const _neutralSeed = Color(0xFFFFFFFF);
const _neutralVariantSeed = Color(0xFF74777F);
const _greenSeed = Color(0xFF64ED73);
const _orangeSeed = Color(0xFFFDC127);

TonalPalette primaryTonal = toTonalPalette(_primarySeed.value);
TonalPalette secondaryTonal = toTonalPalette(_secondarySeed.value);
TonalPalette tertiartyTonal = toTonalPalette(_tertiarySeed.value);
TonalPalette errorTonal = toTonalPalette(_errorSeed.value);
TonalPalette neutralTonal = toTonalPalette(_neutralSeed.value);
TonalPalette neutralVariantTonal = toTonalPalette(_neutralVariantSeed.value);
TonalPalette greenTonal = toTonalPalette(_greenSeed.value);
TonalPalette orangeTonal = toTonalPalette(_orangeSeed.value);

TonalPalette toTonalPalette(int value) {
  final color = Hct.fromInt(value);
  return TonalPalette.of(color.hue, color.chroma);
}
