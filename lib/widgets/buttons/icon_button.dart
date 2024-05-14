part of 'button.dart';

enum _AppIconButtonStyle {
  normal,
  filled,
  outlined,
  tonal;
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        _style = _AppIconButtonStyle.normal,
        super(key: key);

  const AppIconButton.noPadding({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        padding = const EdgeInsets.all(0),
        _style = _AppIconButtonStyle.normal,
        super(key: key);

  const AppIconButton.filled({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        _style = _AppIconButtonStyle.filled,
        super(key: key);

  const AppIconButton.noPaddingFilled({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        padding = const EdgeInsets.all(0),
        _style = _AppIconButtonStyle.filled,
        super(key: key);

  const AppIconButton.outlined({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        _style = _AppIconButtonStyle.outlined,
        super(key: key);

  const AppIconButton.noPaddingOutlined({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        padding = const EdgeInsets.all(0),
        _style = _AppIconButtonStyle.outlined,
        super(key: key);

  const AppIconButton.tonal({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        _style = _AppIconButtonStyle.tonal,
        super(key: key);

  const AppIconButton.noPaddingTonal({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
    this.mainAxisSize = MainAxisSize.min,
    this.alignment,
  })  : assert(
          icon != null,
        ),
        padding = const EdgeInsets.all(0),
        _style = _AppIconButtonStyle.tonal,
        super(key: key);

  final IconData? icon;
  final Color? color;
  final MainAxisSize mainAxisSize;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final _AppIconButtonStyle _style;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    switch (_style) {
      case _AppIconButtonStyle.normal:
        return IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: color,
          ),
          padding: padding,
          alignment: alignment,
          constraints: const BoxConstraints(),
          style: IconButton.styleFrom(
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
          ),
        );
      case _AppIconButtonStyle.outlined:
        return IconButton.outlined(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: color,
          ),
          padding: padding,
        );
      case _AppIconButtonStyle.filled:
        return IconButton.filled(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: color,
          ),
          padding: padding,
        );
      case _AppIconButtonStyle.tonal:
        return IconButton.filledTonal(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: color,
          ),
          padding: padding,
        );
    }
  }
}