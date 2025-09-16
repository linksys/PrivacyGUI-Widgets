import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';
import 'package:privacygui_widgets/widgets/tree/tree_node_model.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

enum LineStyle {
  solid,
  dotted,
  dottedCross,
  ;
}

class TreeNodeView<T> extends StatefulWidget {
  final List<UITreeNodeModel<T>> data;
  final double indent;
  final double rowHeight;
  final double topPadding;
  final double lineOffsetX;
  final Widget? empty;
  final Paint? linePaint;
  final Widget Function(T data) nodeBuilder;
  final LineStyle Function(T data)? lineStyle;

  const TreeNodeView({
    super.key,
    required this.data,
    this.indent = 40.0,
    this.rowHeight = 100.0,
    this.topPadding = 24.0,
    this.lineOffsetX = 20.0,
    this.empty,
    this.linePaint,
    required this.nodeBuilder,
    this.lineStyle,
  });

  @override
  State<TreeNodeView<T>> createState() => _TreeNodeViewState<T>();
}

class _TreeNodeViewState<T> extends State<TreeNodeView<T>> {
  @override
  Widget build(BuildContext context) {
    final indent = widget.indent;
    final rowHeight = widget.rowHeight;
    final topPadding = widget.topPadding;
    final lineOffsetX = widget.lineOffsetX;
    final linePaint = widget.linePaint ?? Paint()
      ..color = Theme.of(context).colorScheme.onSurface
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    return widget.data.isEmpty
        ? widget.empty ?? const AppText.headlineMedium('No Data')
        : TreeView<T>(
            tree: widget.data,
            indentation: TreeViewIndentationType.none,
            treeNodeBuilder: (context, node, _) {
              final depth = node.depth ?? 0;
              return Padding(
                padding: EdgeInsets.only(left: indent * depth),
                child: CustomPaint(
                  painter: _TreeNodeLinePainter(
                    node: node,
                    topPadding: topPadding,
                    indent: indent,
                    rowHeight: rowHeight,
                    lineOffsetX: lineOffsetX,
                    linePaint: linePaint,
                    lineStyle: widget.lineStyle ?? (_) => LineStyle.solid,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: indent, top: topPadding),
                    child: widget.nodeBuilder(node.content),
                  ),
                ),
              );
            },
            treeRowBuilder: (node) {
              return TreeRow(
                extent: FixedTreeRowExtent(rowHeight),
              );
            },
          );
  }
}

class _TreeNodeLinePainter<T> extends CustomPainter {
  final TreeViewNode<T> node;
  final double topPadding;
  final double indent;
  final double rowHeight;
  final double lineOffsetX;
  final Paint linePaint;
  final LineStyle Function(T data) lineStyle;

  _TreeNodeLinePainter({
    required this.node,
    required this.topPadding,
    required this.indent,
    required this.rowHeight,
    required this.lineOffsetX,
    required this.linePaint,
    required this.lineStyle,
  }) : assert(lineOffsetX < indent, 'lineOffsetX must be less than indent');

