import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

class AppTableSettingsView<T> extends StatefulWidget {
  final List<String> headers;
  final TextStyle? headerStyle;
  final Map<int, TableColumnWidth>? columnWidths;
  final List<T> dataList;
  final Widget Function(BuildContext, int, T) cellBuilder;
  final Widget Function(BuildContext, int, T)? editCellBuilder;
  final int? editRowIndex;
  final Widget? bottomWidget;

  const AppTableSettingsView({
    super.key,
    required this.headers,
    this.headerStyle,
    this.columnWidths,
    this.dataList = const [],
    required this.cellBuilder,
    this.editCellBuilder,
    this.editRowIndex,
    this.bottomWidget,
  });

  @override
  State<AppTableSettingsView<T>> createState() => _AppTableSettingsViewState();
}

class _AppTableSettingsViewState<T> extends State<AppTableSettingsView<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                                    style: widget.headerStyle ??
                                        Theme.of(context)
                                            .textTheme
                                            .labelLarge)),
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
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                padding: EdgeInsets.all(Spacing.small2),
                                child: Center(
                                  child: widget.editRowIndex == rowIndex
                                      ? widget.editCellBuilder
                                              ?.call(context, cellIndex, e) ??
                                          widget.cellBuilder(
                                              context, cellIndex, e)
                                      : widget.cellBuilder(
                                          context, cellIndex, e),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ],
          ),
          if (widget.bottomWidget != null)
            Table(
                border: TableBorder.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8))),
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
                ]),
        ],
      ),
    );
  }
}
