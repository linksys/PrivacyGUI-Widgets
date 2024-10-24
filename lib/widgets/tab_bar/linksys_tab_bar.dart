import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final double labelPadding;

  @override
  final Size preferredSize;

  AppTabBar({
    super.key,
    required this.tabs,
    this.labelPadding = 10.0,
  })  : preferredSize = Size.fromHeight(18 + labelPadding),
        assert(tabs.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.bottomCenter,
      children: [
        TabBar(
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
          tabs: tabs,
        ),
      ],
    );
  }
}
