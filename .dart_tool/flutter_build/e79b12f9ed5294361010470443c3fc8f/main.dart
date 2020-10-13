// @dart = 2.7

import 'dart:ui' as ui;

import 'package:codeit_kss_git_client/main.dart' as entrypoint;

Future<void> main() async {
  if (true) {
    await ui.webOnlyInitializePlatform();
  }
  entrypoint.main();
}
