import 'package:flutter/material.dart';

class AppDropdownMenu<T> extends StatefulWidget {
  final List<T> items;
  final T? initial;
  final String Function(T item) label;
  final void Function(T value)? onChanged;

  const AppDropdownMenu({
    super.key,
    required this.items,
    this.initial,
    required this.label,
    this.onChanged,
  });

  @override
  State<AppDropdownMenu<T>> createState() => _AppDropdownMenuState();
}

class _AppDropdownMenuState<T> extends State<AppDropdownMenu<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: _selected,
      // enableSearch: false,
      // requestFocusOnTap: true,
      onSelected: (T? value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selected = value;
        });
        widget.onChanged?.call(value);
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<T>>((T value) {
        return DropdownMenuEntry<T>(
          value: value,
          label: widget.label(value),
        );
      }).toList(),
    );
  }
}
