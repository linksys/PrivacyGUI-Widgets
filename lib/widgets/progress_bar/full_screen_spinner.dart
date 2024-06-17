import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/utils/lottie.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:lottie/lottie.dart';

class AppFullScreenSpinner extends StatelessWidget {
  final String? title;
  final String? text;
  final Color? background;
  final Color? color;
  final bool wrap;

  const AppFullScreenSpinner({
    Key? key,
    this.title,
    this.text,
    this.background,
    this.color,
    this.wrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background ?? Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: wrap ? MainAxisSize.min : MainAxisSize.max,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorSchemeExt.primaryFixed ??
                    Theme.of(context).colorScheme.onSurface,
                BlendMode.srcATop,
              ),
              child: Lottie.asset(
                'assets/lottie/loading.lottie',
                decoder: customDecoder,
                package: 'privacygui_widgets',
                width: 240,
                height: 240,
                fit: BoxFit.contain,
              ),
            ),
            const AppGap.large1(),
            if (title != null) AppText.headlineSmall(title ?? ''),
            if (text != null) AppText.bodyMedium(text ?? ''),
          ],
        ),
      ),
    );
  }
}
