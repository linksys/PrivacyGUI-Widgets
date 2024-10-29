import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class AppRadioListItem<T> {
  final String? title;
  final T value;
  final Widget? titleWidget;
  final Widget? expandedWidget;
  final Widget? subTitleWidget;

  AppRadioListItem({
    this.title,
    required this.value,
    this.titleWidget,
    this.expandedWidget,
    this.subTitleWidget,
  });
}

class AppRadioList<T> extends StatefulWidget {
  final List<AppRadioListItem<T>> items;
  final T? initial;
  final void Function(int index, T? value)? onChanged;
  final MainAxisSize mainAxisSize;
  final bool withDivider;
  final double? itemHeight;

  const AppRadioList({
    super.key,
    required this.items,
    this.initial,
    this.onChanged,
    this.withDivider = false,
    this.mainAxisSize = MainAxisSize.max,
    this.itemHeight,
  });

  @override
  State<AppRadioList> createState() => _AppRadioListState<T>();
}

class _AppRadioListState<T> extends State<AppRadioList<T>> {
  // T? _selected;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _selected = widget.initial;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: widget.mainAxisSize,
      children: widget.items
          .mapIndexed((index, e) => _itemTile(item: e))
          .expandIndexed<Widget>((index, element) sync* {
        if (index != widget.items.length - 1) {
          yield element;
          if (widget.withDivider) yield const Divider();
        } else {
          yield element;
        }
      }).toList(),
    );
  }

  Widget _itemTile({required AppRadioListItem item}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 56),
          height: widget.itemHeight,
          child: InkWell(
            onTap: () {
              setState(() {
                // _selected = item.value;
                widget.onChanged?.call(
                    widget.items
                        .indexWhere((element) => element.value == item.value),
                    item.value);
              });
            },
            child: Row(
              children: [
                AbsorbPointer(
                  child: Radio<T>(
                    value: item.value,
                    groupValue: widget.initial,
                    onChanged: (T? value) {
                      widget.onChanged?.call(
                          widget.items.indexWhere(
                              (element) => element.value == item.value),
                          item.value);
                    },
                  ),
                ),
                const AppGap.small3(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item.titleWidget ?? AppText.labelLarge(item.title ?? ''),
                      if (item.subTitleWidget != null) ...[
                        item.subTitleWidget!,
                      ]
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (item.expandedWidget != null) ...[
          const AppGap.small2(),
          item.expandedWidget!,
          const AppGap.large2()
        ],
      ],
    );
  }
}
