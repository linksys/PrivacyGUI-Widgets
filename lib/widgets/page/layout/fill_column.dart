// PROTOTYPE #1864 option B: not for merge.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// A column whose height may be unbounded, as in a scrolling page.
///
/// Every child but the one at [fillIndex] takes its own height. The child at
/// [fillIndex] then gets at least what is left of the incoming minimum height,
/// and no maximum; under a bounded height it gets exactly what is left, as an
/// [Expanded] in a [Column] would. In a page that scrolls and is at least the viewport tall,
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
        RenderBoxContainerDefaultsMixin<RenderBox, _FillColumnParentData>,
        DebugOverflowIndicatorMixin {
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

  // The children's total height; more than [size] when a bounded height is
  // too short for them, which [paint] reports as a Column would.
  double _contentHeight = 0;

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
    _contentHeight = y;
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
      // Bounded, it is a Column with an Expanded: the fill child gets exactly
      // what is left. Unbounded, it gets at least what is left of the minimum.
      final bounded = constraints.hasBoundedHeight;
      final rest = math.max(0.0,
          (bounded ? constraints.maxHeight : constraints.minHeight) - fixed);
      sizes[fill] = layoutChild(fill,
          width.copyWith(minHeight: rest, maxHeight: bounded ? rest : null));
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
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
    assert(() {
      if (_contentHeight > size.height + precisionErrorTolerance) {
        paintOverflowIndicator(context, offset, Offset.zero & size,
            Offset.zero & Size(size.width, _contentHeight));
      }
      return true;
    }());
  }
}

/// Lays out [child] the way an unscrolled page of [height] would, when it fits.
///
/// The child is first laid out with no height limit. If it is shorter than
/// [height], it is laid out again with a maximum of [height] and no minimum,
/// which is what it got from a page under an [IntrinsicHeight]: a [Center] or
/// a full Column fills the page, a card keeps its own height. If it is taller,
/// it keeps its own height and the page scrolls. The cost is one more layout
/// of the child while the page is short.
class FitOrGrow extends SingleChildRenderObjectWidget {
  const FitOrGrow({super.key, required this.height, super.child});

  final double height;

  @override
  RenderFitOrGrow createRenderObject(BuildContext context) =>
      RenderFitOrGrow(height);

  @override
  void updateRenderObject(BuildContext context, RenderFitOrGrow renderObject) {
    renderObject.height = height;
  }
}

class RenderFitOrGrow extends RenderProxyBox {
  RenderFitOrGrow(this._height);

  double _height;
  set height(double value) {
    if (value == _height) return;
    _height = value;
    markNeedsLayout();
  }

  BoxConstraints _fit(BoxConstraints c) => c.copyWith(
      minHeight: 0, maxHeight: math.max(_height, c.minHeight));

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    child.layout(constraints.copyWith(minHeight: 0, maxHeight: double.infinity),
        parentUsesSize: true);
    if (_height.isFinite && child.size.height < _height) {
      child.layout(_fit(constraints), parentUsesSize: true);
    }
    size = constraints.constrain(child.size);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final child = this.child;
    if (child == null) return constraints.smallest;
    var s = child.getDryLayout(
        constraints.copyWith(minHeight: 0, maxHeight: double.infinity));
    if (_height.isFinite && s.height < _height) {
      s = child.getDryLayout(_fit(constraints));
    }
    return constraints.constrain(s);
  }
}
