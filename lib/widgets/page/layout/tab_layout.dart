import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/page/layout/nested_scroll_layout.dart';

class AppTabLayout extends StatelessWidget {
  final List<Widget> tabs;
  final Widget? appBarTitle;
  final Widget? flexibleSpace;
  final List<Widget> tabContentViews;
  final bool pinned;
  final bool snap;
  final bool floating;
  final double? expandedHeight;
  final ScrollController? scrollController;
  final Color? color;

  AppTabLayout({
    super.key,
    required this.tabs,
    this.appBarTitle,
    this.flexibleSpace,
    this.tabContentViews = const [],
    this.pinned = true,
    this.snap = false,
    this.floating = false,
    this.expandedHeight,
    this.scrollController,
    this.color,
  })  : assert(tabs.isNotEmpty),
        assert(tabs.length == tabContentViews.length);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: AppNestedScrollLayout(
        expandedHeight: expandedHeight ?? 170,
        flexibleSpace: Container(
          color: color ?? Theme.of(context).colorScheme.background,
          child: flexibleSpace,
        ),
        appBarBottom: AppTabBar(
          tabs: tabs,
        ),
        snap: snap,
        pinned: pinned,
        floating: floating,
        appBarTitle: appBarTitle,
        body: TabBarView(children: tabContentViews),
      ),
    );
  }
}
