import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/page/layout/nested_scroll_layout.dart';

class AppProfileHeaderLayout extends StatefulWidget {
  final String? collaspeTitle;
  final double collaspeHeight;
  final PreferredSizeWidget? appBarBottom;
  final ScrollController? controller;
  final Widget? header;
  final double expandedHeight;
  final Widget body;
  final List<Widget> actions;
  final Color? background;
  final void Function()? onCollaspeBackTap;

  const AppProfileHeaderLayout({
    this.collaspeTitle,
    this.collaspeHeight = kToolbarHeight,
    this.appBarBottom,
    this.header,
    this.expandedHeight = 368.0,
    this.controller,
    required this.body,
    this.onCollaspeBackTap,
    this.background,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  @override
  State<AppProfileHeaderLayout> createState() => _AppProfileHeaderLayoutState();
}

class _AppProfileHeaderLayoutState extends State<AppProfileHeaderLayout> {
  late final ScrollController _controller;
  bool _isScrollToBottom = false;

  @override
  initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(_checkScrollPosition);
  }

  @override
  dispose() {
    super.dispose();
    _controller.removeListener(_checkScrollPosition);
  }

  _checkScrollPosition() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 2 * widget.collaspeHeight) {
      setState(() {
        _isScrollToBottom = true;
      });
    } else {
      setState(() {
        _isScrollToBottom = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppNestedScrollLayout(
      expandedHeight: widget.expandedHeight,
      controller: _controller,
      collaspeBackgroundColor: widget.background,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: _isScrollToBottom ? 1 : 0,
          child: LinksysAppBar.withBack(
              backgroundColor: Theme.of(context).colorScheme.background,
              toolbarHeight: widget.collaspeHeight,
              onBackTap: _isScrollToBottom ? widget.onCollaspeBackTap : null,
              context: context,
              trailing: _isScrollToBottom ? widget.actions : null,
              title: AppText.headlineSmall(
                widget.collaspeTitle ?? '',
                overflow: TextOverflow.ellipsis,
              )),
        ),
        background: widget.header,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: widget.body,
      ),
    );
  }
}
