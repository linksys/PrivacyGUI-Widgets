part of 'panel_bases.dart';

class AppPanelWithValueCheck extends StatelessWidget {
  final String title;
  final String? description;
  final String valueText;
  final Color? valueTextColor;
  final bool isChecked;

  const AppPanelWithValueCheck({
    Key? key,
    required this.title,
    this.description,
    required this.valueText,
    this.valueTextColor,
    this.isChecked = false,
  }) : super(key: key);

  Widget get _titleWidget => AppText.bodyLarge(title);

  Widget? _getDescriptionWidget(BuildContext context) {
    final description = this.description;
    return description != null
        ? AppText.bodyMedium(
            description,
          )
        : null;
  }

  Widget getValueWidget(BuildContext context) {
    return Row(
      children: [
        AppText.bodyLarge(
          valueText,
          color: valueTextColor,
        ),
        if (isChecked)
          const Padding(
            padding: EdgeInsets.only(
              left: Spacing.small2,
            ),
            child: Icon(
              LinksysIcons.check,
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = (description == null) ? 56.0 : 74.0;
    return TapBuilder(
      builder: (context, state, hasFocus) {
        switch (state) {
          case TapState.inactive:
            return Semantics(
                enabled: true,
                selected: true,
                child: AppPanelLayout.inactive(
                  head: _titleWidget,
                  description: _getDescriptionWidget(context),
                  tail: getValueWidget(context),
                  constraints: BoxConstraints(minHeight: height),
                  isHidingAccessory: true,
                ));
          case TapState.hover:
            return Semantics(
                enabled: true,
                selected: true,
                child: AppPanelLayout.hovered(
                  head: _titleWidget,
                  description: _getDescriptionWidget(context),
                  tail: getValueWidget(context),
                  constraints: BoxConstraints(minHeight: height),
                  isHidingAccessory: true,
                ));
          case TapState.pressed:
            return Semantics(
                enabled: true,
                selected: true,
                child: AppPanelLayout.pressed(
                  head: _titleWidget,
                  description: _getDescriptionWidget(context),
                  tail: getValueWidget(context),
                  constraints: BoxConstraints(minHeight: height),
                  isHidingAccessory: true,
                ));
          case TapState.disabled:
            return Semantics(
                enabled: true,
                selected: true,
                child: AppPanelLayout.disabled(
                  head: _titleWidget,
                  description: _getDescriptionWidget(context),
                  tail: getValueWidget(context),
                  constraints: BoxConstraints(minHeight: height),
                  isHidingAccessory: true,
                ));
        }
      },
    );
  }
}
