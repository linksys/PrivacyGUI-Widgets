import 'package:flutter/material.dart';

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
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border(
        //       bottom: BorderSide(
        //       ),
        //     ),
        //   ),
        // ),
        TabBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          labelColor: Theme.of(context).colorScheme.primary,
          labelPadding: EdgeInsets.only(bottom: labelPadding),
          tabs: tabs,
        ),
      ],
    );
  }
}
