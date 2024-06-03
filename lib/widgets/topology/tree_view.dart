import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/topology/tree_item.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'tree_node.dart';

typedef NodeBuilder<T> = Widget Function(AppTreeNode<T>);

class AppTreeView<T> extends StatefulWidget {
  final AppTreeNode<T> onlineRoot;
  final AppTreeNode<T>? offlineRoot;
  final NodeBuilder<T> itemBuilder;
  final ScrollController? controller;
  const AppTreeView({
    super.key,
    required this.onlineRoot,
    this.offlineRoot,
    required this.itemBuilder,
    this.controller,
  });

  @override
  State<AppTreeView<T>> createState() => _AppTreeViewState<T>();
}

class _AppTreeViewState<T> extends State<AppTreeView<T>> {
  late final ScrollController _verticalController;
  List<AppTreeNode<T>> _list = [];
  late double _desiredWidth;
  late double _desiredOfflineHeight;

  @override
  void initState() {
    super.initState();
    _verticalController = widget.controller ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _list = widget.onlineRoot.toFlatList();
    if (_list.length == 2) {
      _list[1].height = 292;
    } else {
      _list[1].height = null;
    }
    if ((widget.offlineRoot?.children.isNotEmpty ?? false)) {
      _list.add(widget.offlineRoot!);
    }

    _desiredWidth = 250 + (widget.onlineRoot.maxLevel() + 1) * 48.0;
    final screenWidth = MediaQuery.of(context).size.width;
    _desiredWidth = screenWidth > _desiredWidth ? screenWidth : _desiredWidth;
    final offlineColumnCount = _desiredWidth / (250 + 48);
    final offlineRowCount =
        (widget.offlineRoot?.children.length ?? 0) / offlineColumnCount + 1;
    _desiredOfflineHeight = 83 + 24 + offlineRowCount * (104 + 48);
    return TableView.builder(
      verticalDetails:
          ScrollableDetails.vertical(controller: _verticalController),
      cellBuilder: _buildCell,
      columnCount: 1,
      columnBuilder: _buildColumnSpan,
      rowCount: _list.length,
      rowBuilder: _buildRowSpan,
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    return getItem(vicinity);
  }

  TableViewCell getItem(TableVicinity vicinity) => TableViewCell(
        child: AppTreeNodeCell(
          level: _list[vicinity.row].level(),
          isLast: _list[vicinity.row].isLast(),
          isParentLastArray: _list[vicinity.row].isAncestorLastArray(),
          showConnectionLine:
              !(widget.offlineRoot?.children.contains(_list[vicinity.row]) ??
                  false),
          child: widget.itemBuilder.call(_list[vicinity.row]),
        ),
      );

  TableSpan _buildColumnSpan(int index) {
    final node = _list[index];
    return TableSpan(
      // foregroundDecoration: decoration,
      extent: FixedTableSpanExtent(_desiredWidth),
      onEnter: (_) => print('Entered column $index'),
      recognizerFactories: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer t) =>
              t.onTap = () => print('Tap column $index'),
        ),
      },
    );
  }

  TableSpan _buildRowSpan(int index) {
    final treeNode = _list[index];
    double height = treeNode.height ?? 104;
    if (index == _list.length - 1 &&
        (widget.offlineRoot?.children.length ?? 0) > 0) {
      height = _desiredOfflineHeight;
    }
    // if (treeNode.type == AppTreeNodeType.internet) {
    //   height = 80;
    // } else if (treeNode.type == AppTreeNodeType.offline) {
    //   height = 80;
    // }
    return TableSpan(
      // backgroundDecoration: decoration,

      extent: FixedTableSpanExtent(height),
      recognizerFactories: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer t) => t.onTap = () => print('Tap row $index'),
        ),
      },
    );
  }
}
