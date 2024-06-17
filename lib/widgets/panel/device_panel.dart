part of 'panel_bases.dart';

enum AppDevicePanelStyle {
  normal,
  speed,
  bandwidth,
  offline,
}

class AppDevicePanel extends StatelessWidget {
  final AppDevicePanelStyle style;
  final bool headerChecked;
  final Function(bool?)? onHeaderChecked;
  final String title;
  final String? place;
  final String? band;
  final ImageProvider? deviceImage;
  final IconData? rssiIcon;
  final double? upload;
  final double? download;
  final double? bandwidth;
  final double? height;
  final VoidCallback? onTap;

  const AppDevicePanel({
    Key? key,
    required this.style,
    required this.title,
    this.headerChecked = false,
    this.onHeaderChecked,
    this.place,
    this.band,
    this.deviceImage,
    this.rssiIcon,
    this.upload,
    this.download,
    this.bandwidth,
    this.height,
    this.onTap,
  }) : super(key: key);

  factory AppDevicePanel.normal({
    required String title,
    required String place,
    required String band,
    required ImageProvider deviceImage,
    required IconData? rssiIcon,
    VoidCallback? onTap,
    bool headerChecked = false,
    Function(bool?)? onHeaderChecked,
  }) {
    return AppDevicePanel(
      style: AppDevicePanelStyle.normal,
      title: title,
      place: place,
      band: band,
      deviceImage: deviceImage,
      rssiIcon: rssiIcon,
      onTap: onTap,
      headerChecked: headerChecked,
      onHeaderChecked: onHeaderChecked,
    );
  }

  factory AppDevicePanel.speed({
    required String title,
    required String place,
    required String frequency,
    required ImageProvider deviceImage,
    required IconData? rssiIcon,
    required double upload,
    required double download,
  }) {
    return AppDevicePanel(
      style: AppDevicePanelStyle.speed,
      title: title,
      place: place,
      band: frequency,
      deviceImage: deviceImage,
      rssiIcon: rssiIcon,
      upload: upload,
      download: download,
    );
  }

  factory AppDevicePanel.bandwidth({
    required String title,
    required ImageProvider deviceImage,
    required double bandwidth,
  }) {
    return AppDevicePanel(
      style: AppDevicePanelStyle.bandwidth,
      title: title,
      deviceImage: deviceImage,
      bandwidth: bandwidth,
    );
  }

  factory AppDevicePanel.offline({
    required String title,
    required ImageProvider deviceImage,
    VoidCallback? onTap,
    bool headerChecked = false,
    Function(bool?)? onHeaderChecked,
  }) {
    return AppDevicePanel(
      style: AppDevicePanelStyle.offline,
      title: title,
      deviceImage: deviceImage,
      onTap: onTap,
      headerChecked: headerChecked,
      onHeaderChecked: onHeaderChecked,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget titleWidget;
    Widget? descriptionWidget;
    Widget? deviceImageWidget;
    Widget? signalImageWidget;
    Widget? tailWidget;
    double height;
    Widget? headerChecker;

    Widget? getDescriptionWidget() {
      final place = this.place;
      final band = this.band;

      List<Widget> children = [];
      if (place != null) {
        children.add(AppText.bodyMedium(
          place,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ));
      }
      if (style != AppDevicePanelStyle.normal && band != null) {
        children.add(AppText.bodyMedium(
          band,
        ));
      }

      return children.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          : null;
    }

    switch (style) {
      case AppDevicePanelStyle.normal:
        titleWidget = AppText.bodyMedium(
          title,
          overflow: TextOverflow.ellipsis,
        );
        descriptionWidget = getDescriptionWidget();
        deviceImageWidget = Image(
          image: deviceImage!,
          width: 50,
          height: 50,
        );

        height = 105.0;
        tailWidget = Row(
          children: [
            AppText.bodyMedium(
              '$band',
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            const AppGap.small3(),
            Icon(
              rssiIcon,
              size: 24,
            ),
          ],
        );
        headerChecker = AppCheckbox(
          value: headerChecked,
          onChanged: onHeaderChecked,
        );
        break;
      case AppDevicePanelStyle.speed:
        titleWidget = AppText.bodyMedium(
          title,
        );
        descriptionWidget = getDescriptionWidget();
        deviceImageWidget = Image(
          image: deviceImage!,
          width: 50,
          height: 50,
        );
        signalImageWidget = Icon(
          rssiIcon,
          size: 24,
        );
        tailWidget = Row(
          children: [
            const AppGap.small3(),
            AppText.bodyLarge(
              '$download',
            ),
            const AppGap.small3(),
            AppText.bodyLarge(
              '$upload',
            ),
          ],
        );
        height = 105.0;
        break;
      case AppDevicePanelStyle.bandwidth:
        titleWidget = AppText.bodyMedium(
          title,
        );
        deviceImageWidget = Image(
          image: deviceImage!,
          width: 50,
          height: 50,
        );
        tailWidget = Row(
          children: [
            AppText.bodyLarge(
              '$bandwidth',
            ),
            const AppGap.small3(),
            AppText.bodyLarge(
              'MB',
            ),
          ],
        );
        height = 82.0;
        break;
      case AppDevicePanelStyle.offline:
        titleWidget = AppText.bodyMedium(
          title,
        );
        deviceImageWidget = Image(
          image: deviceImage!,
          width: 50,
          height: 50,
        );
        height = 82.0;
        headerChecker = AppCheckbox(
          value: headerChecked,
          onChanged: onHeaderChecked,
        );
        break;
    }

    return TapBuilder(
      onTap: onTap,
      builder: (context, state, hasFocus) {
        switch (state) {
          case TapState.inactive:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.inactive(
                head: titleWidget,
                edit: onHeaderChecked == null ? null : headerChecker,
                tail: tailWidget,
                description: descriptionWidget,
                iconOne: deviceImageWidget,
                iconTwo: signalImageWidget,
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
          case TapState.hover:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.hovered(
                head: titleWidget,
                tail: tailWidget,
                edit: onHeaderChecked == null ? null : headerChecker,
                description: descriptionWidget,
                iconOne: deviceImageWidget,
                iconTwo: signalImageWidget,
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
          case TapState.pressed:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.pressed(
                head: titleWidget,
                tail: tailWidget,
                edit: onHeaderChecked == null ? null : headerChecker,
                description: descriptionWidget,
                iconOne: deviceImageWidget,
                iconTwo: signalImageWidget,
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
          case TapState.disabled:
            return Semantics(
              enabled: true,
              selected: true,
              child: AppPanelLayout.disabled(
                head: titleWidget,
                tail: tailWidget,
                edit: onHeaderChecked == null ? null : headerChecker,
                description: descriptionWidget,
                iconOne: deviceImageWidget,
                iconTwo: signalImageWidget,
                constraints: BoxConstraints(minHeight: height),
                isHidingAccessory: true,
              ),
            );
        }
      },
    );
  }
}
