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
    this.explicitChildNodes = false,
    this.identifier,
    this.semanticLabel,
    this.radius,
    this.textStyle,
  });

  factory AppFilledButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
    bool excludeSemantics = false,
    bool explicitChildNodes = false,
    String? identifier,
    String? semanticLabel,
    BorderRadius? radius,
    TextStyle? textStyle,
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
        radius: radius,
        textStyle: textStyle,
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
  final BorderRadius? radius;
  final TextStyle? textStyle;

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
      shape: RoundedRectangleBorder(
        borderRadius: radius ?? BorderRadius.all(Radius.zero),
      ),
      textStyle: textStyle ?? Theme.of(context).textTheme.labelMedium,
      // minimumSize: applySize,
      fixedSize: applySize,
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
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
