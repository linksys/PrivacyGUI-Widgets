import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/page/layout/fill_column.dart';

const _header = Key('header');
const _fill = Key('fill');
const _footer = Key('footer');

/// Pumps [child] under [constraints], top left, in [direction].
Future<void> pumpUnder(
  WidgetTester tester,
  BoxConstraints constraints,
  Widget child, {
  TextDirection direction = TextDirection.ltr,
}) {
  return tester.pumpWidget(
    Directionality(
      textDirection: direction,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minWidth: constraints.minWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight,
        maxHeight: constraints.maxHeight,
        child: child,
      ),
    ),
  );
}

/// A header and a footer of fixed height around a fill child of [fillHeight].
FillColumn threeRows({
  double? fillHeight,
  double? width,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
}) {
  return FillColumn(
    fillIndex: 1,
    crossAxisAlignment: crossAxisAlignment,
    children: [
      SizedBox(key: _header, width: width, height: 50),
      SizedBox(key: _fill, width: width, height: fillHeight),
      SizedBox(key: _footer, width: width, height: 30),
    ],
  );
}

Rect rectOf(WidgetTester tester, Key key) => tester.getRect(find.byKey(key));

void main() {
  group('FillColumn under an unbounded height', () {
    testWidgets('gives the fill child what is left of the minimum height',
        (tester) async {
      // A short scrolling page: at least 400 tall, so the footer sits at the
      // bottom of it.
      await pumpUnder(
        tester,
        const BoxConstraints(
            maxWidth: 300, minHeight: 400, maxHeight: double.infinity),
        threeRows(),
      );

      expect(rectOf(tester, _header), const Rect.fromLTWH(0, 0, 0, 50));
      expect(rectOf(tester, _fill), const Rect.fromLTWH(0, 50, 0, 320));
      expect(rectOf(tester, _footer), const Rect.fromLTWH(0, 370, 0, 30));
      expect(tester.getSize(find.byType(FillColumn)).height, 400);
    });

    testWidgets('grows with a fill child taller than the rest', (tester) async {
      // A long scrolling page: the content keeps its own height and the page
      // scrolls, where IntrinsicHeight could have under-reported it.
      await pumpUnder(
        tester,
        const BoxConstraints(
            maxWidth: 300, minHeight: 400, maxHeight: double.infinity),
        threeRows(fillHeight: 600),
      );

      expect(rectOf(tester, _fill), const Rect.fromLTWH(0, 50, 0, 600));
      expect(rectOf(tester, _footer), const Rect.fromLTWH(0, 650, 0, 30));
      expect(tester.getSize(find.byType(FillColumn)).height, 680);
    });
  });

  group('FillColumn under a bounded height', () {
    testWidgets('gives the fill child exactly what is left, as Expanded does',
        (tester) async {
      // A page that does not scroll: the content cannot grow the page.
      await pumpUnder(
        tester,
        const BoxConstraints(maxWidth: 300, maxHeight: 400),
        threeRows(fillHeight: 600),
      );

      expect(rectOf(tester, _fill), const Rect.fromLTWH(0, 50, 0, 320));
      expect(rectOf(tester, _footer), const Rect.fromLTWH(0, 370, 0, 30));
      expect(tester.getSize(find.byType(FillColumn)).height, 400);
    });

    testWidgets('reports an overflow as a Column does', (tester) async {
      // #1802's layout gate collects overflows by this message, so a page
      // that lays out through FillColumn stays visible to it.
      await pumpUnder(
        tester,
        const BoxConstraints(maxWidth: 300, maxHeight: 60),
        threeRows(),
      );

      final error = tester.takeException();
      expect(error, isA<FlutterError>());
      expect(
          error.toString(), contains('overflowed by 20 pixels on the bottom'));
      expect(rectOf(tester, _footer), const Rect.fromLTWH(0, 50, 0, 30));
    });
  });

  group('FillColumn across', () {
    // A 200-wide header over a 100-wide fill child and footer.
    FillColumn narrowBelowWide(CrossAxisAlignment alignment) => FillColumn(
          fillIndex: 1,
          crossAxisAlignment: alignment,
          children: const [
            SizedBox(key: _header, width: 200, height: 50),
            SizedBox(key: _fill, width: 100),
            SizedBox(key: _footer, width: 100, height: 30),
          ],
        );
    const unbounded = BoxConstraints(
        maxWidth: 300, minHeight: 400, maxHeight: double.infinity);

    testWidgets('start is the right edge in a right-to-left locale',
        (tester) async {
      await pumpUnder(
        tester,
        unbounded,
        narrowBelowWide(CrossAxisAlignment.start),
        direction: TextDirection.rtl,
      );

      expect(tester.getSize(find.byType(FillColumn)), const Size(200, 400));
      expect(rectOf(tester, _fill), const Rect.fromLTWH(100, 50, 100, 320));
      expect(rectOf(tester, _footer), const Rect.fromLTWH(100, 370, 100, 30));
    });

    testWidgets('center and end place children as a Column does',
        (tester) async {
      await pumpUnder(
          tester, unbounded, narrowBelowWide(CrossAxisAlignment.center));
      expect(rectOf(tester, _footer).left, 50);

      await pumpUnder(
          tester, unbounded, narrowBelowWide(CrossAxisAlignment.end));
      expect(rectOf(tester, _footer).left, 100);
    });

    testWidgets('stretch makes every child as wide as the column',
        (tester) async {
      await pumpUnder(
          tester, unbounded, narrowBelowWide(CrossAxisAlignment.stretch));

      expect(tester.getSize(find.byType(FillColumn)), const Size(300, 400));
      expect(rectOf(tester, _header), const Rect.fromLTWH(0, 0, 300, 50));
      expect(rectOf(tester, _fill), const Rect.fromLTWH(0, 50, 300, 320));
    });
  });

  testWidgets('FillColumn reports its intrinsic size as a Column does',
      (tester) async {
    // A dialog sizes its content by IntrinsicWidth, and some pages are sized
    // by IntrinsicHeight: the widest child and the sum of the heights.
    await pumpUnder(
      tester,
      const BoxConstraints(maxWidth: 300, maxHeight: 600),
      IntrinsicWidth(
        child: IntrinsicHeight(
          child: FillColumn(
            fillIndex: 1,
            children: const [
              SizedBox(width: 200, height: 50),
              SizedBox(key: _fill, width: 100, height: 70),
              SizedBox(width: 100, height: 30),
            ],
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(FillColumn)), const Size(200, 150));
    expect(rectOf(tester, _fill), const Rect.fromLTWH(0, 50, 100, 70));
  });

  testWidgets('FillColumn computes a dry layout of the size it lays out to',
      (tester) async {
    await pumpUnder(
      tester,
      const BoxConstraints(maxWidth: 300, maxHeight: 600),
      threeRows(width: 120, fillHeight: 600),
    );
    final column = tester.renderObject<RenderBox>(find.byType(FillColumn));

    expect(
      column.getDryLayout(const BoxConstraints(
          maxWidth: 300, minHeight: 400, maxHeight: double.infinity)),
      const Size(120, 680),
    );
    expect(
      column.getDryLayout(const BoxConstraints(maxWidth: 300, maxHeight: 400)),
      const Size(120, 400),
    );
  });
}
