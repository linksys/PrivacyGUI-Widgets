import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/page/layout/fill_column.dart';

/// A header, a content that takes the rest of the page, and a footer.
///
/// The content fills what the header and the footer leave, so the footer sits
/// at the bottom of a short page. On a page that scrolls, the content is at
/// least that tall and grows with what it holds (see [FillColumn]).

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
    return FillColumn(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      fillIndex: header != null ? 1 : 0,
      children: [
        if (header != null) header!,
        content ?? const SizedBox.shrink(),
        if (footer != null) footer!,
        // A Gap needs a Flex or a scroll view to know its direction, and
        // FillColumn is not a Flex.
        const SizedBox(height: Spacing.small3),
      ],
    );
  }
}
