import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/utils/lottie.dart';
import 'package:lottie/lottie.dart';

class AppSpinner extends StatelessWidget {
  final Size? size;

  const AppSpinner({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width ?? 200,
      height: size?.height ?? 200,
      child: Center(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorSchemeExt.primaryFixed ??
                Theme.of(context).colorScheme.onSurface,
            BlendMode.srcATop,
          ),
          child: Lottie.asset(
            'assets/lottie/loading.lottie',
            decoder: customDecoder,
            package: 'privacygui_widgets',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
