import 'package:flutter/material.dart';

class AppNestedScrollLayout extends StatelessWidget {
  final Widget? appBarTitle;
  final PreferredSizeWidget? appBarBottom;
  final ScrollController? controller;
  final Widget? flexibleSpace;
  final bool pinned;
  final bool snap;
  final bool floating;
  final double expandedHeight;
  final Color? collaspeBackgroundColor;
  final Widget body;

  const AppNestedScrollLayout({
    this.appBarTitle,
    this.appBarBottom,
    this.flexibleSpace,
    this.pinned = true,
    this.snap = false,
    this.floating = false,
    this.expandedHeight = 170.0,
    this.controller,
    this.collaspeBackgroundColor,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: controller,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: pinned,
            snap: snap && floating,
            floating: floating || snap,
            expandedHeight: expandedHeight,
            title: appBarTitle,
            bottom: appBarBottom,
            flexibleSpace: flexibleSpace,
            backgroundColor: collaspeBackgroundColor,
            elevation: 0,
          ),
        ];
      },
      body: body,
    );
  }
}
