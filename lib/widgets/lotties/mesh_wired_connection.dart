import 'package:flutter/material.dart';
import 'package:privacygui_widgets/utils/lottie.dart';
import 'package:lottie/lottie.dart';

class AppMeshWiredConnection extends StatelessWidget {
  final Size? size;
  final String? semanticLabel;

  const AppMeshWiredConnection({
    Key? key,
    this.size,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0xf0),
      width: size?.width ?? 300,
      height: size?.height ?? 200,
      child: Semantics(
        label: semanticLabel,
        child: Center(
          child: Lottie.asset(
            'assets/lottie/mesh_wired_connection.lottie',
            decoder: customDecoder,
            package: 'privacygui_widgets',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
