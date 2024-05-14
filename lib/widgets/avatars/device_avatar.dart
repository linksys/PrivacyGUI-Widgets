import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';

enum AppAvatarSizes {
  extraSmall,
  small,
  normal,
  large,
  extraLarge,
}

class AppDeviceAvatar extends StatelessWidget {
  final ImageProvider image;
  final AppAvatarSizes size;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? borderWidth;

  const AppDeviceAvatar.extraSmall({
    super.key,
    required this.image,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  }) : size = AppAvatarSizes.extraSmall;

  const AppDeviceAvatar.small({
    super.key,
    required this.image,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  }) : size = AppAvatarSizes.small;

  const AppDeviceAvatar.normal({
    super.key,
    required this.image,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  }) : size = AppAvatarSizes.normal;

  const AppDeviceAvatar.large({
    super.key,
    required this.image,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  }) : size = AppAvatarSizes.large;

  const AppDeviceAvatar.extraLarge({
    super.key,
    required this.image,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  }) : size = AppAvatarSizes.extraLarge;

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final size = () {
      switch (this.size) {
        case AppAvatarSizes.extraSmall:
          return theme.avatar.extraSmall;
        case AppAvatarSizes.small:
          return theme.avatar.small;
        case AppAvatarSizes.normal:
          return theme.avatar.normal;
        case AppAvatarSizes.large:
          return theme.avatar.large;
        case AppAvatarSizes.extraLarge:
          return theme.avatar.extraLarge;
      }
    }();
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Colors.black,
              width: borderWidth ?? 1,
            ),
            borderRadius: BorderRadius.circular(100),
            color: backgroundColor ?? Colors.black,
          ),
          width: size,
          height: size,
        ),
        Image(
          image: image,
          height: size * 0.75,
          width: size * 0.75,
        ),
      ],
    );
  }
}
