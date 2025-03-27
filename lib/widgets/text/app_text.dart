import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';

enum AppTextLevel {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  bodyExtraSmall,
}

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final AppTextLevel textLevel;
  final TextAlign? textAlign;
  final bool selectable;

  const AppText(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.textLevel = AppTextLevel.displayMedium,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  }) : super(key: key);

  const AppText.displayLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.displayLarge,
        super(key: key);

  const AppText.displayMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.displayMedium,
        super(key: key);

  const AppText.displaySmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.displaySmall,
        super(key: key);

  const AppText.headlineLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.headlineLarge,
        super(key: key);

  const AppText.headlineMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.headlineMedium,
        super(key: key);

  const AppText.headlineSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.headlineSmall,
        super(key: key);

  const AppText.titleLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.titleLarge,
        super(key: key);

  const AppText.titleMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.titleMedium,
        super(key: key);

  const AppText.titleSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.titleSmall,
        super(key: key);

  const AppText.labelLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.labelLarge,
        super(key: key);

  const AppText.labelMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.labelMedium,
        super(key: key);

  const AppText.labelSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.labelSmall,
        super(key: key);

  const AppText.bodyLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.bodyLarge,
        super(key: key);

  const AppText.bodyMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.bodyMedium,
        super(key: key);

  const AppText.bodySmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.bodySmall,
        super(key: key);

  const AppText.bodyExtraSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
  })  : textLevel = AppTextLevel.bodyExtraSmall,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String text = this.text;
    Color? color = this.color;
    TextStyle? style = theme.textTheme.labelLarge;
    int? maxLines;
    switch (textLevel) {
      case AppTextLevel.displayLarge:
        style = theme.textTheme.displayLarge;
        break;
      case AppTextLevel.displayMedium:
        style = theme.textTheme.displayMedium;
        break;
      case AppTextLevel.displaySmall:
        style = theme.textTheme.displaySmall;
        break;
      case AppTextLevel.headlineLarge:
        style = theme.textTheme.headlineLarge;
        break;
      case AppTextLevel.headlineMedium:
        style = theme.textTheme.headlineMedium;
        break;
      case AppTextLevel.headlineSmall:
        style = theme.textTheme.headlineSmall;
        break;
      case AppTextLevel.titleLarge:
        style = theme.textTheme.titleLarge;
        break;
      case AppTextLevel.titleMedium:
        style = theme.textTheme.titleMedium;
        break;
      case AppTextLevel.titleSmall:
        style = theme.textTheme.titleSmall;
        break;
      case AppTextLevel.labelLarge:
        style = theme.textTheme.labelLarge;
        break;
      case AppTextLevel.labelMedium:
        style = theme.textTheme.labelMedium;
        break;
      case AppTextLevel.labelSmall:
        style = theme.textTheme.labelSmall;
        break;
      case AppTextLevel.bodyLarge:
        style = theme.textTheme.bodyLarge;
        break;
      case AppTextLevel.bodyMedium:
        style = theme.textTheme.bodyMedium;
        break;
      case AppTextLevel.bodySmall:
        style = theme.textTheme.bodySmall;
        break;
      case AppTextLevel.bodyExtraSmall:
        style = theme.textSchemeExt.bodyExtraSmall;
        break;
    }

    return selectable
        ? SelectableText(
            text,
            style: style?.copyWith(
              color: this.color ?? color,
              overflow: overflow,
            ),
            maxLines: this.maxLines ?? maxLines,
            // overflow: overflow,
            textAlign: textAlign,
          )
        : Text(
            text,
            style: style?.copyWith(
              color: this.color ?? color,
              overflow: overflow,
            ),
            maxLines: this.maxLines ?? maxLines,
            // overflow: overflow,
            textAlign: textAlign,
          );
  }
}
