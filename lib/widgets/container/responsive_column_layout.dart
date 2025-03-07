import 'dart:math';

import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

class AppResponsiveColumnLayout extends StatelessWidget {
  final int? column;
  final bool centered;
  final Widget? topWidget;
  final Widget? bottomWidget;
  final bool isShowNaviRail;
  final Widget Function() builder;
  final bool showColumnOverlay;

  const AppResponsiveColumnLayout({
    super.key,
    this.column,
    required this.centered,
    required this.isShowNaviRail,
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

    final padding = ResponsiveLayout.pageHorizontalPadding(context);

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
                    margin: max(0, padding),
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
                    margin: max(0, padding),
                  ),
          ),
          if (bottomWidget != null) bottomWidget!,
        ],
      ),
    );
  }
}
