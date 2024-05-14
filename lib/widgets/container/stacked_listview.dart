import 'package:flutter/material.dart';
import 'package:stacked_listview/stacked_listview.dart';

class LinksysStackedListView extends StatefulWidget {
  final List<Widget> items;
  final double itemExtent;
  final double widthFactor;
  final double heightFactor;
  final Axis scrollDirection;

  const LinksysStackedListView({
    super.key,
    required this.itemExtent,
    required this.items,
    this.widthFactor = 1,
    this.heightFactor = 1,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  State<LinksysStackedListView> createState() => _LinksysStackedListViewState();
}

class _LinksysStackedListViewState extends State<LinksysStackedListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemExtent,
      child: StackedListView(
        itemExtent: widget.itemExtent,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        widthFactor: widget.widthFactor,
        heightFactor: widget.heightFactor,
        itemCount: widget.items.length,
        builder: (contex, index) => widget.items[index],
      ),
    );
  }
}
