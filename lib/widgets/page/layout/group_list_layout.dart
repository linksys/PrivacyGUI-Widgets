import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class GroupItem<T> extends Equatable {
  final Object key;
  final String label;
  final List<T> items;

  const GroupItem({
    required this.key,
    required this.label,
    required this.items,
  });

  @override
  List<Object> get props => [key, label, items];
}

class GroupList<T> extends StatelessWidget {
  final List<GroupItem<T>> groups;
  final Widget Function(GroupItem<T>)? labelBuilder;
  final Widget Function(T item) itemBuilder;

  const GroupList({
    super.key,
    required this.groups,
    this.labelBuilder,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (BuildContext context, int index) {
        String category = groups[index].label;
        List itemsInCategory = groups[index].items;
        final labelWidget =
            labelBuilder?.call(groups[index]) ?? AppText.labelMedium(category);

        // Return a widget representing the category and its items

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelWidget,
            const AppGap.medium(),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: itemsInCategory.length,
              itemBuilder: (BuildContext context, int index) =>
                  itemBuilder(itemsInCategory[index]),
              separatorBuilder: (BuildContext context, int index) {
                if (index != itemsInCategory.length) {
                  return const AppGap.medium();
                } else {
                  return const Center();
                }
              },
            ),
            const AppGap.large3(),
          ],
        );
      },
    );
  }
}
