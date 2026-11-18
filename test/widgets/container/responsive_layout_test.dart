import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/container/responsive_layout.dart';

/// Pumps a context [width] wide and returns what [read] reads from it.
Future<T> readAt<T>(
  WidgetTester tester,
  double width,
  T Function(BuildContext context) read,
) async {
  late T value;
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: Builder(builder: (context) {
        value = read(context);
        return const SizedBox();
      }),
    ),
  );
  return value;
}

void main() {
  group('ResponsiveLayout at the desktop breakpoint', () {
    testWidgets('905 is desktop and gets the 12-column grid', (tester) async {
      // isDesktopLayout is `>= medium`; the grid used `<= medium`, so at
      // exactly 905 a desktop layout was laid out on the 8-column grid.
      final grid = await readAt(
        tester,
        905,
        (c) => (
          ResponsiveLayout.isDesktopLayout(c) as bool,
          ResponsiveLayout.maxColumn(c),
          ResponsiveLayout.pageHorizontalPadding(c),
          ResponsiveLayout.columnPadding(c),
        ),
      );

      expect(grid, (true, 12, 24.0, 24.0));
    });

    testWidgets('a 12-column desktop row fits the page at 905',
        (tester) async {
      // A desktop row such as `4.col + gutter + 8.col` spans 12 columns. On
      // the 8-column grid it needed 1269.5px of an 841px page.
      final (row, page) = await readAt(
        tester,
        905,
        (c) => (
          12 * ResponsiveLayout.columnSize(c) +
              11 * ResponsiveLayout.columnPadding(c),
          905 - 2 * ResponsiveLayout.pageHorizontalPadding(c),
        ),
      );

      expect(row, lessThanOrEqualTo(page + 0.001));
    });

    testWidgets('904 is still mobile, on the 8-column grid', (tester) async {
      final grid = await readAt(
        tester,
        904,
        (c) => (
          ResponsiveLayout.isMobileLayout(c) as bool,
          ResponsiveLayout.maxColumn(c),
          ResponsiveLayout.pageHorizontalPadding(c),
          ResponsiveLayout.columnPadding(c),
        ),
      );

      expect(grid, (true, 8, 32.0, 16.0));
    });
  });
}
