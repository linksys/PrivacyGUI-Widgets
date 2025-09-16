import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

import 'font_loader.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadTestFonts();

  await testMain();
}
