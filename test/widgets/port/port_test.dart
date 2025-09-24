import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/icons/linksys_icons.dart';
import 'package:privacygui_widgets/widgets/port/port.dart';

import '../../tester/test_widget.dart';

void main() {
  const String lanPortLabel = 'LAN Port 1';
  const String connectedSpeedLabel = '1 Gbps';
  const String internetLabel = 'Internet';
  const String connectionDevice = 'Device Name';

  Widget buildWidget({
    String? lanPortLabel,
    String? connection,
    String connectedSpeedLabel = connectedSpeedLabel,
    String internetLabel = internetLabel,
    bool isWan = false,
    bool hasLanPorts = false,
    bool isMobileLayout = false,
  }) {
    return buildTestWidget(
      child: AppPortWidget(
        lanPortLabel: lanPortLabel,
        connection: connection,
        connectedSpeedLabel: connectedSpeedLabel,
        internetLabel: internetLabel,
        isWan: isWan,
        hasLanPorts: hasLanPorts,
        isMobileLayout: isMobileLayout,
      ),
    );
  }

  group('AppPortWidget', () {
    testWidgets('should render correctly for a connected WAN port',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        isWan: true,
        connection: connectionDevice,
      ));

      // Assert
      expect(find.text(internetLabel), findsOneWidget);
      expect(find.text(connectionDevice), findsOneWidget);
      expect(find.text(connectedSpeedLabel), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsNothing);
      expect(find.bySemanticsLabel('port status image'), findsOneWidget);
    });

    testWidgets('should render correctly for a disconnected WAN port',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        isWan: true,
        connection: null,
      ));

      // Assert
      expect(find.text(internetLabel), findsOneWidget);
      expect(find.text(connectionDevice), findsNothing);
      expect(find.text(connectedSpeedLabel), findsNothing);
      expect(find.byIcon(Icons.circle), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
      expect(find.bySemanticsLabel('port status image'), findsOneWidget);
    });

    testWidgets(
        'should use Column layout when hasLanPorts is true and connected',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
        connection: connectionDevice,
      ));

      // Assert
      expect(find.text(lanPortLabel), findsOneWidget);
      expect(find.text(connectionDevice), findsOneWidget);
      expect(find.text(connectedSpeedLabel), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets(
        'should use Column layout when hasLanPorts is true and disconnected',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
        connection: null,
      ));

      // Assert
      final columnFinder = find.descendant(
        of: find.byType(AppPortWidget),
        matching: find.byWidgetPredicate((widget) =>
            widget is Column && widget.mainAxisSize == MainAxisSize.min),
      );
      expect(columnFinder, findsOneWidget);
      expect(find.text(lanPortLabel), findsOneWidget);
      expect(find.text(connectionDevice), findsNothing);
      expect(find.text(connectedSpeedLabel), findsNothing);
      expect(find.byIcon(Icons.circle), findsOneWidget);
    });

    testWidgets('should use Row layout when hasLanPorts is false',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        hasLanPorts: false,
        connection: connectionDevice,
      ));

      // Assert
      final rowFinder = find.descendant(
        of: find.byType(AppPortWidget),
        matching: find.byWidgetPredicate((widget) =>
            widget is Row &&
            widget.mainAxisAlignment == MainAxisAlignment.spaceEvenly),
      );
      expect(rowFinder, findsOneWidget);
    });

    testWidgets('should use Column in _portLabel when isMobileLayout is true',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        isMobileLayout: true,
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
      ));

      // Assert
      final wrapFinder = find.byWidgetPredicate((widget) =>
          widget is Wrap && widget.alignment == WrapAlignment.center);
      expect(wrapFinder, findsOneWidget);

      final columnInWrapFinder = find.descendant(
        of: wrapFinder,
        matching: find.byType(Column),
      );
      expect(columnInWrapFinder, findsOneWidget);

      final rowInWrapFinder = find.descendant(
        of: wrapFinder,
        matching: find.byType(Row),
      );
      expect(rowInWrapFinder, findsNothing);
    });

    testWidgets('should use Row in _portLabel when isMobileLayout is false',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildWidget(
        isMobileLayout: false,
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
      ));

      // Assert
      final wrapFinder = find.byWidgetPredicate((widget) =>
          widget is Wrap && widget.alignment == WrapAlignment.center);
      expect(wrapFinder, findsOneWidget);

      final rowInWrapFinder = find.descendant(
        of: wrapFinder,
        matching: find.byType(Row),
      );
      expect(rowInWrapFinder, findsOneWidget);

      final columnInWrapFinder = find.descendant(
        of: wrapFinder,
        matching: find.byType(Column),
      );
      expect(columnInWrapFinder, findsNothing);
    });

    testWidgetGoldens('Golden test for AppPortWidget states',
        variants: ValueVariant<Size>(<Size>{const Size(300, 200)}),
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(300, 200));

      // WAN Connected
      await tester.pumpWidget(buildWidget(
        isWan: true,
        connection: connectionDevice,
      ));
      await tester.takeGolden('port_widget_wan_connected');

      // WAN Disconnected
      await tester.pumpWidget(buildWidget(
        isWan: true,
        connection: null,
      ));
      await tester.takeGolden('port_widget_wan_disconnected');

      // LAN Connected
      await tester.pumpWidget(buildWidget(
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
        connection: connectionDevice,
      ));
      await tester.takeGolden('port_widget_lan_connected');

      // LAN Disconnected
      await tester.pumpWidget(buildWidget(
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
        connection: null,
      ));
      await tester.takeGolden('port_widget_lan_disconnected');

      // Mobile Layout
      await tester.pumpWidget(buildWidget(
        hasLanPorts: true,
        lanPortLabel: lanPortLabel,
        connection: connectionDevice,
        isMobileLayout: true,
      ));
      await tester.takeGolden('port_widget_mobile_layout');
    });
  });
}
