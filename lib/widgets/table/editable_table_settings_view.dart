import 'package:flutter/material.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/widgets/buttons/button.dart';
import 'package:privacygui_widgets/widgets/table/table_settings_view.dart';

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
  final List<String> headers;
  final TextStyle? headerStyle;
  final String actionHeader;
  final Map<int, TableColumnWidth>? columnWidths;
  final List<T> dataList;
  final Widget Function(BuildContext, int, T) cellBuilder;
  final Widget Function(BuildContext, int, T)? editCellBuilder;
  final int? editRowIndex;
  final T Function() createItem;
  final String addLabel;
  final IconData? addIcon;
  final void Function(T cell)? onSaved;
  final void Function(T cell)? onDeleted;

  const AppEditableTableSettingsView({
    super.key,
    required this.headers,
    this.headerStyle,
    this.actionHeader = '',
    this.columnWidths,
    required this.dataList,
    required this.cellBuilder,
    this.editCellBuilder,
    this.editRowIndex,
    required this.createItem,
    this.addLabel = '',
    this.addIcon,
    this.onSaved,
    this.onDeleted,
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
      headers: [...widget.headers, widget.actionHeader],
      dataList: [
        ...widget.dataList,
        if (_tempItem != null) _tempItem!,
      ],
      columnWidths: widget.columnWidths,
      editRowIndex: _editRow,
      cellBuilder: (context, index, rule) => index == lastIndex
          ? Row(
              children: [
                AppIconButton(
                    icon: LinksysIcons.edit,
                    onTap: () {
                      _editItem(widget.dataList.indexOf(rule), null);
                    }),
                AppIconButton(icon: LinksysIcons.delete),
              ],
            )
          : widget.cellBuilder(context, index, rule),
      editCellBuilder: (context, index, rule) => index == lastIndex
          ? Row(
              children: [
                AppIconButton(
                  icon: LinksysIcons.check,
                  onTap: () {},
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
            _tempItem = widget.createItem.call();
            _editRow = widget.dataList.length;
          });
          _editItem(widget.dataList.length, widget.createItem.call());
        },
      ),
    );
  }

  void _editItem(int? index, T? item) {
    setState(() {
      _tempItem = item;
      _editRow = index;
    });
  }
}
