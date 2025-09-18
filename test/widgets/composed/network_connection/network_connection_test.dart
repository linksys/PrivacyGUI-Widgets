import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/composed/network_connection/network_connection.dart';

import '../../../tester/test_widget.dart';

void main() {
  // Transparent 1x1 pixel image for testing
  final kTransparentImage = Uint8List.fromList([
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
  ]);

  Widget buildTestableWidget({
    required ConnectionStatus status,
    ImageProvider? routerImageProvider,
  }) {
    return buildTestWidget(
      child: NetworkConnectionFlow(
        status: status,
        routerImageProvider: routerImageProvider,
      ),
    );
  }

  group('NetworkConnectionFlow', () {
    testWidgets('should render correctly for noPortConnected', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(status: ConnectionStatus.noPortConnected),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should render correctly for noWANConnection', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(status: ConnectionStatus.noWANConnection),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should render correctly for noInternetConnection', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(status: ConnectionStatus.noInternetConnection),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
      final publicIcon = tester.widget<Icon>(find.byIcon(Icons.public));
      final theme = Theme.of(tester.element(find.byType(NetworkConnectionFlow)));
      expect(publicIcon.color, theme.colorScheme.outline);
    });

    testWidgets('should render correctly for internetConnected', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(status: ConnectionStatus.internetConnected),
      );
      final icon = tester.widget<Icon>(find.byIcon(Icons.public));
      final theme = Theme.of(tester.element(find.byType(NetworkConnectionFlow)));
      expect(icon.color, theme.colorScheme.primary);
    });

    testWidgets('should display image when routerImageProvider is provided', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          status: ConnectionStatus.internetConnected,
          routerImageProvider: MemoryImage(kTransparentImage),
        ),
      );
      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.router), findsNothing);
    });

    testWidgetGoldens(
      'Golden tests for all connection states',
      variants: ValueVariant<Size>({const Size(300, 100)}),
      (tester) async {
        // No Port Connected
        await tester.pumpWidget(
          buildTestableWidget(status: ConnectionStatus.noPortConnected),
        );
        await tester.takeGolden('network_connection_no_port_connected');

        // No WAN Connection
        await tester.pumpWidget(
          buildTestableWidget(status: ConnectionStatus.noWANConnection),
        );
        await tester.takeGolden('network_connection_no_wan_connection');

        // No Internet Connection
        await tester.pumpWidget(
          buildTestableWidget(status: ConnectionStatus.noInternetConnection),
        );
        await tester.takeGolden('network_connection_no_internet_connection');

        // Internet Connected
        await tester.pumpWidget(
          buildTestableWidget(status: ConnectionStatus.internetConnected),
        );
        await tester.takeGolden('network_connection_internet_connected');

        // With custom router image
        await tester.pumpWidget(
          buildTestableWidget(
            status: ConnectionStatus.internetConnected,
            routerImageProvider: MemoryImage(kTransparentImage),
          ),
        );
        await tester.takeGolden('network_connection_custom_router_image');
      },
    );
  });
}
