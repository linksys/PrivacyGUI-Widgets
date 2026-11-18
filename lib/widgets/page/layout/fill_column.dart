// PROTOTYPE #1864 option B: not for merge.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A column whose height may be unbounded, as in a scrolling page.
///
/// Every child but the one at [fillIndex] takes its own height. The child at
/// [fillIndex] then gets at least what is left of the incoming minimum height,
/// and no maximum. In a page that scrolls and is at least the viewport tall,
/// that child fills the rest of a short page (a [Center] in it centers, a
/// footer after it sits at the bottom) and grows with a long one. This is what
/// an [Expanded] under an [IntrinsicHeight] gave, without asking any child for
/// its intrinsic height.
class FillColumn extends MultiChildRenderObjectWidget {
  const FillColumn({
    super.key,
    required this.fillIndex,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required super.children,
  });

  final int fillIndex;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  RenderFillColumn createRenderObject(BuildContext context) =>
      RenderFillColumn(fillIndex, crossAxisAlignment);

  @override
  void updateRenderObject(BuildContext context, RenderFillColumn renderObject) {
    renderObject
      ..fillIndex = fillIndex
      ..crossAxisAlignment = crossAxisAlignment;
  }
}

class _FillColumnParentData extends ContainerBoxParentData<RenderBox> {}

class RenderFillColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _FillColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _FillColumnParentData> {
  RenderFillColumn(this._fillIndex, this._crossAxisAlignment);

  int _fillIndex;
  set fillIndex(int value) {
    if (value == _fillIndex) return;
    _fillIndex = value;
    markNeedsLayout();
  }

  CrossAxisAlignment _crossAxisAlignment;
  set crossAxisAlignment(CrossAxisAlignment value) {
    if (value == _crossAxisAlignment) return;
    _crossAxisAlignment = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _FillColumnParentData) {
      child.parentData = _FillColumnParentData();
    }
  }

  @override
  void performLayout() {
    size = _layout(constraints, (child, c) {
      child.layout(c, parentUsesSize: true);
      return child.size;
    });
    double y = 0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final free = size.width - child.size.width;
      final x = switch (_crossAxisAlignment) {
        CrossAxisAlignment.center => free / 2,
        CrossAxisAlignment.end => free,
        _ => 0.0,
      };
      (child.parentData! as _FillColumnParentData).offset = Offset(x, y);
      y += child.size.height;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      _layout(constraints, (child, c) => child.getDryLayout(c));

  Size _layout(BoxConstraints constraints,
      Size Function(RenderBox child, BoxConstraints c) layoutChild) {
    final stretch = _crossAxisAlignment == CrossAxisAlignment.stretch;
    final width = stretch
        ? BoxConstraints.tightFor(width: constraints.maxWidth)
        : BoxConstraints(maxWidth: constraints.maxWidth);
    final sizes = <RenderBox, Size>{};
    double fixed = 0;
    RenderBox? fill;
    var index = 0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      if (index++ == _fillIndex) {
        fill = child;
        continue;
      }
      fixed += (sizes[child] = layoutChild(child, width)).height;
    }
    if (fill != null) {
      final rest = math.max(0.0, constraints.minHeight - fixed);
      final maxRest = constraints.hasBoundedHeight
          ? math.max(rest, constraints.maxHeight - fixed)
          : double.infinity;
      sizes[fill] =
          layoutChild(fill, width.copyWith(minHeight: rest, maxHeight: maxRest));
    }
    double height = 0, crossSize = stretch ? constraints.maxWidth : 0;
    for (final s in sizes.values) {
      height += s.height;
      crossSize = math.max(crossSize, s.width);
    }
    return constraints.constrain(Size(crossSize, height));
  }

  double _sum(double Function(RenderBox) f) {
    double total = 0;
    for (var c = firstChild; c != null; c = childAfter(c)) {
      total += f(c);
    }
    return total;
  }

  double _max(double Function(RenderBox) f) {
    double most = 0;
    for (var c = firstChild; c != null; c = childAfter(c)) {
      most = math.max(most, f(c));
    }
    return most;
  }

  @override
  double computeMinIntrinsicHeight(double width) =>
      _sum((c) => c.getMinIntrinsicHeight(width));
  @override
  double computeMaxIntrinsicHeight(double width) =>
      _sum((c) => c.getMaxIntrinsicHeight(width));
  @override
  double computeMinIntrinsicWidth(double height) =>
      _max((c) => c.getMinIntrinsicWidth(double.infinity));
  @override
  double computeMaxIntrinsicWidth(double height) =>
      _max((c) => c.getMaxIntrinsicWidth(double.infinity));

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);
}
