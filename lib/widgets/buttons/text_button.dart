part of 'button.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
    this.padding,
    this.color,
    this.excludeSemantics = true,
    this.explicitChildNodes = true,
    this.identifier,
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Size? size;
  final EdgeInsets? padding;
  final Color? color;
  final bool? excludeSemantics;
  final bool explicitChildNodes;
  final String? identifier;

  factory AppTextButton.noPadding(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
    bool excludeSemantics = true,
    bool explicitChildNodes = true,
    String? identifier,
  }) =>
      AppTextButton(
        title,
        key: key,
        icon: icon,
        onTap: onTap,
        padding: const EdgeInsets.only(),
        size: Size.zero,
        color: color,
        explicitChildNodes: explicitChildNodes,
        excludeSemantics: excludeSemantics,
        identifier: identifier,
      );

  factory AppTextButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
    bool excludeSemantics = true,
    bool explicitChildNodes = true,
    String? identifier,
  }) =>
      AppTextButton(
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
      );

  @override
  Widget build(BuildContext context) {
    var applySize = size;
    if (applySize == null || applySize.height == -1) {
      applySize = Size(applySize?.width ?? 64,
          ResponsiveLayout.isMobileLayout(context) ? 48 : 40);
    }
    final style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: CustomTheme.of(context).radius.asBorderRadius().none,
      ),
      foregroundColor: color,
      textStyle:
          Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
      minimumSize: applySize,
      padding: padding,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    return icon == null
        ? TextButton(
            onPressed: onTap,
            style: style,
            child: Semantics(
                explicitChildNodes: explicitChildNodes,
                excludeSemantics:
                    excludeSemantics ?? (identifier == null ? false : true),
                identifier: identifier,
                child: Text(title)),
          )
        : TextButton.icon(
            onPressed: onTap,
            icon: Semantics(
                explicitChildNodes: explicitChildNodes,
                excludeSemantics:
                    excludeSemantics ?? (identifier == null ? false : true),
                identifier: identifier,
                child: Icon(
                  icon,
                  color: color,
                )),
            style: style,
            label: Semantics(
              explicitChildNodes: explicitChildNodes,
              excludeSemantics:
                  excludeSemantics ?? (identifier == null ? false : true),
              identifier: identifier,
              child: Text(title),
            ));
  }
}
