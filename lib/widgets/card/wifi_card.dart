import 'dart:async';

import 'package:flutter/material.dart';
import 'package:privacygui_widgets/widgets/buttons/button.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/gap/const/spacing.dart';
import 'package:privacygui_widgets/widgets/gap/gap.dart';
import 'package:privacygui_widgets/widgets/switch/switch.dart';
import 'package:privacygui_widgets/widgets/text/app_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';

class WifiCredential {
  const WifiCredential({
    required this.band,
    required this.isGuest,
    required this.isEnabled,
    required this.deviceCount,
    required this.ssid,
    required this.password,
    required this.radios,
    required this.canBeDisabled,
    required this.qrData,
  });

  final String band;
  final bool isGuest;
  final bool isEnabled;
  final String deviceCount;
  final String ssid;
  final String password;
  final List<String> radios;
  final bool canBeDisabled;
  final String qrData;
}

class WifiCard extends StatefulWidget {
  const WifiCard({
    super.key,
    required this.credential,
    required this.onCardTapped,
    required this.onToggled,
    required this.onQrCodeTapped,
  });

  final WifiCredential credential;
  final Function() onCardTapped;
  final Function(bool) onToggled;
  final Function() onQrCodeTapped;

  @override
  State<WifiCard> createState() => _WifiCardState();
}

class _WifiCardState extends State<WifiCard> {
  final GlobalKey _qrBtnKey = GlobalKey();
  Completer<void>? _completer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return AppCard(
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.small3,
          horizontal: Spacing.small3,
        ),
        onTap: widget.onCardTapped,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.bodyMedium(widget.credential.band),
                AppSwitch(
                  value: widget.credential.isEnabled,
                  onChanged: widget.credential.isGuest ||
                          !widget.credential.isEnabled ||
                          widget.credential.canBeDisabled
                      ? (value) => widget.onToggled(value)
                      : null,
                ),
              ],
            ),
            const AppGap.small2(),
            FittedBox(
              child: AppText.titleMedium(
                widget.credential.ssid,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const AppGap.small2(),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.computer,
                        semanticLabel: 'devices',
                      ),
                      const AppGap.small2(),
                      AppText.labelLarge(
                        widget.credential.deviceCount,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _buildTooltip(context),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _buildTooltip(BuildContext context) {
    final toolTipController = SuperTooltipController();
    return SuperTooltip(
      arrowTipDistance: 0,
      popupDirection: TooltipDirection.left,
      overlayDimensions: EdgeInsets.zero,
      bubbleDimensions: EdgeInsets.zero,
      showBarrier: false,
      controller: toolTipController,
      showOnTap: false,
      content: Container(
        color: Colors.white,
        height: 200,
        width: 200,
        child: QrImageView(data: widget.credential.qrData),
      ),
      child: MouseRegion(
        onHover: (e) async {
          if (!widget.credential.isEnabled) {
            return;
          }

          await _waitForPendingTooltip();
          final widgetPosition = _getWidgetPosition();
          final rect = Rect.fromCenter(
            center: widgetPosition + const Offset(20, 20),
            width: 40,
            height: 40,
          );

          if (toolTipController.isVisible == false &&
              rect.contains(e.position)) {
            final completer = Completer<void>();
            _completer = completer;
            try {
              await toolTipController.showTooltip();
            } finally {
              if (!completer.isCompleted) {
                completer.complete();
              }
              if (identical(_completer, completer)) {
                _completer = null;
              }
            }
          }
        },
        onExit: (e) async {
          await _waitForPendingTooltip();
          if (toolTipController.isVisible == true) {
            final completer = Completer<void>();
            _completer = completer;
            try {
              await toolTipController.hideTooltip();
            } finally {
              if (!completer.isCompleted) {
                completer.complete();
              }
              if (identical(_completer, completer)) {
                _completer = null;
              }
            }
          }
        },
        child: SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: AppIconButton(
                  key: _qrBtnKey,
                  icon: Icons.qr_code,
                  onTap: widget.onQrCodeTapped,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Offset _getWidgetPosition() {
    final renderObject = _qrBtnKey.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      return renderObject.localToGlobal(Offset.zero);
    }
    return Offset.zero;
  }

  Future<void> _waitForPendingTooltip() async {
    final pending = _completer;
    if (pending != null) {
      await pending.future;
    }
  }
}
