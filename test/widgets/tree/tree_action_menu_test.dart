import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';
import 'package:privacygui_widgets/widgets/tree/tree_action_menu.dart';

import '../../tester/test_widget.dart';

void main() {
  final actions = [
    TreeAction(type: 'edit', label: 'Edit'),
    TreeAction(type: 'delete', label: 'Delete', color: Colors.red),
    TreeAction(
      type: 'more',
      label: 'More',
      isSub: true,
      subActions: [
        TreeAction(type: 'sub1', label: 'Sub Action 1'),
        TreeAction(type: 'sub2', label: 'Sub Action 2'),
      ],
    ),
  ];

  Widget buildWidget({
    required List<TreeAction> actions,
    void Function(TreeAction)? onActionTap,
  }) {
    return buildTestWidget(
        child: TreeActionsMenu(
          title: 'My Node',
          actions: actions,
          onActionTap: onActionTap,
          itemBuilder: (context, action) => AppText.labelLarge(
            action.label,
            color: action.color,
          ),
        ),
      );
  }

  group('TreeActionsMenu', () {
    testWidgets('renders title and popup menu', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(actions: actions));

      expect(find.text('My Node'), findsOneWidget);
      expect(find.byType(PopupMenuButton<TreeAction>), findsOneWidget);
    });

    testWidgets('tapping popup menu opens menu with actions',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(actions: actions));

      await tester.tap(find.byType(PopupMenuButton<TreeAction>));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('tapping a simple action calls onActionTap',
        (WidgetTester tester) async {
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

    testWidgets('tapping a sub-menu opens it', (WidgetTester tester) async {
      await tester.pumpWidget(buildWidget(actions: actions));

      await tester.tap(find.byType(PopupMenuButton<TreeAction>));
      await tester.pumpAndSettle();

      // The 'More' item is a PopupMenuButton itself inside a PopupMenuItem
      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      // Now the sub-menu should be visible
      expect(find.text('Sub Action 1'), findsOneWidget);
      expect(find.text('Sub Action 2'), findsOneWidget);
    });

    testWidgets('tapping a sub-menu action calls onActionTap',
        (WidgetTester tester) async {
      TreeAction? tappedAction;
      await tester.pumpWidget(buildWidget(
        actions: actions,
        onActionTap: (action) {
          tappedAction = action;
        },
      ));

      await tester.tap(find.byType(PopupMenuButton<TreeAction>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sub Action 1'));
      await tester.pumpAndSettle();

      expect(tappedAction, isNotNull);
      expect(tappedAction!.type, 'sub1');
    });

    testWidgetGoldens('Golden test for TreeActionsMenu',
    variants: ValueVariant<Size>(<Size>{const Size(340, 200)}),
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(340, 200));
      await tester.pumpWidget(buildWidget(actions: actions));
      await tester.takeGolden('tree_action_menu');

      // Open menu for another golden
      await tester.tap(find.byType(PopupMenuButton<TreeAction>));
      await tester.pumpAndSettle();
      await tester.takeGolden('tree_action_menu_open');

      // Open sub-menu for a third golden
      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();
      await tester.takeGolden('tree_action_menu_sub_open');
    });
  });
}
