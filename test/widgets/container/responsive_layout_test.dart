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

typedef Grid = ({int columns, double margin, double gutter});

/// The layout flags, each named after the ResponsiveLayout method it holds:
/// isMobileLayout, isOverSmallLayout, isDesktopLayout, isOverMedimumLayout,
/// isOverLargeLayout and isOverExtraLargeLayout.
typedef Flags = ({
  bool mobile,
  bool overSmall,
  bool desktop,
  bool overMedium,
  bool overLarge,
  bool overExtraLarge,
});

Grid gridAt(BuildContext context) => (
      columns: ResponsiveLayout.maxColumn(context),
      margin: ResponsiveLayout.pageHorizontalPadding(context),
      gutter: ResponsiveLayout.columnPadding(context),
    );

Flags flagsAt(BuildContext context) => (
      mobile: ResponsiveLayout.isMobileLayout(context) as bool,
      overSmall: ResponsiveLayout.isOverSmallLayout(context) as bool,
      desktop: ResponsiveLayout.isDesktopLayout(context) as bool,
      overMedium: ResponsiveLayout.isOverMedimumLayout(context) as bool,
      overLarge: ResponsiveLayout.isOverLargeLayout(context) as bool,
      overExtraLarge: ResponsiveLayout.isOverExtraLargeLayout(context) as bool,
    );

/// Each band of the grid, from the breakpoint that starts it: its grid, and
/// the layout flags that hold in it.
const List<({double start, Grid grid, Flags flags})> bands = [
  (
    start: 0,
    grid: (columns: 4, margin: 16, gutter: 16),
    flags: (
      mobile: true,
      overSmall: false,
      desktop: false,
      overMedium: false,
      overLarge: false,
      overExtraLarge: false,
    ),
  ),
  (
    start: 600,
    grid: (columns: 8, margin: 32, gutter: 16),
    flags: (
      mobile: true,
      overSmall: true,
      desktop: false,
      overMedium: false,
      overLarge: false,
      overExtraLarge: false,
    ),
  ),
  (
    start: 905,
    grid: (columns: 12, margin: 24, gutter: 24),
    flags: (
      mobile: false,
      overSmall: true,
      desktop: true,
      overMedium: true,
      overLarge: false,
      overExtraLarge: false,
    ),
  ),
  (
    start: 1240,
    grid: (columns: 12, margin: 200, gutter: 20),
    flags: (
      mobile: false,
      overSmall: true,
      desktop: true,
      overMedium: true,
      overLarge: true,
      overExtraLarge: false,
    ),
  ),
  (
    start: 1440,
    grid: (columns: 12, margin: 256, gutter: 20),
    flags: (
      mobile: false,
      overSmall: true,
      desktop: true,
      overMedium: true,
      overLarge: true,
      overExtraLarge: true,
    ),
  ),
  (
    start: 1680,
    grid: (columns: 12, margin: 352, gutter: 20),
    flags: (
      mobile: false,
      overSmall: true,
      desktop: true,
      overMedium: true,
      overLarge: true,
      overExtraLarge: true,
    ),
  ),
];

void main() {
  group('ResponsiveLayout on both sides of every breakpoint', () {
    // A breakpoint starts its band, for the grid and the layout flags alike.
    // The grid used to switch with `<=` and the flags with `>=`, so exactly on
    // 600, 1240 and 1440 a flag already reported the next band while the grid
    // was still the last one's. At 600 the Wi-Fi advanced list was then twice
    // as wide as the page (#1876).
    for (final (index, band) in bands.indexed.skip(1)) {
      final below = bands[index - 1];
      for (final (width, expected) in [
        (band.start - 1, below),
        (band.start, band),
        (band.start + 1, band),
      ]) {
        testWidgets('$width is in the band that starts at ${expected.start}',
            (tester) async {
          final (grid, flags, columnSize) = await readAt(
            tester,
            width,
            (c) => (gridAt(c), flagsAt(c), ResponsiveLayout.columnSize(c)),
          );

          expect(grid, expected.grid);
          expect(flags, expected.flags);
          expect(columnSize, greaterThan(0));
        });
      }
    }
  });

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
