import 'dart:math';

import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

class ResponsiveLayout extends StatelessWidget {
  //
  static const double naviRailWidth = 80;
  static const double naviRailWidthThin = 72;
  // Mobile
  static const double small = 600;
  // Tablet
  static const double medium = 905;
  // Desktop
  static const double large = 1240;
  static const double extraLarge = 1440;
  static const double extraExtraLarge = 1680;

  static double tabletBreakpoint = medium;
  static double desktopBreakpoint = large;

  /// The breakpoint that starts the band [context]'s width is in: the widest
  /// of [small], [medium], [large], [extraLarge] and [extraExtraLarge] it has
  /// reached, or 0 below [small]. A width exactly on a breakpoint is in the
  /// band that breakpoint starts.
  ///
  /// The grid and the layout flags all read this, so they agree on every
  /// width. They used to compare the width themselves, the grid with `<=` and
  /// the flags with `>=`, so exactly on a breakpoint a flag already reported
  /// the next band while the grid was still the last one's. At 905 a desktop
  /// row overflowed the 8-column grid by 429px (PrivacyGUI#1802), and at 600
  /// PrivacyGUI's Wi-Fi advanced list was twice as wide as the page
  /// (PrivacyGUI#1876).
  static double _bandStart(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      >= extraExtraLarge => extraExtraLarge,
      >= extraLarge => extraLarge,
      >= large => large,
      >= medium => medium,
      >= small => small,
      _ => 0,
    };
  }

  /// The grid of [context]'s band ([_bandStart]): the page margin on each
  /// side, the gutter between columns, and the number of columns.
  static ({double margin, double gutter, int columns}) _grid(
          BuildContext context) =>
      switch (_bandStart(context)) {
        extraExtraLarge => (margin: 352, gutter: Spacing.large1, columns: 12),
        extraLarge => (margin: 256, gutter: Spacing.large1, columns: 12),
        large => (margin: 200, gutter: Spacing.large1, columns: 12),
        medium => (margin: 24, gutter: Spacing.large2, columns: 12),
        small => (margin: 32, gutter: Spacing.medium, columns: 8),
        _ => (margin: 16, gutter: Spacing.medium, columns: 4),
      };

  static double pageHorizontalPadding(BuildContext context) =>
      _grid(context).margin;

  static double columnPadding(BuildContext context) => _grid(context).gutter;

  static double columnSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width -
            (pageHorizontalPadding(context) * 2) -
            (columnPadding(context) * (maxColumn(context) - 1))) /
        maxColumn(context);
  }

  static int maxColumn(BuildContext context) => _grid(context).columns;

  static double getContentWidth(BuildContext context) =>
      maxColumn(context) * columnSize(context) +
      (maxColumn(context) - 1) * columnPadding(context);

  static int getColumn(BuildContext context, int? desiredColumn) {
    return desiredColumn == null
        ? maxColumn(context)
        : min(desiredColumn, maxColumn(context));
  }
  //

  static isDesktopLayout(BuildContext context) => _bandStart(context) >= medium;
  static isMobileLayout(BuildContext context) => _bandStart(context) < medium;

  static isOverSmallLayout(BuildContext context) =>
      _bandStart(context) >= small;
  static isOverMedimumLayout(BuildContext context) =>
      _bandStart(context) >= medium;
  static isOverLargeLayout(BuildContext context) =>
      _bandStart(context) >= large;
  static isOverExtraLargeLayout(BuildContext context) =>
      _bandStart(context) >= extraLarge;

  const ResponsiveLayout({
    super.key,
    required this.desktop,
    required this.mobile,
  });
  final Widget desktop;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    if (isMobileLayout(context)) {
      return mobile;
    } else {
      return desktop;
    }
  }
}
