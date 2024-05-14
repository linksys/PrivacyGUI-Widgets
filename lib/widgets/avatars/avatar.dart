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

class AppAvatar extends StatelessWidget {
  final ImageProvider image;
  final AppAvatarSizes size;

  const AppAvatar.extraSmall({super.key, required this.image})
      : size = AppAvatarSizes.extraSmall;

  const AppAvatar.small({super.key, required this.image})
      : size = AppAvatarSizes.small;

  const AppAvatar.normal({super.key, required this.image})
      : size = AppAvatarSizes.normal;

  const AppAvatar.large({super.key, required this.image})
      : size = AppAvatarSizes.large;

  const AppAvatar.extraLarge({super.key, required this.image})
      : size = AppAvatarSizes.extraLarge;

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
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: image, fit: BoxFit.fill),
      ),
    );
  }
}
