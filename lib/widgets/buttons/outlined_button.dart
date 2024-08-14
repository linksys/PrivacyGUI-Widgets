part of 'button.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.excludeSemantics = true,
    this.explicitChildNodes = true,
    this.identifier,
  });

  factory AppOutlinedButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    Color? color,
    VoidCallback? onTap,
    bool excludeSemantics = true,
    bool explicitChildNodes = true,
    String? identifier,
  }) =>
      AppOutlinedButton(
        title,
        key: key,
        icon: icon,
        color: color,
        onTap: onTap,
        size: const Size(
          double.infinity,
          -1,
        ),
        explicitChildNodes: explicitChildNodes,
        excludeSemantics: excludeSemantics,
        identifier: identifier,
      );

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Size? size;
  final Color? color;
  final bool? excludeSemantics;
  final bool explicitChildNodes;
  final String? identifier;

  @override
  Widget build(BuildContext context) {
    var applySize = size;
    if (applySize == null || applySize.height == -1) {
      applySize = Size(applySize?.width ?? 64,
          ResponsiveLayout.isMobileLayout(context) ? 48 : 40);
    }
    final style = OutlinedButton.styleFrom(
        side: color == null
            ? null
            : BorderSide(color: color ?? Theme.of(context).colorScheme.outline),
        shape: const RoundedRectangleBorder(
          // TODO Invisgate why access CustomTheme is not working
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        textStyle: Theme.of(context).textTheme.labelMedium,
        foregroundColor: color,
        minimumSize: applySize);
    return icon == null
        ? OutlinedButton(
            onPressed: onTap,
            style: style,
            child: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(
                title,
              ),
            ),
          )
        : OutlinedButton.icon(
            onPressed: onTap,
            icon: Icon(icon),
            style: style,
            label: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(
                title,
              ),
            ),
          );
  }
}
