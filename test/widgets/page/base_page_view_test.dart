import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/page/base_page_view.dart';
import 'package:privacygui_widgets/widgets/page/layout/basic_layout.dart';

const _text = Key('text');
const _column = Key('column');

/// Pumps an [AppPageView] in an 800-wide window of [height].
Future<void> pumpPage(
  WidgetTester tester, {
  required double height,
  required bool scrollable,
  required Widget content,
}) async {
  tester.view.physicalSize = Size(800, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      home: AppPageView(
        scrollable: scrollable,
        child: (context, constraints) => content,
      ),
    ),
  );
}

void main() {
  group('AppPageView, scrolling', () {
    testWidgets('lays out a column-width box at the height its text needs',
        (tester) async {
      // #1864: SizedBox(width: N.col) reports its child's intrinsic height at
      // the full page width, where the text wraps onto fewer lines. Under
      // IntrinsicHeight the page came out too short and the column
      // overflowed.
      await pumpPage(
        tester,
        height: 100,
        scrollable: true,
        content: AppBasicLayout(
          content: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 200,
              child: Column(
                key: _column,
                children: [
                  Text('word ' * 60,
                      key: _text, style: const TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      final textHeight = tester.getSize(find.byKey(_text)).height;
      expect(textHeight, greaterThan(100));
      expect(tester.getSize(find.byKey(_column)).height, textHeight);
    });

    testWidgets('keeps the footer of a short page at the bottom',
        (tester) async {
      await pumpPage(
        tester,
        height: 600,
        scrollable: true,
        content: footerPage,
      );

      expect(tester.takeException(), isNull);
      expect(footerRect(tester).bottom, 600 - Spacing.small3);
    });

    testWidgets('shows the grid overlay over the whole page', (tester) async {
      // The overlay's strips ask for an infinite height, which a scrolling
      // page no longer bounds.
      tester.view.physicalSize = const Size(800, 300);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          home: AppPageView(
            scrollable: true,
            isOverlayVisible: true,
            child: (context, constraints) =>
                const SizedBox(key: _column, height: 500),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      final strips = find.byWidgetPredicate((widget) =>
          widget is ColoredBox && widget.color == Colors.red.withOpacity(0.2));
      // 8 columns at 800px, each as tall as the page's content.
      expect(strips, findsNWidgets(8));
      for (final strip in strips.evaluate()) {
        expect((strip.renderObject! as RenderBox).size.height, 500);
      }
    });
  });

  group('AppPageView, not scrolling', () {
    testWidgets('gives the content the whole page', (tester) async {
      await pumpPage(
        tester,
        height: 600,
        scrollable: false,
        content: footerPage,
      );

      expect(tester.takeException(), isNull);
      expect(footerRect(tester).bottom, 600 - Spacing.small3);
    });
  });
}

const _footer = Key('footer');

/// A page whose header, content and footer take 130 of its height.
const footerPage = AppBasicLayout(
  header: SizedBox(height: 40),
  content: SizedBox(height: 50),
  footer: SizedBox(key: _footer, height: 40),
);

Rect footerRect(WidgetTester tester) => tester.getRect(find.byKey(_footer));
