import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privacygui_widgets/widgets/semantics/identifier_semantics.dart';

import '../../util.dart';

/// The number of nodes in the semantics tree [tester] has built.
int _nodeCount(WidgetTester tester) {
  var count = 0;
  bool visit(SemanticsNode node) {
    count++;
    node.visitChildren(visit);
    return true;
  }

  visit(tester.binding.pipelineOwner.semanticsOwner!.rootSemanticsNode!);
  return count;
}

void main() {
  group('IdentifierSemantics', () {
    testWidgets('without an identifier, it adds no node', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(testableMaterialWidget(
        child: IconButton(icon: const Icon(Icons.add), onPressed: () {}),
      ));
      final bare = _nodeCount(tester);

      await tester.pumpWidget(testableMaterialWidget(
        child: IdentifierSemantics(
          identifier: null,
          child: IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ),
      ));

      final wrapped = _nodeCount(tester);
      // Before any expect: flutter_test checks for a live handle before
      // tear-down runs.
      semantics.dispose();

      expect(wrapped, bare);
    });

    testWidgets('puts the identifier on a node of its own', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(testableMaterialWidget(
        child: IdentifierSemantics(
          identifier: 'foo-add',
          child: IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ),
      ));

      final finder = find.bySemanticsIdentifier('foo-add');
      final count = finder.evaluate().length;
      final identifier =
          tester.getSemantics(finder).getSemanticsData().identifier;
      semantics.dispose();

      expect(count, 1);
      expect(identifier, 'foo-add');
    });

    // The 3.27.2 web engine drops the identifier of a text field node.
    testWidgets(
        'around a text field, keeps the text field a child, so the '
        'identifier is not on a text field node', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(testableMaterialWidget(
        child: const IdentifierSemantics.textField(
          identifier: 'foo-name',
          child: SizedBox(width: 200, child: TextField()),
        ),
      ));

      final data = tester
          .getSemantics(find.bySemanticsIdentifier('foo-name'))
          .getSemanticsData();
      final textFields =
          find.semantics.byFlag(SemanticsFlag.isTextField).evaluate().length;
      semantics.dispose();

      expect(data.identifier, 'foo-name');
      expect(data.hasFlag(SemanticsFlag.isTextField), isFalse);
      expect(textFields, 1);
    });
  });
}
