import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';

enum AppPopupVerticalPosition {
  top(-1.0),
  bottom(1.0),
  ;

  final double value;
  const AppPopupVerticalPosition(this.value);
}

class AppPopupButtonController {
  void open() {}
  void close() {}
  void markNeedBuilds() {}
}

class AppPopupButton extends StatefulWidget {
  final Widget button;
  final Widget Function(AppPopupButtonController) builder;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final AppPopupVerticalPosition verticalPosition;
  final BuildContext? parent;
  final double? maxWidth;
  final double? maxHeight;

  const AppPopupButton({
    Key? key,
    required this.button,
    required this.builder,
    this.borderRadius,
    this.backgroundColor,
    this.verticalPosition = AppPopupVerticalPosition.bottom,
    this.parent,
    this.maxWidth = 500,
    this.maxHeight,
  }) : super(key: key);

  @override
  PopupButtonState createState() => PopupButtonState();
}

class PopupButtonState extends State<AppPopupButton>
    with SingleTickerProviderStateMixin
    implements AppPopupButtonController {
  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late BorderRadius _borderRadius;
  late AnimationController _animationController;

  final _link = LayerLink();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ??
        CustomTheme.of(context).radius.asBorderRadius().small;
    _key = LabeledGlobalKey("${widget.button.hashCode}");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(
      Offset.zero,
    );
  }

  @override
  void close() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  @override
  void open() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(widget.parent ?? context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      decoration: BoxDecoration(
        color: const Color(0x00000000),
        borderRadius: _borderRadius,
      ),
      child: InkWell(
        child: CompositedTransformTarget(
          link: _link,
          child: AbsorbPointer(child: widget.button),
        ),
        onTap: () {
          if (isMenuOpen) {
            close();
          } else {
            open();
          }
        },
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0x66000000),
              ),
              child: GestureDetector(
                onTap: () {
                  close();
                },
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              targetAnchor: _resloveTargetAlignment(),
              followerAnchor: _resloveFollowerAlignment(),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight:
                            widget.maxHeight ?? constraints.maxHeight * 0.7,
                        maxWidth:
                            widget.maxWidth ?? constraints.maxWidth * 0.7),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.backgroundColor ??
                              Theme.of(context).colorScheme.background,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: _borderRadius,
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: widget.builder(this)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // new function to calculate popup position
  RelativeRect _calculatePopupPosition(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonRect = _key.currentContext?.findRenderObject() as RenderBox;
    final buttonPosition = buttonRect.localToGlobal(Offset.zero);
    final buttonSize = buttonRect.size;

    final availableHeight = screenSize.height;
    final availableWidth = screenSize.width;

    final verticalOffset = 8.0;
    final horizontalOffset = 0.0;

    final double popupWidth = widget.maxWidth ?? availableWidth * 0.7;
    final double popupHeight = widget.maxHeight ?? availableHeight * 0.7;

    double left = buttonPosition.dx;
    double top = buttonPosition.dy;

    if (widget.verticalPosition == AppPopupVerticalPosition.bottom) {
      top += buttonSize.height + verticalOffset;
    } else {
      top -= popupHeight + verticalOffset;
    }

    if ((left + popupWidth) > availableWidth) {
      left = availableWidth - popupWidth - horizontalOffset;
    } else if (left < horizontalOffset) {
      left = horizontalOffset;
    }

    return RelativeRect.fromLTRB(
        left, top, availableWidth - (left + popupWidth), 0);
  }

  Alignment _resloveTargetAlignment() {
    final screenSize = MediaQuery.of(context).size;
    double maxWidth = screenSize.width / 2;
    bool rEdge = buttonPosition.dx + maxWidth > screenSize.width;
    return Alignment(rEdge ? 1.0 : -1.0, widget.verticalPosition.value);
  }

  Alignment _resloveFollowerAlignment() {
    final screenSize = MediaQuery.of(context).size;
    double maxWidth = screenSize.width / 2;
    bool rEdge = buttonPosition.dx + maxWidth > screenSize.width;
    return Alignment(rEdge ? 1.0 : -1.0, -1 * widget.verticalPosition.value);
  }

  @override
  void markNeedBuilds() {
    _overlayEntry.markNeedsBuild();
  }
}
