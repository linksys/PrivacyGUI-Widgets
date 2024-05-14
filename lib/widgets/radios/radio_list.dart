import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class AppRadioListItem<T> {
  final String title;
  final T value;
  final Widget? titleWidget;
  final Widget? subtitleWidget;

  AppRadioListItem({
    required this.title,
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

  const AppRadioList(
      {super.key,
      required this.items,
      this.initial,
      this.onChanged,
      this.mainAxisSize = MainAxisSize.max});

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
      children: widget.items.map((e) => _itemTile(item: e)).toList(),
    );
  }

  Widget _itemTile({required AppRadioListItem item}) {
    return ListTile(
      title: item.titleWidget ?? AppText.labelLarge(item.title),
      subtitle: item.subtitleWidget,
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
