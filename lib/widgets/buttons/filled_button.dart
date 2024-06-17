part of 'button.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
  });

  factory AppFilledButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
  }) =>
      AppFilledButton(title,
          key: key,
          icon: icon,
          onTap: onTap,
          size: const Size(
            double.infinity,
            -1,
          ));

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    var applySize = size;
    if (applySize == null || applySize.height == -1) {
      applySize = Size(applySize?.width ?? 64,
          ResponsiveLayout.isMobileLayout(context) ? 48 : 40);
    }
    final style = FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: CustomTheme.of(context).radius.asBorderRadius().none,
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
