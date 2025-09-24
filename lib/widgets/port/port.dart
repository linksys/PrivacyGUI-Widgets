import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/theme/_theme.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';

class AppPortWidget extends StatelessWidget {
  final String? lanPortLabel;
  final String? connection;
  final String connectedSpeedLabel;
  final String internetLabel;
  final bool isWan;
  final bool hasLanPorts;
  final bool isMobileLayout;

  const AppPortWidget({
    super.key,
    this.lanPortLabel,
    this.connection,
    required this.connectedSpeedLabel,
    required this.internetLabel,
    this.isWan = false,
    this.hasLanPorts = false,
    this.isMobileLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return hasLanPorts
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _portLabel(
                context,
                connection: connection,
                hasLanPorts: hasLanPorts,
                isMobileLayout: isMobileLayout,
              ),
              _portIcon(context, connection: connection),
              if (connection != null)
                _portConnection(
                  context,
                  connection: connection ?? '',
                  connectedSpeedLabel: connectedSpeedLabel,
                ),
              if (isWan) AppText.labelMedium(internetLabel),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  _portLabel(
                    context,
                    connection: connection,
                    hasLanPorts: hasLanPorts,
                    isMobileLayout: isMobileLayout,
                  ),
                  _portIcon(context, connection: connection),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (connection != null)
                    _portConnection(
                      context,
                      connection: connection ?? '',
                      connectedSpeedLabel: connectedSpeedLabel,
                    ),
                  if (isWan) AppText.labelMedium(internetLabel),
                ],
              ),
            ],
          );
  }

  Widget _portLabel(BuildContext context,
      {String? connection,
      bool hasLanPorts = false,
      bool isMobileLayout = false}) {
    final portLabel = [
      Icon(
        connection == null
            ? Icons.circle
            : Icons.check_circle,
        color: connection == null
            ? Theme.of(context).colorScheme.surfaceVariant
            : Theme.of(context).colorSchemeExt.green,
        semanticLabel: 'port icon',
      ),
      if (hasLanPorts) ...[
        const AppGap.small2(),
        AppText.labelMedium(lanPortLabel ?? ''),
      ],
    ];

    return Wrap(
      // mainAxisSize: MainAxisSize.min,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        isMobileLayout
            ? Column(
                children: portLabel,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: portLabel,
              ),
      ],
    );
  }

  Widget _portIcon(BuildContext context, {String? connection}) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.small2),
      child: SvgPicture(
        connection == null
            ? CustomTheme.of(context).images.imgPortOff
            : CustomTheme.of(context).images.imgPortOn,
        semanticsLabel: 'port status image',
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _portConnection(
    BuildContext context, {
    required String connection,
    required String connectedSpeedLabel,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              // LinksysIcons.bidirectional,
              Icons.swap_vert,
              color: Theme.of(context).colorScheme.primary,
            ),
            AppText.bodySmall(connection),
          ],
        ),
        AppText.bodySmall(
          connectedSpeedLabel,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
