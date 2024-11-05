import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppCardListSettingsView<T> extends StatefulWidget {
  final String? title;
  final List<T> dataList;
  final Widget? emptyView;
  final Widget Function(BuildContext, T) itemCardBuilder;
  final Widget Function(BuildContext, T)? editItemCardBuilder;
  final List<Widget> actions;

  const AppCardListSettingsView({
    super.key,
    this.title,
    this.dataList = const [],
    required this.itemCardBuilder,
    this.editItemCardBuilder,
    this.actions = const [],
    this.emptyView,
  });

  @override
  State<AppCardListSettingsView<T>> createState() => _AppCardListSettingsViewState();
}

class _AppCardListSettingsViewState<T> extends State<AppCardListSettingsView<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null) ...[
            _titleWidget(),
            const AppGap.medium(),
          ],
          if (widget.emptyView != null && widget.dataList.isEmpty) _empty(),
          if (widget.emptyView == null || widget.dataList.isNotEmpty)
            _content(),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.titleSmall(widget.title!),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.actions,
        )
      ],
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...widget.dataList.map((e) => AppCard(
              child: widget.itemCardBuilder(context, e),
            ))
      ],
    );
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
}
