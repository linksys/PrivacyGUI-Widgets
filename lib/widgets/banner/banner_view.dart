import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/const/spacing.dart';
import 'package:privacygui_widgets/widgets/banner/banner_style.dart';
import 'package:privacygui_widgets/widgets/base/gap.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppBanner extends StatelessWidget {
  final BannerStyle style;
  final String text;
  final EdgeInsets? padding;

  const AppBanner({
    super.key,
    required this.style,
    required this.text,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final (color, icon) = () {
      switch (style) {
        case BannerStyle.success:
          return (Colors.green, LinksysIcons.check);
        case BannerStyle.error:
          return (
            Theme.of(context).colorScheme.errorContainer,
            LinksysIcons.close
          );
      }
    }();

    return Padding(
      padding: padding ??
          const EdgeInsets.only(
              left: Spacing.regular,
              right: Spacing.regular,
              top: Spacing.extraBig),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 80,
          color: color,
          child: Row(children: [
            Icon(
              icon,
            ),
            const AppGap.regular(),
            Expanded(
                child: AppText.bodyLarge(
              text,
              color: Colors.white,
            )),
          ]),
        ),
      ),
    );
  }
}
