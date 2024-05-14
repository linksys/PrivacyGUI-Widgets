part of 'button.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton(
    this.title, {
    super.key,
    this.icon,
    this.onTap,
    this.size,
  });

  factory AppElevatedButton.fillWidth(
    String title, {
    Key? key,
    IconData? icon,
    VoidCallback? onTap,
  }) =>
      AppElevatedButton(title,
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
          ResponsiveLayout.isLayoutBreakpoint(context) ? 48 : 40);
    }
    final style = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        textStyle: Theme.of(context).textTheme.labelMedium,
        minimumSize: applySize);
    return icon == null
        ? ElevatedButton(
            onPressed: onTap,
            style: style,
            child: Text(
              title,
            ),
          )
        : ElevatedButton.icon(
            onPressed: onTap,
            icon: Icon(icon),
            style: style,
            label: Text(
              title,
            ),
          );
  }
}
