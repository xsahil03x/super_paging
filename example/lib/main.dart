import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:example/src/rick_and_morty_app.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(const RickAndMortyApp());
}
