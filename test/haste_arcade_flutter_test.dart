import 'package:flutter_test/flutter_test.dart';
import 'package:haste_arcade_flutter/src/controllers/haste_controller.dart';

void main() {
  test('init hasteArcade game', () async {
    // ignore: non_constant_identifier_names
    final hasteArcadeFlutter = HasteArcadeFlutter();
    await hasteArcadeFlutter.initAuth();
  });
}
