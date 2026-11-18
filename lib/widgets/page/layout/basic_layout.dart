import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/page/layout/fill_column.dart';

class AppBasicLayout extends StatelessWidget {
  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final CrossAxisAlignment? crossAxisAlignment;

  const AppBasicLayout({
    Key? key,
    this.header,
    this.content,
    this.footer,
    this.crossAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PROTOTYPE #1864 option B: one layout for both a bounded height (where
    // FillColumn is a Column with an Expanded content) and the unbounded one
    // of a scrolling page (where the content gets at least what is left). The
    // same tree either way, so a parent that lays the page out twice does not
    // rebuild the content's state.
    return FillColumn(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      fillIndex: header != null ? 1 : 0,
      children: [
        if (header != null) header!,
        content ?? const SizedBox.shrink(),
        if (footer != null) footer!,
        // A Gap needs a Flex parent, which FillColumn is not.
        const SizedBox(height: Spacing.small3),
      ],
    );
  }
}
