import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';
import 'package:privacygui_widgets/utils/lottie.dart';
import 'package:lottie/lottie.dart';

class AppSpinner extends StatelessWidget {
  final Size? size;
  final String? semanticLabel;
  final String? identifier;

  const AppSpinner({
    Key? key,
    this.size,
    this.semanticLabel,
    this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdentifierSemantics(
      identifier: identifier,
      child: _spinner(context),
    );
  }

  Widget _spinner(BuildContext context) {
    return SizedBox(
      width: size?.width ?? 200,
      height: size?.height ?? 200,
      child: Semantics(
        label: semanticLabel,
        child: Center(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
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
      ),
    );
  }
}
