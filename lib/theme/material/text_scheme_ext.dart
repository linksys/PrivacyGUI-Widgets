import 'package:flutter/material.dart';

class TextSchemeExt extends ThemeExtension<TextSchemeExt> {
  final TextStyle? bodyExtraSmall;

  const TextSchemeExt({
    this.bodyExtraSmall,
  });

  @override
  ThemeExtension<TextSchemeExt> copyWith({
    TextStyle? bodyExtraSmall,
  }) {
    return TextSchemeExt(bodyExtraSmall: bodyExtraSmall ?? this.bodyExtraSmall);
  }

  @override
  ThemeExtension<TextSchemeExt> lerp(
      covariant ThemeExtension<TextSchemeExt>? other, double t) {
    if (other is! TextSchemeExt) {
      return this;
    }
    return TextSchemeExt(
        bodyExtraSmall:
            TextStyle.lerp(bodyExtraSmall, other.bodyExtraSmall, t));
  }
}
