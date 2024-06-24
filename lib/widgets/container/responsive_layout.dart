import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  //
  static const double railWidth = 120;
  // Mobile
  static const double layoutBreakpoint1 = 600;
  // Tablet
  static const double layoutBreakpoint2 = 905;
  // Desktop
  static const double layoutBreakpoint3 = 1240;
  static const double layoutBreakpoint4 = 1440;

  static double tabletBreakpoint = layoutBreakpoint2;
  static double desktopBreakpoint = layoutBreakpoint3;

  static double pageHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= layoutBreakpoint1 => 16.0,
      <= layoutBreakpoint2 => 32.0,
      <= layoutBreakpoint3 => 39.0,
      <= layoutBreakpoint4 => 200.0,
      _ => 178.0,
    };
  }

  static double columnPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= layoutBreakpoint1 => 16.0,
      <= layoutBreakpoint2 => 16.0,
      <= layoutBreakpoint3 => 12.0,
      <= layoutBreakpoint4 => 20.0,
      _ => 20.0,
    };
  }

  static double columnSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= layoutBreakpoint1 => 70,
      <= layoutBreakpoint2 => 53,
      <= layoutBreakpoint3 => 52,
      <= layoutBreakpoint4 => 55,
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
      <= layoutBreakpoint1 => 4,
      <= layoutBreakpoint2 => 8,
      <= layoutBreakpoint3 => 12,
      <= layoutBreakpoint4 => 12,
      _ => 12,
    };
  }

  static int getColumn(BuildContext context, int? desiredColumn) {
    return desiredColumn == null
        ? maxColumn(context)
        : min(desiredColumn, maxColumn(context));
  }
  //

  static isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static isMobileLayout(BuildContext context) =>
      MediaQuery.of(context).size.width < layoutBreakpoint2;

  static isOverBreakpoint1(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint1;
  static isOverBreakpoint2(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint2;
  static isOverBreakpoint3(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint3;
  static isOverBreakpoint4(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint4;

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
