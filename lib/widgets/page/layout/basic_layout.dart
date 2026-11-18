import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

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
    // where Expanded cannot work. The content then takes its own height, and
    // the footer is pushed to the bottom of the (at least viewport-tall) page
    // by spaceBetween instead of by an Expanded content.
    return LayoutBuilder(builder: (context, constraints) {
      final align = crossAxisAlignment ?? CrossAxisAlignment.start;
      if (!constraints.hasBoundedHeight) {
        return Column(
          crossAxisAlignment: align,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: align,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (header != null) header!,
                if (content != null) content!,
              ],
            ),
            Column(
              crossAxisAlignment: align,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (footer != null) footer!,
                const AppGap.small3(),
              ],
            ),
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
