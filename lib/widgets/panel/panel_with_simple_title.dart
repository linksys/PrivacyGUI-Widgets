part of 'panel_bases.dart';

class AppSimplePanel extends StatelessWidget {
  final String title;
  final AppWidgetStateColorSet? titleColorSet;
  final AppWidgetStateColorSet? backgroundColorSet;
  final String? description;
  final VoidCallback? onTap;
  final bool forcedHidingAccessory;
  final IconData? icon;
  final bool explicitChildNodes;
  final bool excludeSemantics;
  final String? identifier;
  final String? semanticLabel;

  const AppSimplePanel({
    Key? key,
    required this.title,
    this.icon,
    this.titleColorSet,
    this.backgroundColorSet,
    this.description,
    this.onTap,
    this.forcedHidingAccessory = false,
    this.explicitChildNodes = false,
    this.excludeSemantics = false,
    this.identifier,
    this.semanticLabel,
  }) : super(key: key);

  Widget _getTitleWidgetByState(TapState state) {
    final titleColor = titleColorSet?.resolveByTapState(state);
    return AppText.bodyLarge(
      title,
      color: titleColor,
      identifier: identifier != null ? '$identifier-panel-title' : null,
    );
  }

  Widget? _getDescriptionWidget(BuildContext context) {
    final description = this.description;
    return description != null
        ? AppText.bodyMedium(
            description,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            identifier:
                identifier != null ? '$identifier-panel-description' : null,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final height = (description == null) ? 56.0 : 74.0;
    return TapBuilder(
      onTap: onTap,
      builder: (context, state, hasFocus) {
        switch (state) {
          case TapState.inactive:
            return Semantics(
              enabled: true,
              selected: true,
              identifier: identifier != null ? '$identifier-panel' : null,
              label: semanticLabel != null ? '$semanticLabel panel' : null,
              child: AppPanelLayout.inactive(
                head: _getTitleWidgetByState(state),
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                backgroundColorSet: backgroundColorSet,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
                iconOne: icon != null ? Icon(icon) : null,
              ),
            );
          case TapState.hover:
            return Semantics(
              enabled: true,
              selected: true,
              identifier: identifier != null ? '$identifier-panel' : null,
              label: semanticLabel != null ? '$semanticLabel panel' : null,
              child: AppPanelLayout.hovered(
                head: _getTitleWidgetByState(state),
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                backgroundColorSet: backgroundColorSet,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
                iconOne: icon != null ? Icon(icon) : null,
              ),
            );
          case TapState.pressed:
            return Semantics(
              enabled: true,
              selected: true,
              identifier: identifier != null ? '$identifier-panel' : null,
              label: semanticLabel != null ? '$semanticLabel panel' : null,
              child: AppPanelLayout.pressed(
                head: _getTitleWidgetByState(state),
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                backgroundColorSet: backgroundColorSet,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
                iconOne: icon != null ? Icon(icon) : null,
              ),
            );
          case TapState.disabled:
            return Semantics(
              enabled: true,
              selected: true,
              identifier: identifier != null ? '$identifier-panel' : null,
              label: semanticLabel != null ? '$semanticLabel panel' : null,
              child: AppPanelLayout.disabled(
                head: _getTitleWidgetByState(state),
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                backgroundColorSet: backgroundColorSet,
                isHidingAccessory: (forcedHidingAccessory || onTap == null),
                iconOne: icon != null ? Icon(icon) : null,
              ),
            );
        }
      },
    );
  }
}
