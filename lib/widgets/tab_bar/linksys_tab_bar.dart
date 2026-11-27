import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController? tabController;
  final double labelPadding;
  final void Function(int index)? onTap;
  final String? identifier;

  /// The key of each tab's identifier, `{identifier}-tab-{key}`, in the order
  /// of [tabs]. It comes from the tab's data, never from its label, which is
  /// translated, or its position, which changes when a tab is hidden. Without
  /// it, the tabs have no identifier.
  final List<String>? tabKeys;

  @override
  final Size preferredSize;

  AppTabBar({
    super.key,
    required this.tabs,
    this.tabController,
    this.labelPadding = 10.0,
    this.onTap,
    this.identifier,
    this.tabKeys,
  })  : preferredSize = Size.fromHeight(18 + labelPadding),
        assert(tabs.isNotEmpty),
        assert(tabKeys == null || tabKeys.length == tabs.length);

  @override
  Widget build(BuildContext context) {
    return IdentifierSemantics(
      identifier: identifier,
      child: _tabBar(context),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.bottomCenter,
      children: [
        TabBar(
          controller: tabController,
          onTap: onTap,
          indicatorColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          labelColor: Theme.of(context).colorScheme.primary,
          labelPadding: EdgeInsets.only(
            left: Spacing.large2,
            right: Spacing.large2,
          ),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: [for (var i = 0; i < tabs.length; i++) _tab(i)],
        ),
      ],
    );
  }

  /// The tab at [index], with its identifier, which merges into the tab's
  /// node, where its tap is. `TabBar` pads a tab by its preferred size, so the
  /// tab keeps it.
  Widget _tab(int index) {
    final tab = tabs[index];
    final tabKeys = this.tabKeys;
    final tabIdentifier = tabKeys == null
        ? null
        : partIdentifier(identifier, 'tab-${tabKeys[index]}');
    if (tabIdentifier == null) return tab;
    return tab is PreferredSizeWidget
        ? _SizedTab(identifier: tabIdentifier, tab: tab)
        : Semantics(identifier: tabIdentifier, child: tab);
  }
}

/// A tab with a preferred size, such as a `Tab`, and its identifier.
class _SizedTab extends StatelessWidget implements PreferredSizeWidget {
  final String identifier;
  final PreferredSizeWidget tab;

  const _SizedTab({required this.identifier, required this.tab});

  @override
  Size get preferredSize => tab.preferredSize;

  @override
  Widget build(BuildContext context) =>
      Semantics(identifier: identifier, child: tab);
}
