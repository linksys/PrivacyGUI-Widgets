import 'package:flutter/material.dart';

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

  const AppPopupButton({
    Key? key,
    required this.button,
    required this.builder,
    this.borderRadius,
    this.backgroundColor,
    this.verticalPosition = AppPopupVerticalPosition.bottom,
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
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
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
    Overlay.of(context).insert(_overlayEntry);
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
        return GestureDetector(
          onTap: () {
            close();
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0x00000000),
                ),
              ),
              CompositedTransformFollower(
                link: _link,
                targetAnchor: _resloveTargetAlignment(),
                followerAnchor: _resloveFollowerAlignment(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ??
                          Theme.of(context).colorScheme.background,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: _borderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.builder(this),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
