import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';

class AppPageView extends StatelessWidget {
  final LinksysAppBar? appBar;
  final Widget? child;
  final EdgeInsets? padding;
  final bool? scrollable;
  final ScrollController? scrollController;
  final Color? background;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final ({bool left, bool top, bool right, bool bottom}) enableSafeArea;

  // const AppPageView.noNavigationBar({
  //   Key? key,
  //   this.child,
  //   this.padding = _containerPadding,
  //   this.scrollable = false,
  //   this.bottomNavigationBar,
  //   this.floatingActionButton,
  //   this.floatingActionButtonAnimator,
  //   this.floatingActionButtonLocation,
  //   this.background,
  //   this.controller,
  //   this.useSafeArea = true,
  // })  : appBar = null,
  //       bottomSheet = null,
  //       super(key: key);

  // const AppPageView.noPadding({
  //   Key? key,
  //   this.child,
  //   this.scrollable = false,
  //   this.bottomNavigationBar,
  //   this.floatingActionButton,
  //   this.floatingActionButtonAnimator,
  //   this.floatingActionButtonLocation,
  //   this.background,
  //   this.controller,
  //   this.useSafeArea = true,
  // })  : appBar = null,
  //       bottomSheet = null,
  //       padding = _noPadding,
  //       super(key: key);

  AppPageView.bottomSheetModal({
    Key? key,
    required this.bottomSheet,
    this.padding,
    this.scrollable = false,
    this.scrollController,
    this.background,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
  })  : appBar = LinksysAppBar(
          toolbarHeight: 150,
        ),
        child = BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        ),
        bottomNavigationBar = null,
        super(key: key);

  AppPageView.bottomSheetModalBlur({
    Key? key,
    required this.bottomSheet,
    this.padding,
    this.scrollable = false,
    this.scrollController,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
  })  : appBar = LinksysAppBar(
          toolbarHeight: 150,
        ),
        child = BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(),
        ),
        bottomNavigationBar = null,
        background = Colors.black.withOpacity(0.4),
        super(key: key);

  const AppPageView({
    Key? key,
    this.appBar,
    this.child,
    this.padding,
    this.scrollable = false,
    this.scrollController,
    this.background,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appBar,
      body: SafeArea(
        left: enableSafeArea.left,
        top: enableSafeArea.top,
        right: enableSafeArea.right,
        bottom: enableSafeArea.bottom,
        child: (scrollable ?? false) ? _scrollableView() : _view(),
      ),
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }

  Widget _view() {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }

  Widget _scrollableView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: _view(),
            ),
          ),
        );
      },
    );
  }
}
