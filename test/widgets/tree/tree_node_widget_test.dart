import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';
import 'package:privacygui_widgets/widgets/tree/tree_action_menu.dart';
import 'package:privacygui_widgets/widgets/tree/tree_node_widget.dart';

import '../../tester/test_widget.dart';

void main() {
  final actions = [
    TreeAction(type: 'edit', label: 'Edit'),
    TreeAction(type: 'delete', label: 'Delete', color: Colors.red),
  ];

  final nodeData = [
    TreeNodeDetailCell(label: 'Status', widget: AppText.bodyMedium('Online')),
    TreeNodeDetailCell(label: 'IP Address', widget: AppText.bodyMedium('192.168.1.1')),
  ];

  Widget buildWidget({
    String label = 'My Node',
    List<TreeAction> actions = const [],
    void Function(TreeAction)? onActionTap,
    VoidCallback? onTap,
    List<TreeNodeDetailCell> nodeDataWidgets = const [],
    Widget? image,
    Widget? icon,
    bool showActions = true,
    TreeNodeMode mode = TreeNodeMode.detailed,
  }) {
    return buildTestWidget(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: TreeNodeWidget.detailed(
              label: label,
              actions: actions,
              onActionTap: onActionTap,
              onTap: onTap,
              nodeDataWidgets: nodeDataWidgets,
              image: image,
              icon: icon,
              showActions: showActions,
              actionMenuLabel: 'Actions',
            ),
          ),
        ),
      );
  }

  group('TreeNodeWidget', () {
    testWidgetGoldens('renders label and basic structure', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(label: 'Test Node'));
      expect(find.text('Test Node'), findsOneWidget);
      expect(find.byType(TreeActionsMenu), findsNothing); // No actions provided
    });

    testWidgetGoldens('renders in detailed mode with data', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(
        nodeDataWidgets: nodeData,
        mode: TreeNodeMode.detailed,
      ));

      expect(find.text('Status:'), findsOneWidget);
      expect(find.text('Online'), findsOneWidget);
      expect(find.text('IP Address:'), findsOneWidget);
      expect(find.text('192.168.1.1'), findsOneWidget);
    });

    testWidgetGoldens('renders in simple mode without data', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(
        nodeDataWidgets: nodeData,
        mode: TreeNodeMode.simple,
      ));

      expect(find.text('Status:'), findsNothing);
      expect(find.text('Online'), findsNothing);
    });

    testWidgetGoldens('renders image and icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(
        image: const FlutterLogo(key: ValueKey('logo')),
        icon: const Icon(Icons.router, key: ValueKey('icon')),
      ));

      expect(find.byKey(const ValueKey('logo')), findsOneWidget);
      expect(find.byKey(const ValueKey('icon')), findsOneWidget);
    });

    testWidgetGoldens('renders actions menu when actions are provided', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(actions: actions));

      expect(find.byType(TreeActionsMenu), findsOneWidget);
      expect(find.text('Actions'), findsOneWidget);
    });

    testWidgetGoldens('does not render actions menu when showActions is false', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(actions: actions, showActions: false));

      expect(find.byType(TreeActionsMenu), findsNothing);
    });

    testWidgetGoldens('onTap callback is called', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(buildWidget(onTap: () {
        tapped = true;
      }));

      await tester.tap(find.byType(TreeNodeWidget));
      expect(tapped, isTrue);
    });

    testWidgetGoldens('onActionTap callback is called', (WidgetTester tester) async {
      TreeAction? tappedAction;
      await tester.pumpWidget(buildWidget(
        actions: actions,
        onActionTap: (action) {
          tappedAction = action;
        },
      ));

      await tester.tap(find.byType(PopupMenuButton<TreeAction>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      expect(tappedAction, isNotNull);
      expect(tappedAction!.type, 'edit');
    });

    // Golden Tests
    testWidgetGoldens('Golden test - detailed mode', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(
        label: 'Main Router',
        actions: actions,
        nodeDataWidgets: nodeData,
        image: const FlutterLogo(size: 48),
        icon: const Icon(Icons.router, size: 24),
        mode: TreeNodeMode.detailed,
      ));
      await tester.takeGolden('tree_node_detailed');
    });

    testWidgetGoldens('Golden test - simple mode', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(
        label: 'Child Node',
        image: const FlutterLogo(size: 48),
        icon: const Icon(Icons.podcasts, size: 24),
        mode: TreeNodeMode.simple,
      ));
      await tester.takeGolden('tree_node_simple');
    });

    testWidgetGoldens('Golden test - no actions', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(
        label: 'Node without Actions',
        nodeDataWidgets: nodeData,
        showActions: false,
      ));
      await tester.takeGolden('tree_node_no_actions');
    });
  });
}
