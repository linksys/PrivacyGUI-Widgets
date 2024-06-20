import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

const double _leftPadding = 24;
const double _levelOfPadding = 0;
const double _leadingPadding = 24;

class AppTreeNodeItem extends StatelessWidget {
  final ImageProvider? image;
  final Widget? tail;
  final String name;
  final String? status;
  final VoidCallback? onTap;
  final Color? background;

  const AppTreeNodeItem({
    super.key,
    this.tail,
    required this.name,
    this.status = '',
    this.image,
    this.onTap,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: background ?? Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: CustomTheme.of(context).radius.asBorderRadius().large,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomTheme.of(context).radius.asBorderRadius().large,
        child: Container(
          constraints:
              const BoxConstraints(minWidth: 180, maxWidth: 300, maxHeight: 84),
          padding: const EdgeInsets.all(Spacing.medium),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Image(
                    image: image ??
                        CustomTheme.of(context).images.devices.routerLn11,
                    width: 64,
                    height: 64,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleMedium(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (status != null) AppText.bodySmall(status!)
                  ],
                ),
              ),
              // AppIcon.regular(icon: node.isMaster
              //     ? getCharactersIcons(context).ethernetDefault
              //     : getCharactersIcons(context).wifiDefault,)
              if (tail != null) tail!,
            ],
          ),
        ),
      ),
    );
  }
}

class AppTreeNodeItemLarge extends StatelessWidget {
  final ImageProvider? image;
  final Widget? tail;
  final String name;
  final String? status;
  final VoidCallback? onTap;
  final Color? background;

  const AppTreeNodeItemLarge({
    super.key,
    this.tail,
    required this.name,
    this.status = '',
    this.image,
    this.onTap,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: background ?? Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: CustomTheme.of(context).radius.asBorderRadius().large,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomTheme.of(context).radius.asBorderRadius().large,
        child: Container(
          width: 250,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image:
                    image ?? CustomTheme.of(context).images.devices.routerLn11,
                width: 80,
                height: 80,
              ),
              const AppGap.medium(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.titleMedium(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (status != null) AppText.bodySmall(status!)
                      ],
                    ),
                  ),
                  const AppGap.medium(),
                  if (tail != null) tail!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderInfoCell extends StatefulWidget {
  final IconData? icon;
  final String name;
  final Color? lineColor;
  final bool showConnector;
  final double? width;

  const BorderInfoCell({
    super.key,
    this.name = "INTERNET",
    this.showConnector = true,
    this.icon,
    this.lineColor,
    this.width,
  });

  @override
  State<BorderInfoCell> createState() => _BorderInfoCellState();
}

class _BorderInfoCellState extends State<BorderInfoCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: widget.width,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              color: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).colorSchemeExt.primaryFixedDim ??
                        Theme.of(context).colorScheme.outline),
                borderRadius:
                    CustomTheme.of(context).radius.asBorderRadius().extraLarge,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Spacing.medium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const AppGap.medium(),
                    ],
                    AppText.bodyLarge(widget.name),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoCell extends StatefulWidget {
  final IconData? icon;
  final String name;
  final Color? lineColor;
  final bool showConnector;

  const InfoCell({
    super.key,
    this.name = "INTERNET",
    this.showConnector = true,
    this.icon,
    this.lineColor,
  });

  @override
  State<InfoCell> createState() => _InfoCellState();
}

class _InfoCellState extends State<InfoCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24.0),
      child: Row(
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
            const AppGap.medium(),
          ],
          AppText.titleMedium(widget.name),
        ],
      ),
    );
  }
}

class AppTreeNodeCell extends StatefulWidget {
  final Widget child;
  final int level;
  final int index;
  final bool isLast;
  final List<bool> isParentLastArray;
  final bool showConnectionLine;
  final Color? lineColor;

  const AppTreeNodeCell({
    super.key,
    required this.child,
    this.level = 0,
    this.index = 0,
    this.isLast = false,
    required this.isParentLastArray,
    this.showConnectionLine = true,
    this.lineColor,
  });

  @override
  State<AppTreeNodeCell> createState() => _AppTreeNodeCellState();
}

class _AppTreeNodeCellState extends State<AppTreeNodeCell> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showConnectionLine && widget.level > 0)
          ...List<int>.generate(widget.level - 1, (level) => level + 1).map(
            (e) => Container(
              padding: EdgeInsets.only(
                  left: (e == 1 ? 0 : _levelOfPadding) + _leftPadding),
              child: CustomPaint(
                painter: _PathPainter(
                  color:
                      widget.lineColor ?? Theme.of(context).colorScheme.outline,
                  type: e == (widget.level - 1)
                      ? (widget.isLast ? _PathType.last : _PathType.middle)
                      : (widget.isParentLastArray[e + 1]
                          ? _PathType.none
                          : _PathType.vertical),
                ),
                child: Container(
                  width: _leadingPadding,
                ),
              ),
            ),
          ),
        if (widget.level == 0)
          Expanded(
              // width: MediaQuery.of(context).size.width - _leadingPadding - 10,
              child: widget.child),
        if (widget.level > 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: _leftPadding),
                child: widget.level == 1 && widget.showConnectionLine
                    ? CustomPaint(
                        painter: _PathPainter(
                            color: widget.lineColor ??
                                Theme.of(context).colorScheme.outline,
                            type: _PathType.vertical),
                        child: Container(
                          width: _leadingPadding,
                          height: 12,
                        ),
                      )
                    : Container(
                        width: _leadingPadding,
                        height: 12,
                      ),
              ),
              widget.child,
            ],
          ),
        // if (widget.level > 1) widget.child
      ],
    );
  }
}

enum _PathType {
  none,
  vertical,
  middle,
  last;
}

class _PathPainter extends CustomPainter {
  static const double defaultDeltaY = -9;
  static const double defaultDeltaX = 5;

  final _PathType type;
  final Color color;
  final double strokeWidth;
  final double deltaX;
  final double deltaY;
  _PathPainter({
    this.type = _PathType.none,
    this.color = Colors.black,
    this.strokeWidth = 1,
    this.deltaX = defaultDeltaX,
    this.deltaY = defaultDeltaY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    switch (type) {
      case _PathType.last:
        canvas.drawLine(Offset(center.width, deltaY),
            Offset(center.width, center.height), paint);
        canvas.drawLine(Offset(center.width, center.height),
            Offset(size.width + deltaX, center.height), paint);
        break;
      case _PathType.middle:
        canvas.drawLine(Offset(center.width, deltaY),
            Offset(center.width, size.height), paint);
        canvas.drawLine(Offset(center.width, center.height),
            Offset(size.width, center.height), paint);
        break;
      case _PathType.vertical:
        canvas.drawLine(Offset(center.width, deltaY),
            Offset(center.width, size.height), paint);
        break;
      case _PathType.none:
      default:
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
