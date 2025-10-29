import 'dart:math';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';

/// A foundational page widget that provides a [Scaffold] and a body
/// with a custom 12-column responsive grid system.
///
/// It serves as a lower-level layout tool, primarily used by more complex
/// page widgets like `StyledAppPageView` for its non-sliver layouts.
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

  /// Whether to apply the main horizontal page padding (margins) to the content.
  final bool useContentMainPadding;

  /// Whether to display the visual grid overlay for debugging.
  final bool isOverlayVisible;

  /// A callback for pull-to-refresh functionality.
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
          // 1. Build the core grid layout widget.
          Widget view = _GridSystemLayout(
            constraint: constraint,
            child: widget.child,
            padding: widget.padding,
            useContentMainPadding: widget.useContentMainPadding,
            isOverlayVisible: widget.isOverlayVisible,
          );

          // 2. Conditionally wrap it with a scroll view.
          if (widget.scrollable ?? false) {
            view = SingleChildScrollView(
              controller: widget.scrollController,
              physics:
                  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: view,
                ),
              ),
            );
          }

          // 3. Conditionally wrap it with a refresh indicator.
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
}

/// A private widget responsible for rendering the 12-column grid system.
class _GridSystemLayout extends StatelessWidget {
  const _GridSystemLayout({
    required this.constraint,
    this.child,
    this.padding,
    this.useContentMainPadding = true,
    this.isOverlayVisible = false,
  });

  final BoxConstraints constraint;
  final Widget Function(BuildContext context, BoxConstraints constraints)? child;
  final EdgeInsets? padding;
  final bool useContentMainPadding;
  final bool isOverlayVisible;

  @override
  Widget build(BuildContext context) {
    // --- Grid Calculation Logic --- //
    final column = ResponsiveLayout.getColumn(context, 12);
    final remaining = ResponsiveLayout.maxColumn(context) - column;
    final gutter = ResponsiveLayout.columnPadding(context);
    final pagePadding = ResponsiveLayout.pageHorizontalPadding(context);
    final double margin = max(0, pagePadding);

    double totalMarginWidth() => margin * 2;
    int totalColumnCount() => column + remaining;
    double totalGutterWidth() => (totalColumnCount() - 1) * gutter;
    double totalWidthWithoutGutterAndMargin(double totalWidth) =>
        totalWidth - totalGutterWidth() - totalMarginWidth();

    double columnSpanWidth(int columnSpan, double columnWidth) =>
        (columnWidth * columnSpan) + (gutter * (columnSpan - 1));

    double columnWidth(double totalAvailableWidth) =>
        totalWidthWithoutGutterAndMargin(totalAvailableWidth) /
        totalColumnCount();

    final totalAvailableWidth = constraint.maxWidth;
    final widthPerColumn = columnWidth(totalAvailableWidth);
    // --- End of Grid Calculation Logic --- //

    return Stack(
      children: [
        // Main content layout
        if (useContentMainPadding)
          Row(
            children: [
              _Margin(margin: margin),
              SizedBox(
                width: columnSpanWidth(column, widthPerColumn),
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: child?.call(context, constraint),
                ),
              ),
              if (remaining > 0) ...[
                _Gutter(gutter: gutter),
                SizedBox(
                  width: columnSpanWidth(remaining, widthPerColumn),
                  child: const Center(),
                ),
              ],
              _Margin(margin: margin),
            ],
          )
        else
          // Note: This Expanded might cause issues if the parent doesn't provide bounded width.
          Expanded(
            child: child?.call(context, constraint) ?? const SizedBox.shrink(),
          ),

        // Debug overlay to visualize the grid.
        if (isOverlayVisible)
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
}

//region Grid Debug Widgets
// These are helper widgets used only for visualizing the grid system when isOverlayVisible is true.
//----------------------------------------------------------------------------

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

//endregion