import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';
import 'package:privacygui_widgets/widgets/topology/tree_item.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'tree_node.dart';

typedef NodeBuilder<T> = Widget Function(AppTreeNode<T>);

class AppTreeView<T> extends StatefulWidget {
  final AppTreeNode<T> onlineRoot;
  final AppTreeNode<T>? offlineRoot;
  final NodeBuilder<T> itemBuilder;
  final ScrollController? controller;
  final double itemHeight;
  final bool detailMode;
  const AppTreeView({
    super.key,
    required this.onlineRoot,
    this.offlineRoot,
    required this.itemBuilder,
    this.controller,
    this.itemHeight = 104,
    this.detailMode = false,
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
    if (widget.detailMode) {
      final offlineNodes = widget.offlineRoot?.toFlatList() ?? [];
      if (offlineNodes.isNotEmpty) {
        final master = widget.onlineRoot.children.first;
        offlineNodes.removeAt(0);
        for (var element in offlineNodes) {
          master.children.add(element
            ..parent = master
            ..tag = 'offline');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _list = widget.onlineRoot.toFlatList();
    if (!widget.detailMode) {
      if (_list.length == 2) {
        _list[1].height = 292;
      } else {
        _list[1].height = null;
      }
      if ((widget.offlineRoot?.children.isNotEmpty ?? false)) {
        _list.add(widget.offlineRoot!);
      }
    } else {
      // final offlineNodes = widget.offlineRoot?.toFlatList() ?? [];
      // if (offlineNodes.isNotEmpty) {
      //   final master = _list[1];
      //   offlineNodes.removeAt(0);
      //   for (var element in offlineNodes) {
      //     master.children.add(element..parent = master);
      //   }
      //   _list.addAll(offlineNodes);
      // }
    }

    _desiredWidth = 250 + (widget.onlineRoot.maxLevel() + 1) * 48.0;
    final screenWidth = ResponsiveLayout.getContentWidth(context);
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
          isRTL: Directionality.of(context) == TextDirection.rtl,
          dashed: _list[vicinity.row].tag == 'offline',
          level: _list[vicinity.row].level(),
          isLast: _list[vicinity.row].isLast(),
          isParentLastArray: _list[vicinity.row].isAncestorLastArray(),
          showConnectionLine:
              !((widget.offlineRoot?.children.contains(_list[vicinity.row]) ??
                      false) &&
                  !widget.detailMode),
          child: widget.itemBuilder.call(_list[vicinity.row]),
        ),
      );

  TableSpan _buildColumnSpan(int index) {
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
    double height = treeNode.height ?? widget.itemHeight;
    if (!widget.detailMode &&
        index == _list.length - 1 &&
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
