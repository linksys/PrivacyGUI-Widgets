import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A column that gives one child the rest of its height, and whose own height
/// may be unbounded, as a scrolling page's is.
///
/// Every child but the one at [fillIndex] takes its own height. Then:
///
/// - under a bounded height, the child at [fillIndex] gets exactly what is
///   left, as an [Expanded] in a [Column] would;
/// - under an unbounded height, it gets at least what is left of the incoming
///   minimum height, and no maximum. In a scrolling page that is at least the
///   viewport tall, it fills the rest of a short page (a [Center] in it
///   centres, a footer after it sits at the bottom) and grows with a long one.
///
/// That is what an [Expanded] under an [IntrinsicHeight] gave, without asking
/// any child for its intrinsic height, which a child can under-report
/// (linksys/PrivacyGUI#1864). Use it where a scrolling page would need an
/// [Expanded] or a [Spacer]: in a [Column] whose height is unbounded, those
/// throw.
///
/// Children are placed across as in a [Column], including start and end in a
/// right-to-left locale, and an overflow is reported as a [Column] reports it.
///
/// A [Gap] cannot be a direct child: it needs a [Flex] or a scroll view to
/// know its direction, and outside a scroll view FillColumn has neither. Use a
/// [SizedBox], or put the gaps in a [Column] inside.
class FillColumn extends MultiChildRenderObjectWidget {
  const FillColumn({
    super.key,
    required this.fillIndex,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required super.children,
  });

  /// The index in [children] of the child that gets the rest of the height.
  final int fillIndex;

  /// How the children are placed horizontally.
  final CrossAxisAlignment crossAxisAlignment;

  @override
  RenderFillColumn createRenderObject(BuildContext context) => RenderFillColumn(
        fillIndex: fillIndex,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: Directionality.maybeOf(context),
      );

  @override
  void updateRenderObject(BuildContext context, RenderFillColumn renderObject) {
    renderObject
      ..fillIndex = fillIndex
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = Directionality.maybeOf(context);
  }
}

class FillColumnParentData extends ContainerBoxParentData<RenderBox> {}

/// The render object of [FillColumn].
class RenderFillColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, FillColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, FillColumnParentData>,
        DebugOverflowIndicatorMixin {
  RenderFillColumn({
    required int fillIndex,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    TextDirection? textDirection,
  })  : _fillIndex = fillIndex,
        _crossAxisAlignment = crossAxisAlignment,
        _textDirection = textDirection;

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

  // Decides which side start and end are, as in a Column.
  TextDirection? _textDirection;
  set textDirection(TextDirection? value) {
    if (value == _textDirection) return;
    _textDirection = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! FillColumnParentData) {
      child.parentData = FillColumnParentData();
    }
  }

  @override
  void performLayout() {
    final (:size, :contentHeight) =
        _measure(constraints, ChildLayoutHelper.layoutChild);
    this.size = size;
    _contentHeight = contentHeight;

    final rtl = _textDirection == TextDirection.rtl;
    double y = 0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final free = size.width - child.size.width;
      final x = switch (_crossAxisAlignment) {
        CrossAxisAlignment.start => rtl ? free : 0.0,
        CrossAxisAlignment.end => rtl ? 0.0 : free,
        CrossAxisAlignment.center => free / 2,
        _ => 0.0,
      };
      (child.parentData! as FillColumnParentData).offset = Offset(x, y);
      y += child.size.height;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      _measure(constraints, ChildLayoutHelper.dryLayoutChild).size;

  /// Lays out or measures every child with [layoutChild], and returns this
  /// column's size and the children's total height.
  ({Size size, double contentHeight}) _measure(
      BoxConstraints constraints, ChildLayouter layoutChild) {
    assert(_fillIndex >= 0 && _fillIndex < childCount,
        'fillIndex $_fillIndex is not the index of one of the $childCount children.');
    final stretch = _crossAxisAlignment == CrossAxisAlignment.stretch;
    final across = stretch
        ? BoxConstraints.tightFor(width: constraints.maxWidth)
        : BoxConstraints(maxWidth: constraints.maxWidth);
    double height = 0;
    double crossSize = stretch ? constraints.maxWidth : 0;
    void add(Size childSize) {
      height += childSize.height;
      crossSize = math.max(crossSize, childSize.width);
    }

    RenderBox? fill;
    var index = 0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      if (index++ == _fillIndex) {
        fill = child;
      } else {
        add(layoutChild(child, across));
      }
    }
    if (fill != null) {
      // Bounded, this is a Column with the fill child in an Expanded: it gets
      // exactly what is left. Unbounded, it gets at least what is left of the
      // minimum, and grows the column past it.
      final bounded = constraints.hasBoundedHeight;
      final rest = math.max(0.0,
          (bounded ? constraints.maxHeight : constraints.minHeight) - height);
      add(layoutChild(
          fill,
          across.copyWith(
              minHeight: rest, maxHeight: bounded ? rest : double.infinity)));
    }
    return (
      size: constraints.constrain(Size(crossSize, height)),
      contentHeight: height,
    );
  }

  // The children's total height. It is more than [size]'s when a bounded
  // height is too short for them, which [paint] reports as a Column would.
  double _contentHeight = 0;

  double _sum(double Function(RenderBox child) of) {
    double total = 0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      total += of(child);
    }
    return total;
  }

  double _max(double Function(RenderBox child) of) {
    double most = 0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      most = math.max(most, of(child));
    }
    return most;
  }

  @override
  double computeMinIntrinsicHeight(double width) =>
      _sum((child) => child.getMinIntrinsicHeight(width));

  @override
  double computeMaxIntrinsicHeight(double width) =>
      _sum((child) => child.getMaxIntrinsicHeight(width));

  @override
  double computeMinIntrinsicWidth(double height) =>
      _max((child) => child.getMinIntrinsicWidth(double.infinity));

  @override
  double computeMaxIntrinsicWidth(double height) =>
      _max((child) => child.getMaxIntrinsicWidth(double.infinity));

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
