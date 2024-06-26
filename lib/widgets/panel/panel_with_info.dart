part of 'panel_bases.dart';

class AppPanelWithInfo extends StatelessWidget {
  final String title;
  final String infoText;
  final Color? infoTextColor;
  final String? description;
  final VoidCallback? onTap;
  final bool forcedHidingAccessory;

  const AppPanelWithInfo({
    Key? key,
    required this.title,
    required this.infoText,
    this.infoTextColor,
    this.description,
    this.onTap,
    this.forcedHidingAccessory = false,
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

  Widget get _infoWidget => AppText.bodyLarge(
        infoText,
        color: infoTextColor,
      );

  @override
  Widget build(BuildContext context) {
    // final height = (description == null) ? 58.0 : 76.0;
    return TapBuilder(
      onTap: onTap,
      builder: (context, state, hasFocus) {
        switch (state) {
          case TapState.inactive:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.inactive(
                head: _titleWidget,
                tail: _infoWidget,
                description: _getDescriptionWidget(context),
                // panelHeight: height,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
              ),
            );
          case TapState.hover:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.hovered(
                head: _titleWidget,
                tail: _infoWidget,
                description: _getDescriptionWidget(context),
                // panelHeight: height,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
              ),
            );
          case TapState.pressed:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.pressed(
                head: _titleWidget,
                tail: _infoWidget,
                description: _getDescriptionWidget(context),
                // panelHeight: height,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
              ),
            );
          case TapState.disabled:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.disabled(
                head: _titleWidget,
                tail: _infoWidget,
                description: _getDescriptionWidget(context),
                // panelHeight: height,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
              ),
            );
        }
      },
    );
  }
}
