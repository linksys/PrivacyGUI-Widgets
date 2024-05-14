import 'package:flutter/material.dart';
import 'package:linksys_widgets/icons/linksys_icons.dart';
import 'package:linksys_widgets/theme/_theme.dart';
import 'package:linksys_widgets/theme/const/spacing.dart';
import 'package:linksys_widgets/widgets/_widgets.dart';
import 'package:tap_builder/tap_builder.dart';

part 'panel_with_simple_title.dart';
part 'panel_with_info.dart';
part 'panel_with_value_check.dart';
part 'panel_with_switch.dart';
part 'panel_with_timeline.dart';
part 'panel_with_trail_widget.dart';
part 'device_panel.dart';

class AppPanelLayout extends StatelessWidget {
  final AppWidgetState _state;
  final Widget? edit;
  final Widget head;
  final Widget? tail;
  final Widget? description;
  final AppWidgetStateColorSet? backgroundColorSet;
  final AppWidgetStateColorSet? borderColorSet;
  final Widget? iconOne;
  final Widget? iconTwo;
  final EdgeInsets? padding;
  final bool isHidingAccessory;
  final double animationFactor;
  final BoxConstraints? constraints;

  const AppPanelLayout.inactive({
    Key? key,
    required this.head,
    this.edit,
    this.tail,
    this.description,
    this.backgroundColorSet,
    this.borderColorSet,
    this.iconOne,
    this.iconTwo,
    this.padding,
    this.isHidingAccessory = false,
    this.animationFactor = 1,
    this.constraints,
  })  : _state = AppWidgetState.inactive,
        super(key: key);

  const AppPanelLayout.hovered({
    Key? key,
    required this.head,
    this.edit,
    this.tail,
    this.description,
    this.backgroundColorSet,
    this.borderColorSet,
    this.iconOne,
    this.iconTwo,
    this.padding,
    this.isHidingAccessory = false,
    this.animationFactor = 0.99,
    this.constraints,
  })  : _state = AppWidgetState.hovered,
        super(key: key);

  const AppPanelLayout.pressed({
    Key? key,
    required this.head,
    this.edit,
    this.tail,
    this.description,
    this.backgroundColorSet,
    this.borderColorSet,
    this.iconOne,
    this.iconTwo,
    this.padding,
    this.isHidingAccessory = false,
    this.animationFactor = 0.98,
    this.constraints,
  })  : _state = AppWidgetState.pressed,
        super(key: key);

  const AppPanelLayout.disabled({
    Key? key,
    required this.head,
    this.edit,
    this.tail,
    this.description,
    this.backgroundColorSet,
    this.borderColorSet,
    this.iconOne,
    this.iconTwo,
    this.padding,
    this.isHidingAccessory = false,
    this.animationFactor = 1,
    this.constraints,
  })  : _state = AppWidgetState.disabled,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final iconTwo = this.iconTwo;
    final tail = this.tail;
    final description = this.description;
    final backgroundColor = backgroundColorSet?.resolve(_state);
    final borderColor = borderColorSet?.resolve(_state);

    return AnimatedContainer(
      constraints: constraints,
      duration: theme.durations.quick,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor,
              ),
      ),
      child: AnimatedFractionallySizedBox(
        duration: theme.durations.quick,
        widthFactor: animationFactor,
        child: Padding(
          padding:
              padding ?? const EdgeInsets.symmetric(vertical: Spacing.regular),
          child: Row(
            children: [
              if (edit != null)
                Padding(
                  padding: const EdgeInsets.only(right: Spacing.regular),
                  child: edit,
                ),
              if (iconOne != null)
                Padding(
                  padding: const EdgeInsets.only(right: Spacing.regular),
                  child: iconOne,
                ),
              if (iconTwo != null)
                Padding(
                  padding: const EdgeInsets.only(right: Spacing.regular),
                  child: iconTwo,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [head, if (description != null) description],
                ),
              ),
              if (tail != null)
                Padding(
                  padding: const EdgeInsets.only(left: Spacing.regular),
                  child: tail,
                ),
              if (!isHidingAccessory)
                const Padding(
                  padding: EdgeInsets.only(left: Spacing.semiSmall),
                  child: Icon(
                     LinksysIcons.chevronRight,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
