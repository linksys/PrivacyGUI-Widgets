import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/toggle/quick_toggle_list.dart';
import 'package:privacygui_widgets/widgets/toggle/quick_toggle.dart';

import '../../tester/test_widget.dart';

void main() {
  Widget buildQuickPanelListWidget({
    Key? key,
    required List<QuickToggle> children,
    double? spacing,
    Widget? separator,
  }) {
    return buildTestWidget(
      child: QuickPanelList(
        key: key,
        children: children,
        spacing: spacing,
        separator: separator,
      ),
    );
  }

  group('QuickPanelList', () {
    testWidgets('renders multiple QuickToggle children correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Toggle 1',
            semantics: 'toggle_1',
            value: false,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle 2',
            semantics: 'toggle_2',
            value: true,
            onChanged: (value) {},
          ),
        ],
      ));

      expect(find.text('Toggle 1'), findsOneWidget);
      expect(find.text('Toggle 2'), findsOneWidget);
      expect(find.byType(QuickToggle), findsNWidgets(2));
    });

    testWidgets('renders a single QuickToggle child correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Single Toggle',
            semantics: 'single_toggle',
            value: false,
            onChanged: (value) {},
          ),
        ],
      ));

      expect(find.text('Single Toggle'), findsOneWidget);
      expect(find.byType(QuickToggle), findsOneWidget);
    });

    testWidgets('renders no children when an empty list is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [],
      ));

      expect(find.byType(QuickToggle), findsNothing);
    });

    testWidgets('renders with custom spacing between children',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Toggle A',
            semantics: 'toggle_a',
            value: false,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle B',
            semantics: 'toggle_b',
            value: true,
            onChanged: (value) {},
          ),
        ],
        spacing: 20.0,
      ));

      // Verify that a SizedBox of height 20.0 is present between the two toggles
      final sizedBoxFinder = find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.height == 20.0);
      expect(sizedBoxFinder, findsOneWidget);
    });

    testWidgets('renders with a custom separator widget between children',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Toggle X',
            semantics: 'toggle_x',
            value: false,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle Y',
            semantics: 'toggle_y',
            value: true,
            onChanged: (value) {},
          ),
        ],
        separator: const Divider(color: Colors.red, thickness: 2.0),
      ));

      // Verify that the custom Divider is present between the two toggles
      final dividerFinder = find.byWidgetPredicate(
          (widget) => widget is Divider && widget.color == Colors.red);
      expect(dividerFinder, findsOneWidget);
    });

    // Golden Tests
    testWidgetGoldens('Golden test - QuickPanelList with multiple children',
        variants: ValueVariant<Size>(<Size>{const Size(400, 200)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 200));
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Toggle 1',
            subTitle: 'Subtitle for Toggle 1',
            semantics: 'toggle_1_golden',
            value: false,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle 2',
            semantics: 'toggle_2_golden',
            value: true,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle 3',
            tips: 'A helpful tip for Toggle 3',
            semantics: 'toggle_3_golden',
            value: false,
            onChanged: (value) {},
          ),
        ],
      ));
      await tester.takeGolden('quick_panel_list_multiple_children');
    });

    testWidgetGoldens('Golden test - QuickPanelList with single child',
        variants: ValueVariant<Size>(<Size>{const Size(400, 100)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 100));
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Single Toggle',
            semantics: 'single_toggle_golden',
            value: true,
            onChanged: (value) {},
          ),
        ],
      ));
      await tester.takeGolden('quick_panel_list_single_child');
    });

    testWidgetGoldens('Golden test - QuickPanelList with no children',
        variants: ValueVariant<Size>(<Size>{const Size(400, 50)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 50));
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [],
      ));
      await tester.takeGolden('quick_panel_list_no_children');
    });
  testWidgetGoldens('Golden test - QuickPanelList with custom spacing',
        variants: ValueVariant<Size>(<Size>{const Size(400, 220)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 220));
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Toggle 1',
            semantics: 'toggle_1_spacing',
            value: false,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle 2',
            semantics: 'toggle_2_spacing',
            value: true,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle 3',
            semantics: 'toggle_3_spacing',
            value: false,
            onChanged: (value) {},
          ),
        ],
        spacing: 20.0,
      ));
      await tester.takeGolden('quick_panel_list_custom_spacing');
    });

    testWidgetGoldens('Golden test - QuickPanelList with custom separator',
        variants: ValueVariant<Size>(<Size>{const Size(400, 220)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 220));
      await tester.pumpWidget(buildQuickPanelListWidget(
        children: [
          QuickToggle(
            title: 'Toggle A',
            semantics: 'toggle_a_separator',
            value: false,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle B',
            semantics: 'toggle_b_separator',
            value: true,
            onChanged: (value) {},
          ),
          QuickToggle(
            title: 'Toggle C',
            semantics: 'toggle_c_separator',
            value: false,
            onChanged: (value) {},
          ),
        ],
        separator: const Divider(color: Colors.blue, thickness: 4.0),
      ));
      await tester.takeGolden('quick_panel_list_custom_separator');
    });
  });
}
