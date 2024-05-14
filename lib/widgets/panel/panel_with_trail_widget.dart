part of 'panel_bases.dart';

class AppPanelWithTrailWidget extends StatelessWidget {
  final String title;
  final Widget trailing;
  final String? description;
  final VoidCallback? onTap;

  const AppPanelWithTrailWidget({
    Key? key,
    required this.title,
    required this.trailing,
    this.description,
    this.onTap,
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
              child: AppPanelLayout.inactive(
                head: _titleWidget,
                tail: trailing,
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
          case TapState.hover:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.hovered(
                head: _titleWidget,
                tail: trailing,
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
          case TapState.pressed:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.pressed(
                head: _titleWidget,
                tail: trailing,
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
          case TapState.disabled:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.disabled(
                head: _titleWidget,
                tail: trailing,
                description: _getDescriptionWidget(context),
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
        }
      },
    );
  }
}
