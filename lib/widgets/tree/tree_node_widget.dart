import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:privacygui_widgets/theme/custom_theme.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/tree/tree_action_menu.dart';

enum TreeNodeMode { simple, detailed }

enum PathType { dotted, solid }

class TreeNodeDetailCell {
  final String label;
  final Widget widget;

  TreeNodeDetailCell({
    required this.label,
    required this.widget,
  });
}

class TreeNodeWidget extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final List<TreeAction> actions;
  final void Function(TreeAction)? onActionTap;
  final List<TreeNodeDetailCell> nodeDataWidgets;
  final Color? background;
  final Widget? image;
  final Widget? icon;
  final bool showActions;
  final String? actionMenuLabel;
  final TreeNodeMode mode;

  const TreeNodeWidget._({
    super.key,
    required this.label,
    this.actions = const [],
    this.onTap,
    this.onActionTap,
    this.image,
    this.icon,
    this.background,
    this.nodeDataWidgets = const [],
    this.showActions = true,
    this.actionMenuLabel,
    this.mode = TreeNodeMode.detailed,
  });
  factory TreeNodeWidget.detailed({
    Key? key,
    required String label,
    List<TreeAction> actions = const [],
    VoidCallback? onTap,
    void Function(TreeAction)? onActionTap,
    List<TreeNodeDetailCell> nodeDataWidgets = const [],
    Color? background,
    Widget? image,
    Widget? icon,
    bool showActions = true,
    String? actionMenuLabel,
  }) {
    return TreeNodeWidget._(
      key: key,
      label: label,
      actions: actions,
      onTap: onTap,
      onActionTap: onActionTap,
      nodeDataWidgets: nodeDataWidgets,
      background: background,
      image: image,
      icon: icon,
      showActions: showActions,
      actionMenuLabel: actionMenuLabel,
      mode: TreeNodeMode.detailed,
    );
  }

  factory TreeNodeWidget.simple({
    Key? key,
    required String label,
    List<TreeAction> actions = const [],
    VoidCallback? onTap,
    void Function(TreeAction)? onActionTap,
    String? description,
    String? subDescription,
    Color? background,
    Widget? image,
    Widget? icon,
    bool showActions = true,
    String? actionMenuLabel,
  }) {
    final nodeDataWidgets = <TreeNodeDetailCell>[
      if (description != null)
        TreeNodeDetailCell(
          label: 'desc',
          widget: AppText.bodySmall(description),
        ),
      if (subDescription != null)
        TreeNodeDetailCell(
          label: 'sub',
          widget: AppText.bodySmall(subDescription),
        ),
    ];
    return TreeNodeWidget._(
      key: key,
      label: label,
      actions: actions,
      onTap: onTap,
      onActionTap: onActionTap,
      nodeDataWidgets: nodeDataWidgets,
      background: background,
      image: image,
      icon: icon,
      showActions: showActions,
      actionMenuLabel: actionMenuLabel,
      mode: TreeNodeMode.simple,
    );
  }

  @override
  State<TreeNodeWidget> createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      color: widget.background ?? Theme.of(context).colorScheme.surface,
      onTap: widget.onTap,
      child: switch (widget.mode) {
        TreeNodeMode.simple => _buildSimple(),
        TreeNodeMode.detailed => _buildDetailed(),
      },
    );
  }

  Widget _buildSimple() {
    final descCell =
        widget.nodeDataWidgets.firstWhereOrNull((e) => e.label == 'desc');
    final subCell =
        widget.nodeDataWidgets.firstWhereOrNull((e) => e.label == 'sub');
    return Container(
      constraints: BoxConstraints(
          minWidth: 180,
          maxWidth: 400,
          maxHeight: widget.actions.isEmpty ? 92 : 150),
      padding: widget.showActions && widget.actions.isNotEmpty
          ? const EdgeInsets.only(
              top: Spacing.medium,
              bottom: 0,
              left: Spacing.medium,
              right: Spacing.medium)
          : const EdgeInsets.all(Spacing.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.image != null
                    ? widget.image!
                    : Image(
                        image: CustomTheme.of(context)
                            .images
                            .devices_xl
                            .routerMx6200,
                        width: 64,
                        height: 64,
                      ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppText.titleMedium(
                        widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (descCell != null) descCell.widget,
                      if (subCell != null) subCell.widget,
                    ],
                  ),
                ),
                if (widget.icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: Spacing.small2),
                    child: widget.icon!,
                  ),
              ],
            ),
          ),
          if (widget.actions.isNotEmpty) ...[
            const AppGap.medium(),
            const Divider(
              height: 0,
            ),
            TreeActionsMenu(
              title: widget.label,
              actions: widget.actions,
              onActionTap: widget.onActionTap,
              itemBuilder: _itemText,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildDetailed() {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 180,
        maxWidth: 400,
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.medium),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppText.labelLarge(
                            widget.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.mode == TreeNodeMode.detailed) ...[
                          const AppGap.medium(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNodeContent(
                                context,
                                widget.nodeDataWidgets,
                              )
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: widget.icon,
                      ),
                      const AppGap.small3(),
                      Expanded(
                        child: widget.image != null
                            ? widget.image!
                            : Image(
                                image: CustomTheme.of(context)
                                    .images
                                    .devices_xl
                                    .routerMx6200,
                                width: 64,
                                height: 64,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.showActions && widget.actions.isNotEmpty) ...[
            const AppGap.medium(),
            const Divider(
              height: 0,
            ),
            TreeActionsMenu(
              title: widget.actionMenuLabel ?? '',
              actions: widget.actions,
              onActionTap: widget.onActionTap,
              itemBuilder: _itemText,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildNodeContent(
    BuildContext context,
    List<TreeNodeDetailCell> nodeDataWidgets,
  ) {
    return SelectToCopyWidget(
      child: Table(
        border: const TableBorder(),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
        },
        children: nodeDataWidgets
            .map((e) => TableRow(children: [
                  AppText.labelLarge('${e.label}:'),
                  e.widget,
                ]))
            .toList(),
      ),
    );
  }

  Widget _itemText(BuildContext context, TreeAction action) {
    return AppText.labelLarge(
      action.label,
      color: action.color ?? Theme.of(context).colorScheme.onSurface,
    );
  }
}

class SelectToCopyWidget extends StatefulWidget {
  final Widget child;
  const SelectToCopyWidget({super.key, required this.child});

  @override
  State<SelectToCopyWidget> createState() => _SelectToCopyWidgetState();
}

class _SelectToCopyWidgetState extends State<SelectToCopyWidget> {
  SelectedContent? _selectedContent;
  Offset? _lastPointerPosition;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        _lastPointerPosition = event.position;
      },
      onPointerUp: (event) {
        _lastPointerPosition = event.position;
        if (_selectedContent != null &&
            _selectedContent!.plainText.isNotEmpty) {
          final text = _selectedContent!.plainText;
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              _lastPointerPosition!.dx,
              _lastPointerPosition!.dy,
              _lastPointerPosition!.dx,
              _lastPointerPosition!.dy,
            ),
            items: <PopupMenuEntry>[
              PopupMenuItem(
                child: const Text('Copy'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: text));
                  setState(() {
                    _selectedContent = null;
                  });
                },
              ),
            ],
          );
        }
      },
      child: SelectionArea(
        onSelectionChanged: (SelectedContent? content) {
          _selectedContent = content;
        },
        child: widget.child,
      ),
    );
  }
}
