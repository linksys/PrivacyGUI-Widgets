part of 'button.dart';

class AppTonalButton extends StatelessWidget {
  const AppTonalButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
    this.excludeSemantics = true,
    this.explicitChildNodes = true,
    this.identifier,
  });

  factory AppTonalButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    bool excludeSemantics = true,
    bool explicitChildNodes = true,
    String? identifier,
  }) =>
      AppTonalButton(
        title,
        key: key,
        icon: icon,
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
    final style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: CustomTheme.of(context).radius.asBorderRadius().none,
      ),
      textStyle: Theme.of(context).textTheme.labelMedium,
      minimumSize: applySize,
    );
    return icon == null
        ? FilledButton.tonal(
            onPressed: onTap,
            style: style,
            child: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(title),
            ),
          )
        : FilledButton.tonalIcon(
            onPressed: onTap,
            icon: Icon(icon),
            style: style,
            label: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(title),
            ),
          );
  }
}
