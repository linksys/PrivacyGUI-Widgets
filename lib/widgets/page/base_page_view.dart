import 'dart:math';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';

class AppPageView extends StatefulWidget {
  final LinksysAppBar? appBar;
  final Widget Function(BuildContext context, BoxConstraints constraints)?
      child;
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
  final Future<void> Function()? onRefresh;

  const AppPageView({
    Key? key,
    this.appBar,
    this.child,
    this.padding,
    this.scrollable = false,
    this.scrollController,
    this.onRefresh,
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
          final view = widget.scrollable ?? false
              ? _scrollableView(constraint)
              : _view(constraint);
          final refreshHandler = widget.onRefresh;
          return refreshHandler != null
              ? RefreshIndicator(
                  onRefresh: refreshHandler,
                  child: view,
                )
              : view;
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
    final gutter = ResponsiveLayout.columnPadding(context);
    final padding = ResponsiveLayout.pageHorizontalPadding(context);
    final double margin = max(0, padding);

    ///
    double totalMarginWidth() => margin * 2;

    int totalColumnCount() => column + remaining;
    double totalGutterWidth() => (totalColumnCount() - 1) * gutter;
    double totalWidthWithoutGutterAndMargin(double totalWidth) =>
        totalWidth - totalGutterWidth() - totalMarginWidth();

    double columnSpanWidth(int columnSpan, double columnWidth) =>
        (columnWidth * columnSpan) + (gutter * (columnSpan - 1));

    /// Returns the width of a single column.
    double columnWidth(double totalAvailableWidth) =>
        totalWidthWithoutGutterAndMargin(totalAvailableWidth) /
        totalColumnCount();

    final totalAvailableWidth = constraint.maxWidth;
    final widthPerColumn = columnWidth(totalAvailableWidth);

    return Stack(
      children: [
        widget.useContentMainPadding
            ? Row(
                children: [
                  if (widget.useContentMainPadding) _Margin(margin: margin),
                  SizedBox(
                    width: columnSpanWidth(column, widthPerColumn),
                    child: Padding(
                      padding: widget.padding ?? EdgeInsets.zero,
                      child: widget.child?.call(context, constraint),
                    ),
                  ),
                  if (remaining > 0) ...[
                    _Gutter(gutter: gutter),
                    SizedBox(
                      width: columnSpanWidth(remaining, widthPerColumn),
                      child: Center(),
                    ),
                  ],
                  if (widget.useContentMainPadding) _Margin(margin: margin),
                ],
              )
            : Expanded(
                child: widget.child?.call(context, constraint) ??
                    SizedBox.shrink()),
        if (widget.isOverlayVisible)
          Row(
            children: [
              _Margin(margin: margin, isOverlay: true),
              for (int i = 0; i < totalColumnCount(); i++)
                Row(children: [
                  _Column(columnWidth: widthPerColumn, isOverlay: true),
                  if (i != totalColumnCount() - 1)
                    _Gutter(gutter: gutter, isOverlay: true),
                ]),
              _Margin(margin: margin, isOverlay: true),
            ],
          ),
      ],
    );
  }

  Widget _scrollableView(BoxConstraints constraint) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraint.maxHeight,
        ),
        child: IntrinsicHeight(
          child: _view(constraint),
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
