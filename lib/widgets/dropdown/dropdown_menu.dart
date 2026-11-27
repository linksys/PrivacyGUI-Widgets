import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';

class AppDropdownMenu<T> extends StatefulWidget {
  final List<T> items;
  final T? initial;
  final String Function(T item) label;
  final void Function(T value)? onChanged;
  final String? identifier;

  /// The key of an item's identifier, `{identifier}-item-{key}`. It comes from
  /// the item's data, never from its label, which is translated. Without it,
  /// the items have no identifier.
  final String Function(T item)? itemKey;

  const AppDropdownMenu({
    super.key,
    required this.items,
    this.initial,
    required this.label,
    this.onChanged,
    this.identifier,
    this.itemKey,
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
    // The menu's field is a text field.
    return IdentifierSemantics.textField(
      identifier: widget.identifier,
      child: DropdownMenu<T>(
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
          final itemIdentifier = _itemIdentifier(value);
          return DropdownMenuEntry<T>(
            value: value,
            label: widget.label(value),
            labelWidget: itemIdentifier == null
                ? null
                : _ItemLabel(
                    identifier: itemIdentifier,
                    label: widget.label(value),
                  ),
          );
        }).toList(),
      ),
    );
  }

  String? _itemIdentifier(T item) {
    final itemKey = widget.itemKey;
    return itemKey == null
        ? null
        : partIdentifier(widget.identifier, 'item-${itemKey(item)}');
  }
}

/// An item's label, which puts the item's identifier on the item in the open
/// menu. The Flutter 3.27.2 `DropdownMenu` also lays out every item, unpainted,
/// beside its field to measure its width, and that copy is in the semantics
/// tree too. It gets no identifier, so that one node has it.
class _ItemLabel extends StatelessWidget {
  final String identifier;
  final String label;

  const _ItemLabel({required this.identifier, required this.label});

  @override
  Widget build(BuildContext context) {
    final text = Text(label);
    if (_isMeasured(context)) return text;
    // Merges into the item's node, which has its tap.
    return Semantics(identifier: identifier, child: text);
  }

  /// Whether this is the copy that `DropdownMenu` measures: it wraps each
  /// measured item, and only that one, in an `ExcludeFocus`. Between the item
  /// and the widget that lays the items out, the open menu has none.
  bool _isMeasured(BuildContext context) {
    var inItem = false;
    var measured = false;
    context.visitAncestorElements((element) {
      final widget = element.widget;
      if (!inItem) {
        inItem = widget is MenuItemButton;
        return true;
      }
      if (widget is ExcludeFocus) {
        measured = true;
        return false;
      }
      return widget is! RenderObjectWidget;
    });
    return measured;
  }
}