  @override
  void paint(Canvas canvas, Size size) {
    final double horizontalLineY = (rowHeight + topPadding) / 2;
    final double currentDepth = (node.depth ?? 0).toDouble();

    // Helper function to draw a path, either solid or dotted.
    void drawLineOrDottedPath(Path path,
        {required bool isDotted, required bool showCross}) {
      if (isDotted) {
        final dottedPath = _createDottedPath(path, showCross: showCross);
        canvas.drawPath(dottedPath, linePaint);
      } else {
        canvas.drawPath(path, linePaint);
      }
    }

    // Part 1: Draw the "L" shape connector for the current node.
    if (node.parent != null) {
      final bool isLastChild = node.parent!.children.last == node;

      // Create paths for the "L" shape.
      final horizontalPath = Path()
        ..moveTo(lineOffsetX, horizontalLineY)
        ..lineTo(indent + lineOffsetX, horizontalLineY);

      final verticalPath = Path()
        ..moveTo(lineOffsetX, 0)
        ..lineTo(lineOffsetX, isLastChild ? horizontalLineY : rowHeight);

      // Check node properties to decide line style
      final bool shouldBeDotted = lineStyle(node.content) !=
          LineStyle.solid; // Assumed property on TreeNodeModel
      final bool shouldShowCross = lineStyle(node.content) ==
          LineStyle.dottedCross; // Assumed property on TreeNodeModel

      drawLineOrDottedPath(horizontalPath,
          isDotted: shouldBeDotted,
          showCross: false); // Do not show cross for horizontal line
      drawLineOrDottedPath(verticalPath,
          isDotted: shouldBeDotted, showCross: shouldShowCross);
    }

    // // Part 2: Draw vertical lines for ancestors.
    // var currentAncestor = node.parent;
    // var ancestorDepth = currentDepth - 1;
    // while (currentAncestor != null) {
    //   if (currentAncestor.parent != null &&
    //       currentAncestor.parent!.children.last != currentAncestor) {
    //     final double xPosition =
    //         -indent * (currentDepth - ancestorDepth) + lineOffsetX;

    //     // Create a path for the ancestor's vertical line.
    //     final verticalPath = Path()
    //       ..moveTo(xPosition, 0)
    //       ..lineTo(xPosition, rowHeight);

    //     // TODO Check n-th sibling node properties to decide line style
    //     final bool shouldBeDotted = lineStyle(node.content) !=
    //         LineStyle.solid; // Assumed property on TreeNodeModel
    //     final bool shouldShowCross = lineStyle(node.content) ==
    //         LineStyle.dottedCross; // Assumed property on TreeNodeModel

    //     // Draw the ancestor's vertical line, applying the dotted logic.
    //     drawLineOrDottedPath(verticalPath,
    //         isDotted: shouldBeDotted, showCross: shouldShowCross);
    //   }

    //   currentAncestor = currentAncestor.parent;
    //   ancestorDepth--;
    // }

    // Part 2: Draw vertical lines for ancestors.
    var currentAncestor = node.parent;
    var ancestorDepth = currentDepth - 1;
    while (currentAncestor != null) {
      // 只有當祖先不是其父節點的最後一個子節點時，才需要畫垂直線。
      // 這確保了樹狀結構的正確視覺效果。
      if (currentAncestor.parent != null &&
          currentAncestor.parent!.children.last != currentAncestor) {
        final double xPosition =
            -indent * (currentDepth - ancestorDepth) + lineOffsetX;

        // 取得祖先節點的內容來判斷線條樣式
        final ancestorLineStyle = lineStyle(currentAncestor.content);
        final bool shouldBeDotted = ancestorLineStyle != LineStyle.solid;
        final bool shouldShowCross = ancestorLineStyle == LineStyle.dottedCross;

        // 繪製垂直線
        final verticalPath = Path()
          ..moveTo(xPosition, 0)
          ..lineTo(xPosition, rowHeight);

        drawLineOrDottedPath(verticalPath,
            isDotted: shouldBeDotted, showCross: shouldShowCross);
      }

      currentAncestor = currentAncestor.parent;
      ancestorDepth--;
    }
  }

  static Path _createDottedPath(Path path, {bool showCross = false}) {
    final dottedPath = Path();
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        dottedPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }

      if (showCross) {
        // Add cross (X) in the middle of the path
        final midPoint =
            metric.getTangentForOffset(metric.length / 2)?.position ??
                Offset.zero;
        const crossSize = 8.0;

        // Draw first line of X (top-left to bottom-right)
        dottedPath.moveTo(midPoint.dx - crossSize, midPoint.dy - crossSize);
        dottedPath.lineTo(midPoint.dx + crossSize, midPoint.dy + crossSize);

        // Draw second line of X (top-right to bottom-left)
        dottedPath.moveTo(midPoint.dx + crossSize, midPoint.dy - crossSize);
        dottedPath.lineTo(midPoint.dx - crossSize, midPoint.dy + crossSize);
      }
    }
    return dottedPath;
  }

  @override
  bool shouldRepaint(covariant _TreeNodeLinePainter oldDelegate) {
    return oldDelegate.node != node ||
        oldDelegate.indent != indent ||
        oldDelegate.rowHeight != rowHeight ||
        oldDelegate.linePaint != linePaint;
  }
}
