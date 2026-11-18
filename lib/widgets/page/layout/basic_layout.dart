import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
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
    // PROTOTYPE #1864 option B: in a scrolling page the height is unbounded,
    // where Expanded cannot work. FillColumn gives the content what is left of
    // the (at least viewport-tall) page instead, so a short page still centers
    // its content and keeps the footer at the bottom.
    return LayoutBuilder(builder: (context, constraints) {
      final align = crossAxisAlignment ?? CrossAxisAlignment.start;
      if (!constraints.hasBoundedHeight) {
        return FillColumn(
          crossAxisAlignment: align,
          fillIndex: header != null ? 1 : 0,
          children: [
            if (header != null) header!,
            content ?? const SizedBox.shrink(),
            if (footer != null) footer!,
            const AppGap.small3(),
          ],
        );
      }
      List<Widget> widgets = [];
      if (header != null) widgets.add(header!);
      if (content != null) widgets.add(Expanded(child: content!));
      if (footer != null) widgets.add(footer!);
      widgets.add(const AppGap.small3());
      return Column(
        crossAxisAlignment: align,
        children: widgets,
      );
    });
  }
}
