import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/buttons/button.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/table/table_settings_view.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

///
// AppEditableTableSettingsView<SinglePortForwardingRule>(
//   headers: [
//     'Application Name',
//     loc(context).externalPort,
//     loc(context).internalPort,
//     'Protocol',
//     'Device IP#',
//   ],
//   columnWidths: ResponsiveLayout.isOverLargeLayout(context)
//       ? const {
//           0: FractionColumnWidth(.25),
//           1: FractionColumnWidth(.08),
//           2: FractionColumnWidth(.08),
//           3: FractionColumnWidth(.2),
//           4: FractionColumnWidth(.3),
//         }
//       : const {
//           0: FractionColumnWidth(.2),
//           1: FractionColumnWidth(.08),
//           2: FractionColumnWidth(.08),
//           3: FractionColumnWidth(.225),
//           4: FractionColumnWidth(.3),
//         },
//   dataList: [...state.rules],
//   editRowIndex: 0,
//   cellBuilder: (context, index, rule) {
//     return switch (index) {
//       0 => AppText.bodyLarge(rule.description),
//       1 => AppText.bodyLarge('${rule.externalPort}'),
//       2 => AppText.bodyLarge('${rule.internalPort}'),
//       3 => AppText.bodyLarge(rule.protocol),
//       4 => AppText.bodyLarge(rule.internalServerIPAddress),
//       _ => AppText.bodyLarge(''),
//     };
//   },
//   editCellBuilder: (context, index, rule) {
//     return switch (index) {
//       0 => AppTextField.outline(
//           controller: TextEditingController()
//             ..text = rule.description),
//       1 => AppTextField.minMaxNumber(
//           min: 0,
//           max: 65535,
//           border: OutlineInputBorder(),
//           controller: TextEditingController()
//             ..text = '${rule.externalPort}'),
//       2 => AppTextField.minMaxNumber(
//           min: 0,
//           max: 65535,
//           border: OutlineInputBorder(),
//           controller: TextEditingController()
//             ..text = '${rule.internalPort}'),
//       3 => AppDropdownButton(
//           initial: rule.protocol,
//           items: const ['TCP', 'UDP', 'Both'],
//           label: (e) => getProtocolTitle(context, e),
//           onChanged: (value) {},
//         ),
//       4 => AppIPFormField(
//           controller: TextEditingController()
//             ..text = rule.internalServerIPAddress,
//           border: const OutlineInputBorder(),
//           octet1ReadOnly: submaskToken[0] == '255',
//           octet2ReadOnly: submaskToken[1] == '255',
//           octet3ReadOnly: submaskToken[2] == '255',
//           octet4ReadOnly: submaskToken[3] == '255',
//         ),
//       _ => AppText.bodyLarge(''),
//     };
//   },
//   createItem: () => SinglePortForwardingRule(
//       isEnabled: true,
//       externalPort: 0,
//       protocol: 'Both',
//       internalServerIPAddress: '',
//       internalPort: 0,
//       description: ''),
// )
///
///
class AppEditableTableSettingsView<T> extends StatefulWidget {
  final String? title;
  final List<String> headers;
  final TextStyle? headerStyle;
  final String actionHeader;
  final Map<int, TableColumnWidth>? columnWidths;
  final List<T> dataList;
  final Widget Function(BuildContext, int, T) cellBuilder;
  final Widget Function(BuildContext, int, T)? editCellBuilder;
  final EditableListItem Function(BuildContext, T) itemCardBuilder;
  final Widget Function(BuildContext, T)? editItemCardBuilder;
  final int? editRowIndex;
  final T Function() createNewItem;
  final String addLabel;
  final IconData? addIcon;
  final bool? isEditingDataValid;
  final void Function(T cell)? onSaved;
  final void Function(T cell)? onDeleted;
  final String? emptyMessage;

  const AppEditableTableSettingsView({
    super.key,
    this.title,
    required this.headers,
    this.headerStyle,
    this.actionHeader = '',
    this.columnWidths,
    required this.dataList,
    required this.cellBuilder,
    this.editCellBuilder,
    this.editRowIndex,
    required this.createNewItem,
    this.addLabel = '',
    this.addIcon,
    this.isEditingDataValid,
    this.onSaved,
    this.onDeleted,
    this.emptyMessage,
    required this.itemCardBuilder,
    this.editItemCardBuilder,
  });

  @override
  State<AppEditableTableSettingsView<T>> createState() =>
      _AppEditableTableSettingsViewState<T>();
}

class _AppEditableTableSettingsViewState<T>
    extends State<AppEditableTableSettingsView<T>> {
  int? _editRow;
  T? _tempItem;

  @override
  Widget build(BuildContext context) {
    final lastIndex = widget.headers.length;
    return AppTableSettingsView<T>(
        title: widget.title,
        headers: [...widget.headers, widget.actionHeader],
        dataList: [
          ...widget.dataList,
          if (_tempItem != null) _tempItem!,
        ],
        columnWidths: widget.columnWidths,
        editRowIndex: _editRow,
        emptyView: SizedBox(
            height: 120,
            child: Center(child: AppText.bodyLarge(widget.emptyMessage ?? ''))),
        cellBuilder: (context, index, rule) => index == lastIndex
            ? Row(
                children: [
                  AppIconButton(
                      icon: LinksysIcons.edit,
                      onTap: () {
                        _editItem(widget.dataList.indexOf(rule), null);
                      }),
                  AppIconButton(
                    icon: LinksysIcons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              )
            : widget.cellBuilder(context, index, rule),
        editCellBuilder: (context, index, rule) => index == lastIndex
            ? Row(
                children: [
                  AppIconButton(
                    icon: LinksysIcons.check,
                    color: (widget.isEditingDataValid ?? true)
                        ? Theme.of(context).colorSchemeExt.green
                        : Theme.of(context).colorScheme.outline,
                    onTap: (widget.isEditingDataValid ?? true) ? () {} : null,
                  ),
                  AppIconButton(
                    icon: LinksysIcons.close,
                    onTap: () {
                      _editItem(null, null);
                    },
                  ),
                ],
              )
            : widget.editCellBuilder?.call(context, index, rule) ??
                SizedBox.shrink(),
        bottomWidget: AppTextButton(
          widget.addLabel,
          icon: widget.addIcon ?? LinksysIcons.add,
          onTap: () {
            setState(() {
              _tempItem = widget.createNewItem.call();
              _editRow = widget.dataList.length;
            });
            _editItem(widget.dataList.length, widget.createNewItem.call());
          },
        ),
        itemCardBuilder: (context, data) {
          final item = widget.itemCardBuilder(context, data);
          return EditableListItemWidget(
              title: item.title,
              actions: [
                AppIconButton(
                    icon: LinksysIcons.edit,
                    onTap: () {
                      // TODO
                    }),
                AppIconButton(
                  icon: LinksysIcons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
              content: item.content);
        });
  }

  void _editItem(int? index, T? item) {
    setState(() {
      _tempItem = item;
      _editRow = index;
    });
  }
}

class EditableListItem {
  final String title;
  final Widget content;

  EditableListItem({required this.title, required this.content});
}

class EditableListItemWidget extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget content;
  const EditableListItemWidget({
    super.key,
    required this.title,
    required this.actions,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [AppText.titleSmall(title), Wrap(children: actions)],
        ),
        const AppGap.medium(),
        content,
      ],
    );
  }
}
