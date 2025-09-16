import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/shimmer/shimmer.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';

import '../../tester/test_widget.dart';

void main() {
  Widget buildShimmerCardWidget({
    Key? key,
    bool isLoading = true,
    Widget? child,
    Widget? skeleton,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return buildTestWidget(
      child: ShimmerCard(
        key: key,
        isLoading: isLoading,
        child: child,
        skeleton: skeleton,
        baseColor: baseColor,
        highlightColor: highlightColor,
      ),
    );
  }

  group('ShimmerCard', () {
    testWidgets('renders child when isLoading is false', (WidgetTester tester) async {
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: false,
        child: const Text('Content Loaded'),
      ));

      expect(find.text('Content Loaded'), findsOneWidget);
      expect(find.byType(ShimmerCard), findsOneWidget);
      expect(find.byType(ShaderMask), findsNothing);
    });

    testWidgets('renders skeleton when isLoading is true and skeleton is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: true,
        skeleton: Container(key: const ValueKey('custom_skeleton'), width: 100, height: 50, color: Colors.grey),
      ));

      expect(find.byKey(const ValueKey('custom_skeleton')), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('renders default skeleton when isLoading is true and no skeleton is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: true,
        child: const Text('Content Loaded'), // This child should not be rendered
      ));

      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byType(Text), findsNothing);
      expect(find.byType(Column), findsOneWidget); // Default skeleton uses Column
      expect(find.byType(AppGap), findsNWidgets(2));
    });

    testWidgets('renders SizedBox.shrink when isLoading is false and child is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: false,
        child: null,
      ));

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(ShimmerCard), findsOneWidget);
    });

    testWidgets('renders default skeleton when isLoading is true, skeleton is null, and child is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: true,
        child: null,
        skeleton: null,
      ));

      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byType(Column), findsOneWidget); // Default skeleton uses Column
      expect(find.byType(AppGap), findsNWidgets(2));
    });

    // Golden Tests
    testWidgetGoldens('Golden test - ShimmerCard with content (isLoading: false)',
        variants: ValueVariant<Size>(<Size>{const Size(400, 100)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 100));
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: false,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Main Title', style: TextStyle(fontSize: 24)),
              SizedBox(height: 8),
              Text('Subtitle text goes here.', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ));
      await tester.takeGolden('shimmer_card_content_loaded');
    });

    testWidgetGoldens('Golden test - ShimmerCard with custom skeleton (isLoading: true)',
        variants: ValueVariant<Size>(<Size>{const Size(400, 100)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 100));
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: true,
        skeleton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 200,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ));
      // Pump multiple times to allow shimmer animation to progress
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.takeGolden('shimmer_card_custom_skeleton');
    });

    testWidgetGoldens('Golden test - ShimmerCard with default skeleton (isLoading: true)',
        variants: ValueVariant<Size>(<Size>{const Size(400, 120)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 120));
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: true,
        child: const Text('This should not be visible'),
      ));
      // Pump multiple times to allow shimmer animation to progress
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.takeGolden('shimmer_card_default_skeleton');
    });
  testWidgetGoldens('Golden test - ShimmerCard with complex custom skeleton (isLoading: true)',
        variants: ValueVariant<Size>(<Size>{const Size(400, 250)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 250));
      await tester.pumpWidget(buildShimmerCardWidget(
        isLoading: true,
        skeleton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const AppGap.medium(),
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const AppGap.small2(),
              Container(
                width: 250,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const AppGap.small1(),
              Container(
                width: 200,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const AppGap.large1(),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  const AppGap.small2(),
                  Container(
                    width: 80,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 1000));
      await tester.takeGolden('shimmer_card_complex_custom_skeleton');
    });
  });
}
