import 'dart:math';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';

class AppPageView extends StatefulWidget {
  final LinksysAppBar? appBar;
  final Widget Function(BuildContext context, BoxConstraints constraints)? child;
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
  // Column system
  final bool useContentMainPadding;
  final bool isOverlayVisible;

  // AppPageView.bottomSheetModal({
  //   Key? key,
  //   required this.bottomSheet,
  //   this.padding,
  //   this.scrollable = false,
  //   this.scrollController,
  //   this.background,
  //   this.floatingActionButton,
  //   this.floatingActionButtonAnimator,
  //   this.floatingActionButtonLocation,
  //   this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
  //   this.useContentMainPadding = true,
  //   this.isOverlayVisible = false,
  // })  : appBar = LinksysAppBar(
  //         toolbarHeight: 150,
  //       ),
  //       child = BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //       ),
  //       bottomNavigationBar = null,
  //       super(key: key);

  // AppPageView.bottomSheetModalBlur({
  //   Key? key,
  //   required this.bottomSheet,
  //   this.padding,
  //   this.scrollable = false,
  //   this.scrollController,
  //   this.floatingActionButton,
  //   this.floatingActionButtonAnimator,
  //   this.floatingActionButtonLocation,
  //   this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
  //   this.useContentMainPadding = true,
  //   this.isOverlayVisible = false,
  // })  : appBar = LinksysAppBar(
  //         toolbarHeight: 150,
  //       ),
  //       child = BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  //         child: Container(),
  //       ),
  //       bottomNavigationBar = null,
  //       background = Colors.black.withOpacity(0.4),
  //       super(key: key);

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
    this.useContentMainPadding = true,
    this.isOverlayVisible = false,
  }) : super(key: key);

  @override
  State<AppPageView> createState() => _AppPageViewState();
}

class _AppPageViewState extends State<AppPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.background,
      appBar: widget.appBar,
      body: SafeArea(
        left: widget.enableSafeArea.left,
        top: widget.enableSafeArea.top,
        right: widget.enableSafeArea.right,
        bottom: widget.enableSafeArea.bottom,
        child: LayoutBuilder(builder: (context, constraint) {
          return (widget.scrollable ?? false)
              ? _scrollableView(constraint)
              : _view(constraint);
        }),
      ),
      bottomSheet: widget.bottomSheet,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }

  Widget _view(BoxConstraints constraint) {
    final column = ResponsiveLayout.getColumn(context, 12);
    final remaining = ResponsiveLayout.maxColumn(context) - column;
    final centered = true;
    // remaining > 1 && this.centered == true;
    final gutter = ResponsiveLayout.columnPadding(context);
    final padding = ResponsiveLayout.pageHorizontalPadding(context);
    final double margin = max(0, padding);

    ///
    double _totalMarginWidth() => margin * 2;

    int _totalColumnCount() => column + remaining;
    double _totalGutterWidth() => (_totalColumnCount() - 1) * gutter;
    double _totalWidthWithoutGutterAndMargin(double totalWidth) =>
        totalWidth - _totalGutterWidth() - _totalMarginWidth();

    double _columnSpanWidth(int columnSpan, double columnWidth) =>
        (columnWidth * columnSpan) + (gutter * (columnSpan - 1));

    /// Returns the width of a single column.
    double columnWidth(double totalAvailableWidth) =>
        _totalWidthWithoutGutterAndMargin(totalAvailableWidth) /
        _totalColumnCount();

    final totalAvailableWidth = constraint.maxWidth;
    final widthPerColumn = columnWidth(totalAvailableWidth);

    // return WoltResponsiveLayoutGrid(
    //   isOverlayVisible: false,
    //   gutter: ResponsiveLayout.columnPadding(context),
    //   columnSpanCells: [
    //     WoltColumnSpanCell(
    //       columnCellWidget: widget.child ?? Center(),
    //       columnSpan: column,
    //     ),
    //     // if (remaining > 0)
    //     //   WoltColumnSpanCell(
    //     //     columnCellWidget: const Center(),
    //     //     columnSpan: remaining,
    //     //   ),
    //   ],
    //   // margin: ResponsiveLayout.pageHorizontalPadding(context),
    //   margin: max(0, padding),
    // );
    return  Stack(
      children: [
        widget.useContentMainPadding ? Row(
          children: [
            if (widget.useContentMainPadding) _Margin(margin: margin),
            SizedBox(
              width: _columnSpanWidth(column, widthPerColumn),
              child: Padding(
                padding: widget.padding ?? EdgeInsets.zero,
                child: widget.child?.call(context, constraint),
              ),
            ),
            if (remaining > 0) ...[
              _Gutter(gutter: gutter),
              SizedBox(
                width: _columnSpanWidth(remaining, widthPerColumn),
                child: Center(),
              ),
            ],
            if (widget.useContentMainPadding) _Margin(margin: margin),
          ],
        ): Expanded(child: widget.child?.call(context, constraint) ?? SizedBox.shrink()),
        if (widget.isOverlayVisible)
          Row(
            children: [
              _Margin(margin: margin, isOverlay: true),
              for (int i = 0; i < _totalColumnCount(); i++)
                Row(children: [
                  _Column(columnWidth: widthPerColumn, isOverlay: true),
                  if (i != _totalColumnCount() - 1)
                    _Gutter(gutter: gutter, isOverlay: true),
                ]),
              _Margin(margin: margin, isOverlay: true),
            ],
          ),
      ],
    ) ;
  }

  Widget _scrollableView(BoxConstraints constraint) {
    return ScrollNotificationObserver(
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraint.maxHeight,
          ),
          child: IntrinsicHeight(
            child: _view(constraint),
          ),
        ),
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({
    required this.columnWidth,
    this.isOverlay = false,
  });

  final double columnWidth;
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isOverlay ? Colors.red.withOpacity(0.2) : Colors.transparent,
      child: SizedBox(width: columnWidth, height: double.infinity),
    );
  }
}

class _Margin extends StatelessWidget {
  const _Margin({
    required this.margin,
    this.isOverlay = false,
  });

  final double margin;
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isOverlay ? Colors.green.withOpacity(0.2) : Colors.transparent,
      child: SizedBox(width: margin, height: double.infinity),
    );
  }
}

class _Gutter extends StatelessWidget {
  const _Gutter({
    required this.gutter,
    this.isOverlay = false,
  });

  final double gutter;
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isOverlay ? Colors.cyan.withOpacity(0.2) : Colors.transparent,
      child: SizedBox(width: gutter, height: double.infinity),
    );
  }
}
