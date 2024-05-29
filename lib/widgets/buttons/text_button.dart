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
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Size? size;
  final EdgeInsets? padding;
  final Color? color;

  factory AppTextButton.noPadding(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
  }) =>
      AppTextButton(
        title,
        key: key,
        icon: icon,
        onTap: onTap,
        padding: const EdgeInsets.only(),
        size: Size.zero,
        color: color,
      );

  factory AppTextButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
  }) =>
      AppTextButton(title,
          key: key,
          icon: icon,
          onTap: onTap,
          color: color,
          size: const Size(
            double.infinity,
            -1,
          ));

  @override
  Widget build(BuildContext context) {
    var applySize = size;
    if (applySize == null || applySize.height == -1) {
      applySize = Size(applySize?.width ?? 64,
          ResponsiveLayout.isMobileLayout(context) ? 48 : 40);
    }
    final style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
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
            child: Text(title),
          )
        : TextButton.icon(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: color,
            ),
            style: style,
            label: Text(title),
          );
  }
}
