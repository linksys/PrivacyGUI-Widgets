import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Lays out [child] as a page of [height] would, when the child fits in it,
/// and at its own height when it does not.
///
/// The child is laid out with the incoming constraints first; in a scrolling
/// page they have no maximum height. If it comes out shorter than [height], it
/// is laid out again with [height] as its maximum, never above the incoming
/// one. That is what a short page's content got under an [IntrinsicHeight]: a
/// [Center] or a [Column] fills the page, and a card keeps its own height. A
/// taller child keeps its own height, and the page scrolls.
///
/// It is for a scrolling page's content, whose height is unbounded. Under a
/// bounded height no taller than [height], the child is laid out as it would
/// be without it. The cost is one more layout of the child while it is short.
/// A [LayoutBuilder] in the child whose tree depends on the height builds a
/// different tree on each pass, and the state in it is lost.
class FitOrGrow extends SingleChildRenderObjectWidget {
  const FitOrGrow({super.key, required this.height, super.child});

  /// The height that a child shorter than it is fitted to.
  final double height;

  @override
  RenderFitOrGrow createRenderObject(BuildContext context) =>
      RenderFitOrGrow(height: height);

  @override
  void updateRenderObject(BuildContext context, RenderFitOrGrow renderObject) {
    renderObject.height = height;
  }
}

/// The render object of [FitOrGrow].
class RenderFitOrGrow extends RenderProxyBox {
  RenderFitOrGrow({required double height}) : _height = height;

  double _height;
  set height(double value) {
    if (value == _height) return;
    _height = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = _fit(constraints, ChildLayoutHelper.layoutChild);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      _fit(constraints, ChildLayoutHelper.dryLayoutChild);

  Size _fit(BoxConstraints constraints, ChildLayouter layoutChild) {
    final child = this.child;
    if (child == null) return constraints.smallest;
    var size = layoutChild(child, constraints);
    if (size.height < _height) {
      // [height] as the maximum, but never above the one this box was given.
      final fitted = constraints.copyWith(
          maxHeight: math.max(
              constraints.minHeight, math.min(constraints.maxHeight, _height)));
      size = layoutChild(child, fitted);
    }
    return constraints.constrain(size);
  }
}
