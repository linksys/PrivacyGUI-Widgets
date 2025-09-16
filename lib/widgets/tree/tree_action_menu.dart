import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

// Tree action data model.
class TreeAction {
  final String type;
  final String label;
  final bool isSub;
  final List<TreeAction> subActions;
  final IconData? icon;
  final Color? color;
  
  TreeAction({
    required this.type,
    required this.label,
    this.isSub = false,
    this.subActions = const [],
    this.icon,
    this.color,
  });
}

//
class TreeActionsMenu extends StatelessWidget {
  const TreeActionsMenu({
    super.key,
    required this.actions,
    required this.onActionTap,
    required this.itemBuilder,
    this.subMenuBuilder,
    required this.title,
  });

  final String title;
  final List<TreeAction> actions;
  final void Function(TreeAction)? onActionTap;
  final Widget Function(BuildContext, TreeAction)? subMenuBuilder;
  final Widget Function(BuildContext, TreeAction) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(
          vertical: Spacing.large1, horizontal: Spacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText.labelLarge(title),
          PopupMenuButton<TreeAction>(
            color: Theme.of(context).colorScheme.surface,
            iconSize: 20,
            elevation: 10,
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            itemBuilder: (context) {
              return actions
                  .mapIndexed((index, e) => PopupMenuItem<TreeAction>(
                        padding: EdgeInsets.zero,
                        value: e.isSub ? null : e,
                        enabled: !e.isSub,
                        child: PopupMenuItemView(
                          action: e,
                          onActionTap: onActionTap,
                          itemBuilder: itemBuilder,
                          subMenuBuilder: subMenuBuilder,
                        ),
                      ))
                  .toList();
            },
            onSelected: onActionTap,
          )
        ],
      ),
    );
  }
}

class PopupMenuItemView extends StatelessWidget {
  const PopupMenuItemView({
    super.key,
    required this.action,
    required this.onActionTap,
    required this.itemBuilder,
    this.subMenuBuilder,
  });

  final TreeAction action;
  final void Function(TreeAction)? onActionTap;
  final Widget Function(BuildContext, TreeAction) itemBuilder;
  final Widget Function(BuildContext, TreeAction)? subMenuBuilder;

  @override
  Widget build(BuildContext context) {
    return action.isSub
        ? _subMenuBuilder(context, action)
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
            child: itemBuilder(context, action),
          );
  }

  Widget _subMenuBuilder(BuildContext context, TreeAction action) {
    return Theme(
      data: Theme.of(context).copyWith(
        disabledColor: Theme.of(context).colorScheme.onSurface,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      child: PopupMenuButton<TreeAction>(
        key: ValueKey('popup-sub-menu-${action.type}'),
        color: Theme.of(context).colorScheme.surface,
        padding: EdgeInsets.zero,
        elevation: 10,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        itemBuilder: (context) {
          return action.subActions
              .mapIndexed((index, e) => PopupMenuItem<TreeAction>(
                    key: ValueKey('popup-sub-menu-${e.type}'),
                    padding: EdgeInsets.zero,
                    value: e.isSub ? null : e,
                    enabled: !e.isSub,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: e.isSub ? 0 : Spacing.small3,
                      ),
                      child: e.isSub
                          ? _subMenuBuilder(context, e)
                          : itemBuilder(context, e),
                    ),
                  ))
              .toList();
        },
        onSelected: onActionTap,
        child: subMenuBuilder?.call(context, action) ??
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
              constraints: const BoxConstraints(minHeight: 48),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.labelLarge(
                      action.label,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
