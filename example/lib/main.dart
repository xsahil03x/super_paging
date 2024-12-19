import 'package:example/src/object_box.dart';
import 'package:example/src/event_test_app.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  var db = await ObjectBox.create();

  runApp(
    Provider<ObjectBox>(
      create: (context) => db,
      dispose: (context, value) { db.store.close(); },
      child: EventTestApp(db: db),
    )
  );
}
