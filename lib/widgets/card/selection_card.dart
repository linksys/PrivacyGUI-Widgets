import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/_widgets.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/label/text_label.dart';

class AppSelectionCard<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final String? label;
  final String description;
  final void Function()? onTap;

  const AppSelectionCard({
    Key? key,
    required this.title,
    required this.description,
    this.label,
    required this.value,
    required this.groupValue,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return AppCard(
      onTap: selected ? null : onTap,
      borderColor: selected ? Theme.of(context).colorScheme.primary : null,
      color: selected
          ? Theme.of(context).colorScheme.primary.withAlpha(0x10)
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.medium,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacing.small2,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: Spacing.small2,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: AbsorbPointer(
                        child: Radio(
                          value: value,
                          groupValue: groupValue,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    AppText.titleSmall(title),
                    if (label != null)
                      AppLabelText(
                        label: label!,
                      ),
                  ]),
              AppText.bodyMedium(description),
            ],
          ),
        ],
      ),
    );
  }
}
