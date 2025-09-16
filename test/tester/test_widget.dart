import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:privacygui_widgets/theme/custom_responsive.dart';

import '../font_loader.dart';

const rootFolder =
    String.fromEnvironment('goldenRoot', defaultValue: 'goldens');

extension WidgetTesterExtension on WidgetTester {
  Future<void> setScreenSize(Size size) async {
    return _setScreenSize(
      width: size.width,
      height: size.height,
    );
  }

  Future<void> _setScreenSize({
    required double width,
    required double height,
  }) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    view.physicalSize = size;
  }

  Future<void> takeGolden(String name) async {
    final actualFinder = find.byWidgetPredicate((w) => true).first;
    await expectLater(
        actualFinder,
        matchesGoldenFile(
            '$rootFolder/$name-${view.physicalSize.width}x${view.physicalSize.height}.png'));
  }
}

@isTest
void testWidgetGoldens(
  String description,
  WidgetTesterCallback callback, {
  String? goldenFilename,
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  ValueVariant<Size>? variants,
  List<String>? tags,
}) {
  final variant = variants ?? ValueVariant<Size>(<Size>{});
  testWidgets(
    description,
    (tester) async {
      if (variant.currentValue != null) {
        await tester.setScreenSize(variant.currentValue!);
      }
      await callback(tester);
      if (goldenFilename != null) {
        await tester.takeGolden(goldenFilename);
      }
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: ['Golden', ...tags ?? []],
  );
}

Widget buildTestWidget({required Widget child}) {
  return MaterialApp(
    theme: mockLightThemeData,
    darkTheme: mockDarkThemeData,
    debugShowCheckedModeBanner: false,
    home: CustomResponsive(
      child: Scaffold(
        body: child,
      ),
    ),
  );
}
