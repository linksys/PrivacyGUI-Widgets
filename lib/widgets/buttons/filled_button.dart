part of 'button.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.excludeSemantics = false,
    this.explicitChildNodes = true,
    this.identifier,
    this.semanticLabel,
  });

  factory AppFilledButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
    bool excludeSemantics = false,
    bool explicitChildNodes = true,
    String? identifier,
    String? semanticLabel,
  }) =>
      AppFilledButton(
        title,
        key: key,
        icon: icon,
        onTap: onTap,
        color: color,
        size: const Size(
          double.infinity,
          -1,
        ),
        explicitChildNodes: explicitChildNodes,
        excludeSemantics: excludeSemantics,
        identifier: identifier,
        semanticLabel: semanticLabel,
      );

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Size? size;
  final Color? color;
  final bool? excludeSemantics;
  final bool explicitChildNodes;
  final String? identifier;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    var applySize = size;
    if (applySize == null || applySize.height == -1) {
      applySize = Size(applySize?.width ?? 64,
          ResponsiveLayout.isMobileLayout(context) ? 48 : 40);
    }
    final style = FilledButton.styleFrom(
      backgroundColor: color,
      // TODO Invisgate why access CustomTheme is not working
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      textStyle: Theme.of(context).textTheme.labelMedium,
      minimumSize: applySize,
    );
    return icon == null
        ? FilledButton(
            onPressed: onTap,
            style: style,
            child: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(
                title,
                semanticsLabel: semanticLabel,
              ),
            ),
          )
        : FilledButton.icon(
            onPressed: onTap,
            style: style,
            icon: Icon(icon),
            label: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(
                title,
                semanticsLabel: semanticLabel,
              ),
            ),
          );
  }
}
