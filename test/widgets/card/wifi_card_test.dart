import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/card/card.dart';
import 'package:privacygui_widgets/widgets/card/wifi_card.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../tester/test_widget.dart';

void main() {
  WifiCredential createCredential({
    String band = '2.4GHz Band',
    bool isGuest = false,
    bool isEnabled = true,
    String deviceCount = '3 devices',
    String ssid = 'MyWiFi',
    String password = 'password',
    List<String> radios = const ['2.4GHz'],
    bool canBeDisabled = true,
    String qrData = 'wifi:MyWiFi',
  }) {
    return WifiCredential(
      band: band,
      isGuest: isGuest,
      isEnabled: isEnabled,
      deviceCount: deviceCount,
      ssid: ssid,
      password: password,
      radios: radios,
      canBeDisabled: canBeDisabled,
      qrData: qrData,
    );
  }

  Widget buildWifiCard({
    WifiCredential? credential,
    VoidCallback? onCardTapped,
    ValueChanged<bool>? onToggled,
    VoidCallback? onQrCodeTapped,
    SuperTooltipController? toolTipController,
    FutureOr<void> Function()? beforeShowWiFiTip,
  }) {
    return buildTestWidget(
      child: WifiCard(
        credential: credential ?? createCredential(),
        onCardTapped: onCardTapped ?? () {},
        onToggled: onToggled ?? (_) {},
        onQrCodeTapped: onQrCodeTapped ?? () {},
        toolTipController: toolTipController ?? SuperTooltipController(),
        beforeShowWiFiTip: beforeShowWiFiTip,
      ),
    );
  }

  group('WifiCard', () {
    testWidgets('renders wifi info and handles card tap', (tester) async {
      var tapped = false;
      final credential = createCredential(
        band: '5GHz Band',
        ssid: 'Linksys-Guest',
        deviceCount: '2 devices',
      );

      await tester.pumpWidget(
        buildWifiCard(
          credential: credential,
          onCardTapped: () => tapped = true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('5GHz Band'), findsOneWidget);
      expect(find.text('Linksys-Guest'), findsOneWidget);
      expect(find.text('2 devices'), findsOneWidget);

      await tester.tap(find.byType(AppCard));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('disables switch when network cannot be disabled',
        (tester) async {
      await tester.pumpWidget(
        buildWifiCard(
          credential: createCredential(
            isGuest: false,
            isEnabled: true,
            canBeDisabled: false,
          ),
        ),
      );

      final switchWidget = tester.widget<Switch>(find.byType(Switch));

      expect(switchWidget.onChanged, isNull);
    });

    testWidgets('calls onToggled when switch is allowed to change',
        (tester) async {
      bool? toggledValue;

      await tester.pumpWidget(
        buildWifiCard(
          credential: createCredential(
            isGuest: false,
            isEnabled: false,
            canBeDisabled: false,
          ),
          onToggled: (value) => toggledValue = value,
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(toggledValue, isTrue);
    });

    testWidgets('tapping qr icon triggers onQrCodeTapped', (tester) async {
      var qrTapped = false;

      await tester.pumpWidget(
        buildWifiCard(
          onQrCodeTapped: () => qrTapped = true,
        ),
      );

      await tester.tap(find.byIcon(Icons.qr_code));
      await tester.pumpAndSettle();

      expect(qrTapped, isTrue);
    });

    testWidgetGoldens('matches golden states',
        variants: ValueVariant<Size>(<Size>{const Size(360, 180)}),
        (tester) async {
      await tester.pumpWidget(
        buildWifiCard(
          credential: createCredential(
            band: '2.4GHz Band',
            ssid: 'Linksys Home',
            deviceCount: '4 devices',
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.takeGolden('wifi_card_enabled');

      await tester.pumpWidget(
        buildWifiCard(
          credential: createCredential(
            band: '5GHz Band',
            ssid: 'Linksys Home',
            deviceCount: '2 devices',
            isEnabled: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.takeGolden('wifi_card_disabled');
    });
  });
}
