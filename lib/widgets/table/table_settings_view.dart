import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppTableSettingsView<T> extends StatefulWidget {
  final String? title;
  final List<String> headers;
  final TextStyle? headerStyle;
  final Map<int, TableColumnWidth>? columnWidths;
  final List<T> dataList;
  final Widget? emptyView;
  final Widget Function(BuildContext, int, T) cellBuilder;
  final Widget Function(BuildContext, int, T)? editCellBuilder;

  final int? editRowIndex;
  final Widget? bottomWidget;

  const AppTableSettingsView({
    super.key,
    this.title,
    required this.headers,
    this.headerStyle,
    this.columnWidths,
    this.dataList = const [],
    required this.cellBuilder,
    this.editCellBuilder,
    this.editRowIndex,
    this.bottomWidget,
    this.emptyView,
  });

  @override
  State<AppTableSettingsView<T>> createState() => _AppTableSettingsViewState();
}

class _AppTableSettingsViewState<T> extends State<AppTableSettingsView<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            _titleWidget(),
            const AppGap.medium(),
          ],
          _desktopTableWidget(),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return AppText.titleSmall(widget.title!);
  }

  Widget _desktopTableWidget() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            columnWidths: widget.columnWidths ??
                Map.fromEntries(widget.headers
                    .mapIndexed(
                        (index, _) => MapEntry(index, FlexColumnWidth()))
                    .toList()),
            children: [
              if (widget.emptyView == null || widget.dataList.isNotEmpty)
                ..._dataListTableRows(),
            ],
          ),
          if (widget.emptyView != null && widget.dataList.isEmpty) _empty(),
          if (widget.bottomWidget != null) _bottom(),
        ],
      ),
    );
  }

  List<TableRow> _dataListTableRows() {
    return [
      TableRow(
        children: [
          ...widget.headers
              .map((e) => TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.all(Spacing.small2),
                    color: Theme.of(context).colorScheme.surface,
                    child: Center(
                        child: Text(e,
                            textAlign: TextAlign.center,
                            style: widget.headerStyle ??
                                Theme.of(context).textTheme.labelLarge)),
                  )))
              .toList()
        ],
      ),
      ...widget.dataList
          .mapIndexed(
            (rowIndex, e) => TableRow(
              children: widget.headers
                  .mapIndexed(
                    (cellIndex, _) => TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.all(Spacing.small2),
                        child: Center(
                          child: widget.editRowIndex == rowIndex
                              ? widget.editCellBuilder
                                      ?.call(context, cellIndex, e) ??
                                  widget.cellBuilder(context, cellIndex, e)
                              : widget.cellBuilder(context, cellIndex, e),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    ];
  }

  Widget _empty() {
    return Table(
        border: TableBorder.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        columnWidths: const {
          0: FlexColumnWidth()
        },
        children: [
          TableRow(children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: widget.emptyView,
                ))
          ]),
        ]);
  }

  Widget _bottom() {
    return Table(
        border: TableBorder.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
        columnWidths: const {
          0: FlexColumnWidth()
        },
        children: [
          TableRow(children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.small2),
                    child: widget.bottomWidget,
                  ),
                ))
          ]),
        ]);
  }
}
