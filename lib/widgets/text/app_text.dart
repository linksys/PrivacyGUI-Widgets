import 'package:flutter/material.dart';

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
}

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final AppTextLevel textLevel;
  final TextAlign? textAlign;

  const AppText(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.textLevel = AppTextLevel.displayMedium,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  const AppText.displayLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.displayLarge,
        super(key: key);

  const AppText.displayMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.displayMedium,
        super(key: key);

  const AppText.displaySmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.displaySmall,
        super(key: key);

  const AppText.headlineLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.headlineLarge,
        super(key: key);

  const AppText.headlineMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.headlineMedium,
        super(key: key);

  const AppText.headlineSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.headlineSmall,
        super(key: key);

  const AppText.titleLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.titleLarge,
        super(key: key);

  const AppText.titleMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.titleMedium,
        super(key: key);

  const AppText.titleSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.titleSmall,
        super(key: key);

  const AppText.labelLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.labelLarge,
        super(key: key);

  const AppText.labelMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.labelMedium,
        super(key: key);

  const AppText.labelSmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.labelSmall,
        super(key: key);

  const AppText.bodyLarge(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.bodyLarge,
        super(key: key);

  const AppText.bodyMedium(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.bodyMedium,
        super(key: key);

  const AppText.bodySmall(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  })  : textLevel = AppTextLevel.bodySmall,
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
        maxLines = 2;
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
    }

    return Text(
      text,
      style: style?.copyWith(
        color: this.color ?? color,
      ),
      maxLines: this.maxLines ?? maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
