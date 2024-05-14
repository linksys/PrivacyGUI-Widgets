import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  //
  static const double railWidth = 120;
  // Mobile
  static const double layoutBreakpoint1 = 320;
  static const double layoutBreakpoint2 = 480;
  // Tablet
  static const double layoutBreakpoint3 = 744;
  static const double layoutBreakpoint4 = 1024;
  // Desktop
  static const double layoutBreakpoint5 = 1280;
  static const double layoutBreakpoint6 = 1440;

  static double tabletBreakpoint = layoutBreakpoint3;
  static double desktopBreakpoint = layoutBreakpoint5;

  static double pageHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width - railWidth) {
      <= layoutBreakpoint1 => 16.0,
      <= layoutBreakpoint2 => 16.0,
      <= layoutBreakpoint3 => 48.0,
      <= layoutBreakpoint4 => 48.0,
      <= layoutBreakpoint5 => 96.0,
      <= layoutBreakpoint6 => 96.0,
      _ => 96.0,
    };
  }

  static double pageMainWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return switch (width) {
      <= layoutBreakpoint1 =>
        layoutBreakpoint1 - pageHorizontalPadding(context) * 2,
      <= layoutBreakpoint2 =>
        layoutBreakpoint2 - pageHorizontalPadding(context) * 2,
      <= layoutBreakpoint3 =>
        layoutBreakpoint3 - pageHorizontalPadding(context) * 2,
      <= layoutBreakpoint4 + railWidth =>
        layoutBreakpoint4 - pageHorizontalPadding(context) * 2,
      <= layoutBreakpoint5 + railWidth =>
        layoutBreakpoint5 - pageHorizontalPadding(context) * 2,
      <= layoutBreakpoint6 + railWidth =>
        layoutBreakpoint6 - pageHorizontalPadding(context) * 2,
      _ => layoutBreakpoint6 - pageHorizontalPadding(context) * 2,
    };
  }
  //

  static isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;

  static isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static isLayoutBreakpoint(BuildContext context) =>
      MediaQuery.of(context).size.width < layoutBreakpoint5;

  static isOverBreakpoint1(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint1;
  static isOverBreakpoint2(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint2;
  static isOverBreakpoint3(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint3;
  static isOverBreakpoint4(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint4;
  static isOverBreakpoint5(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint5;
  static isOverBreakpoint6(BuildContext context) =>
      MediaQuery.of(context).size.width >= layoutBreakpoint6;

  const ResponsiveLayout({
    super.key,
    required this.desktop,
    required this.mobile,
  });
  final Widget desktop;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    if (isLayoutBreakpoint(context)) {
      return mobile;
    } else {
      return desktop;
    }
  }
}
