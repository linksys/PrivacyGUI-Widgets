import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:linksys_widgets/widgets/bullet_list/bullet_style.dart';
import 'package:linksys_widgets/widgets/text/app_text.dart';

class AppBulletList extends StatelessWidget {
  final List<Widget> children;
  final AppBulletStyle style;
  final double bulletPadding;
  final double itemSpacing;

  const AppBulletList({
    super.key,
    required this.children,
    this.style = AppBulletStyle.dot,
    this.bulletPadding = 20.0,
    this.itemSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(bulletPadding),
        1: const FlexColumnWidth(1),
      },
      children: [
        ...children.mapIndexed((index, child) {
          return TableRow(
            children: [
              TableCell(child: _createBullet(context, index: index)),
              TableCell(
                  child: Padding(
                padding: EdgeInsets.only(bottom: itemSpacing),
                child: child,
              )),
            ],
          );
        }),
      ],
    );
  }

  Widget _createBullet(BuildContext context, {int index = 0}) {
    if (style == AppBulletStyle.dot) {
      return const AppText.bodyLarge('•');
    } else {
      return AppText.bodyMedium('${index + 1}.');
    }
  }
}
