import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppDropdownButton<T> extends StatefulWidget {
  final String? title;
  final List<T> items;
  final T? initial;
  final String Function(T item) label;
  final void Function(T value)? onChanged;

  const AppDropdownButton({
    super.key,
    this.title,
    required this.items,
    this.initial,
    required this.label,
    this.onChanged,
  });

  @override
  State<AppDropdownButton<T>> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
          labelText: widget.title, border: OutlineInputBorder(), filled: true),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: Theme(
            data: Theme.of(context).copyWith(
                focusColor: Theme.of(context).colorScheme.primaryContainer),
            child: DropdownButton<T>(
              elevation: 0,
              padding: EdgeInsets.zero,
              value: widget.initial,
              isDense: true,
              items: widget.items
                  .map((e) => DropdownMenuItem<T>(
                        value: e,
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 48.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ResponsiveLayout.isOverLargeLayout(context)
                                  ? AppText.labelLarge(
                                      widget.label(e),
                                      color: e == _selected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                    )
                                  : AppText.labelMedium(
                                      widget.label(e),
                                      color: e == _selected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                    ),
                              if (e == _selected)
                                Icon(
                                  LinksysIcons.check,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) => widget.items
                  .map((e) => ResponsiveLayout.isOverLargeLayout(context)
                      ? AppText.labelLarge(widget.label(e))
                      : AppText.labelMedium(widget.label(e)))
                  .toList(),
              focusColor: Colors.transparent,
              onChanged: (value) {
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
    );
  }
}
