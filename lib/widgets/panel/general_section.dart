// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:privacygui_widgets/theme/const/spacing.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';

class AppSectionItemData {
  final IconData? iconData;
  final String title;
  final String? description;

  final VoidCallback? onTap;
  AppSectionItemData({
    this.iconData,
    required this.title,
    this.description,
    this.onTap,
  });
}

class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel({
    Key? key,
    required this.label,
    this.headerAction,
  }) : super(key: key);
  final String label;
  final Widget? headerAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.regular),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: AppText.titleSmall(label)),
            if (headerAction != null) headerAction!,
          ],
        ),
      ),
    );
  }
}

class AppSection extends StatelessWidget {
  const AppSection({
    Key? key,
    this.enabled = true,
    this.header,
    required this.child,
    this.contentBackground,
  }) : super(key: key);

  final bool enabled;
  final Widget? header;
  final Widget child;
  final Color? contentBackground;

  factory AppSection.withLabel({
    required String title,
    required Widget content,
    Widget? headerAction,
    bool enabled = false,
    Color? contentBackground,
  }) =>
      AppSection(
        header: AppSectionLabel(
          label: title,
          headerAction: headerAction,
        ),
        contentBackground: contentBackground,
        child: content,
      );
  factory AppSection.noHeader({
    required Widget content,
    bool enabled = false,
  }) =>
      AppSection(
        child: content,
      );

  factory AppSection.withList({
    Widget? header,
    required List<AppSectionItemData> items,
    bool enabled = true,
    EdgeInsets? contentPadding,
    Color? contentBackground,
  }) =>
      AppSection(
        header: header,
        enabled: enabled,
        contentBackground: contentBackground,
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.only(),
          child: Column(
            children: [
              ...items.map((e) => AppSimplePanel(
                    title: e.title,
                    icon: e.iconData,
                    onTap: e.onTap,
                  ))
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: contentBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._header(),
          Opacity(
            opacity: enabled ? 1 : 0.4,
            child: AbsorbPointer(
              absorbing: !enabled,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _header() {
    if (header != null) {
      return [
        Container(child: header!),
      ];
    } else {
      return [];
    }
  }
}
