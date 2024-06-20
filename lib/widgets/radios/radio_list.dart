import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/list_card.dart';

class AppRadioListItem<T> {
  final String? title;
  final T value;
  final Widget? titleWidget;
  final Widget? subtitleWidget;

  AppRadioListItem({
    this.title,
    required this.value,
    this.titleWidget,
    this.subtitleWidget,
  });
}

class AppRadioList<T> extends StatefulWidget {
  final List<AppRadioListItem<T>> items;
  final T? initial;
  final void Function(int index, T? value)? onChanged;
  final MainAxisSize mainAxisSize;
  final bool withDivider;
  final CrossAxisAlignment itemCrossAxisAlignment;

  const AppRadioList({
    super.key,
    required this.items,
    this.initial,
    this.onChanged,
    this.withDivider = false,
    this.itemCrossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  State<AppRadioList> createState() => _AppRadioListState<T>();
}

class _AppRadioListState<T> extends State<AppRadioList<T>> {
  T? _selected;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selected = widget.initial;
    });
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
    return AppListCard(
      showBorder: false,
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      crossAxisAlignment: widget.itemCrossAxisAlignment,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: item.titleWidget ?? AppText.labelLarge(item.title ?? ''),
      ),
      description: item.subtitleWidget,
      leading: AbsorbPointer(
        child: Radio<T>(
          value: item.value,
          groupValue: _selected,
          onChanged: (T? value) {
            widget.onChanged?.call(
                widget.items
                    .indexWhere((element) => element.value == _selected),
                _selected);
          },
        ),
      ),
      onTap: () {
        setState(() {
          _selected = item.value;
          widget.onChanged?.call(
              widget.items.indexWhere((element) => element.value == _selected),
              _selected);
        });
      },
    );
  }
}
