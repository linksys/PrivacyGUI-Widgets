import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/page/layout/fit_or_grow.dart';

const _box = Key('box');

/// Pumps [child] top left under a 300-wide [maxHeight], unbounded by default
/// as in a scrolling page.
Future<void> pumpUnder(WidgetTester tester, Widget child,
    {double maxHeight = double.infinity}) {
  return tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minWidth: 300,
        maxWidth: 300,
        minHeight: 0,
        maxHeight: maxHeight,
        child: child,
      ),
    ),
  );
}

Size sizeOfFit(WidgetTester tester) => tester.getSize(find.byType(FitOrGrow));

Rect rectOfBox(WidgetTester tester) => tester.getRect(find.byKey(_box));

void main() {
  testWidgets('a short child is fitted to the height, so a Center centres',
      (tester) async {
    // What a short page's content got under IntrinsicHeight: the rest of the
    // page as its maximum.
    await pumpUnder(
      tester,
      const FitOrGrow(
        height: 400,
        child: Center(child: SizedBox(key: _box, width: 100, height: 100)),
      ),
    );

    expect(sizeOfFit(tester), const Size(300, 400));
    expect(rectOfBox(tester), const Rect.fromLTWH(100, 150, 100, 100));
  });

  testWidgets('a short child that does not expand keeps its own height',
      (tester) async {
    // A card on a short page stays as tall as its content.
    await pumpUnder(
      tester,
      const FitOrGrow(
        height: 400,
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: 1,
          child: SizedBox(key: _box, width: 100, height: 100),
        ),
      ),
    );

    expect(sizeOfFit(tester), const Size(300, 100));
  });

  testWidgets('a tall child keeps its own height, and the page scrolls',
      (tester) async {
    await pumpUnder(
      tester,
      const FitOrGrow(
        height: 400,
        child: Center(child: SizedBox(key: _box, width: 100, height: 700)),
      ),
    );

    expect(sizeOfFit(tester), const Size(300, 700));
    expect(rectOfBox(tester), const Rect.fromLTWH(100, 0, 100, 700));
  });

  testWidgets('a bounded maximum below the height still holds', (tester) async {
    // Inside content that is being fitted itself, as PnP's overlay is: the
    // child gets no more than its parent allows.
    await pumpUnder(
      tester,
      const FitOrGrow(
        height: 400,
        child: Center(child: SizedBox(key: _box, width: 100, height: 100)),
      ),
      maxHeight: 300,
    );

    expect(sizeOfFit(tester), const Size(300, 300));
    expect(rectOfBox(tester), const Rect.fromLTWH(100, 100, 100, 100));
  });

  testWidgets('computes a dry layout of the size it lays out to',
      (tester) async {
    await pumpUnder(
      tester,
      const FitOrGrow(
        height: 400,
        child: Center(child: SizedBox(key: _box, width: 100, height: 100)),
      ),
    );
    final fit = tester.renderObject<RenderBox>(find.byType(FitOrGrow));

    expect(fit.getDryLayout(const BoxConstraints(maxWidth: 300)),
        const Size(300, 400));
    expect(
        fit.getDryLayout(const BoxConstraints(maxWidth: 300, maxHeight: 250)),
        const Size(300, 250));
  });
}
