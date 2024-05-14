import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/const/spacing.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

enum AppToastType {
  positive,
  negative,
}

class AppToast extends StatelessWidget {
  final AppToastType? type;
  final String text;

  const AppToast({super.key, required this.text, this.type});

  const AppToast.positive({
    super.key,
    required this.text,
  }) : type = AppToastType.positive;

  const AppToast.negative({
    super.key,
    required this.text,
  }) : type = AppToastType.negative;

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    IconData? icon;

    switch (type) {
      case AppToastType.positive:
        borderColor = Colors.green;
        icon = LinksysIcons.check;
        break;
      case AppToastType.negative:
        borderColor = Theme.of(context).colorScheme.errorContainer;
        icon = LinksysIcons.close;
        break;
      default:
        break;
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          color: Theme.of(context).colorScheme.inverseSurface),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.semiBig),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onInverseSurface,
              ),
            if (icon != null) const AppGap.regular(),
            AppText.labelLarge(
              text,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ],
        ),
      ),
    );
  }
}

class AppToastHelp {
  static SnackBar positiveToast(BuildContext context, {required String text}) =>
      SnackBar(
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        content: AppToast.positive(
          text: text,
        ),
      );

  static SnackBar negativeToast(context, {required String text}) => SnackBar(
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        content: AppToast.negative(
          text: text,
        ),
      );
}
