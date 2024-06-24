import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

class AppResponsiveColumnLayout extends StatelessWidget {
  final int? column;
  final bool centered;
  final Widget? topWidget;
  final Widget? bottomWidget;

  final Widget Function() builder;
  final bool showColumnOverlay;

  const AppResponsiveColumnLayout({
    super.key,
    this.column,
    required this.centered,
    this.topWidget,
    this.bottomWidget,
    required this.builder,
    this.showColumnOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final column = ResponsiveLayout.getColumn(context, this.column);
    final remaining = ResponsiveLayout.maxColumn(context) - column;
    final centered = remaining > 1 && this.centered == true;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = (screenWidth -
            (ResponsiveLayout.maxColumn(context) *
                ResponsiveLayout.columnSize(context)) -
            (ResponsiveLayout.columnPadding(context) *
                (ResponsiveLayout.maxColumn(context) - 1))) /
        2;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topWidget != null) topWidget!,
          Expanded(
            child: centered
                ? WoltResponsiveLayoutGrid.centered(
                    isOverlayVisible: showColumnOverlay,
                    gutter: ResponsiveLayout.columnPadding(context),
                    // margin: ResponsiveLayout.pageHorizontalPadding(context),
                    margin: padding,
                    paddedColumnCountPerSide: remaining ~/ 2,
                    centerWidgetColumnCount: column,
                    child: builder(),
                  )
                : WoltResponsiveLayoutGrid(
                    isOverlayVisible: showColumnOverlay,
                    gutter: ResponsiveLayout.columnPadding(context),
                    columnSpanCells: [
                      WoltColumnSpanCell(
                        columnCellWidget: builder(),
                        columnSpan: column,
                      ),
                      if (remaining > 0)
                        WoltColumnSpanCell(
                          columnCellWidget: const Center(),
                          columnSpan: remaining,
                        ),
                    ],
                    // margin: ResponsiveLayout.pageHorizontalPadding(context),
                    margin: padding,
                  ),
          ),
          if (bottomWidget != null) bottomWidget!,
        ],
      ),
    );
  }
}
