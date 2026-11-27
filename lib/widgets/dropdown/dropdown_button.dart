import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppDropdownButton<T> extends StatefulWidget {
  final String? title;
  final List<T> items;
  final T? initial;
  final T? selected;
  final String Function(T item) label;
  final void Function(T value)? onChanged;
  final String? identifier;

  /// The key of an item's identifier, `{identifier}-item-{key}`. It comes from
  /// the item's data, never from its label, which is translated. Without it,
  /// the items have no identifier.
  final String Function(T item)? itemKey;

  const AppDropdownButton({
    super.key,
    this.title,
    required this.items,
    this.initial,
    this.selected,
    required this.label,
    this.onChanged,
    this.identifier,
    this.itemKey,
  });

  @override
  State<AppDropdownButton<T>> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selected = widget.selected ?? widget.initial ?? widget.items.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetSelected = widget.selected;
    if (widgetSelected != null) {
      setState(() {
        _selected = widgetSelected;
      });
    }
    final enable = widget.onChanged != null;
    return IdentifierSemantics(
      identifier: widget.identifier,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.title,
          border: OutlineInputBorder(),
          filled: true,
          enabled: enable,
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            child: Theme(
              data: Theme.of(context).copyWith(
                  focusColor: Theme.of(context).colorScheme.primaryContainer),
              child: DropdownButton<T>(
                elevation: 0,
                padding: EdgeInsets.zero,
                value: _selected,
                isDense: true,
                isExpanded: true,
                items: widget.items
                    .map((e) => DropdownMenuItem<T>(
                          value: e,
                          // Merges into the item's node, which has its tap.
                          child: Semantics(
                            identifier: _itemIdentifier(e),
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(minHeight: 48.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AppText.labelMedium(
                                      widget.label(e),
                                      overflow: TextOverflow.ellipsis,
                                      color: e == _selected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                    ),
                                  ),
                                  if (e == _selected)
                                    Icon(
                                      LinksysIcons.check,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                selectedItemBuilder: (context) => widget.items
                    .map((e) => AppText.labelMedium(
                          widget.label(e),
                          overflow: TextOverflow.ellipsis,
                          color: enable
                              ? null
                              : Theme.of(context).colorScheme.outline,
                        ))
                    .toList(),
                focusColor: Colors.transparent,
                onChanged: widget.onChanged == null
                    ? null
                    : (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selected = value;
                        });
                        widget.onChanged?.call(value);
                      },
              ),
            ),
          ),
        ),
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
