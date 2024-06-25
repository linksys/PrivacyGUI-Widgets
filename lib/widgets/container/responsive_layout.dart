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

  static double tabletBreakpoint = medium;
  static double desktopBreakpoint = large;

  static double pageHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= small => 16.0,
      <= medium => 32.0,
      <= large => 39.0,
      <= extraLarge => 200.0,
      _ => 178.0,
    };
  }

  static double columnPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= small => Spacing.medium,
      <= medium => Spacing.medium,
      <= large => Spacing.small3,
      <= extraLarge => Spacing.large1,
      _ => Spacing.large1,
    };
  }

  static double columnSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= small => 70,
      <= medium => 53,
      <= large => 52,
      <= extraLarge => 55,
      _ => 72,
    };
    // return (width -
    //         (pageHorizontalPadding(context) * 2) -
    //         (columnPadding(context) * (maxColumn(context) - 1))) /
    //     maxColumn(context);
  }

  static int maxColumn(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= small => 4,
      <= medium => 8,
      <= large => 12,
      <= extraLarge => 12,
      _ => 12,
    };
  }

  static int getColumn(BuildContext context, int? desiredColumn) {
    return desiredColumn == null
        ? maxColumn(context)
        : min(desiredColumn, maxColumn(context));
  }
  //

  static isDesktopLayout(BuildContext context) =>
      MediaQuery.of(context).size.width >= medium;
  static isMobileLayout(BuildContext context) =>
      MediaQuery.of(context).size.width < medium;

  static isOverSmallLayout(BuildContext context) =>
      MediaQuery.of(context).size.width >= small;
  static isOverMedimumLayout(BuildContext context) =>
      MediaQuery.of(context).size.width >= medium;
  static isOverLargeLayout(BuildContext context) =>
      MediaQuery.of(context).size.width >= large;
  static isOverExtraLargeLayout(BuildContext context) =>
      MediaQuery.of(context).size.width >= extraLarge;

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
