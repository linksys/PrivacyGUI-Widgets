part of 'button.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
    this.color,
  });

  factory AppFilledButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
    Color? color,
  }) =>
      AppFilledButton(title,
          key: key,
          icon: icon,
          onTap: onTap,
          color: color,
          size: const Size(
            double.infinity,
            -1,
          ));

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Size? size;
  final Color? color;

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
            child: Text(title),
          )
        : FilledButton.icon(
            onPressed: onTap,
            style: style,
            icon: Icon(icon),
            label: Text(title),
          );
  }
}
