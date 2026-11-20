import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/table/card_list_settings_view.dart';

import '../../util.dart';

void main() {
  group('AppCardListSettingsView', () {
    testWidgets('wraps a title too long to share its row with the actions',
        (tester) async {
      // PrivacyGUI#1802: Spanish and Russian list titles ran 48px past a
      // 360px page.
      await tester.pumpWidget(testableMaterialWidget(
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 200,
            child: AppCardListSettingsView<String>(
              title: 'Reenvío de puertos de rango de una sola regla',
              actions: [
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              ],
              itemCardBuilder: (context, item) => Text(item),
            ),
          ),
        ),
      ));

      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
