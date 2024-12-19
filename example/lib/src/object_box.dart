import 'package:example/objectbox.g.dart';
import 'package:example/src/event_dao.dart';

class ObjectBox {
  final Store store;

  EventDao get eventDao => EventDao(store: store);

  ObjectBox({
    required this.store,
  });

  static Future<Store> createStore() async {
    return Store(getObjectBoxModel(), directory: "memory:test-db");
  }

  static Future<ObjectBox> create() async {
    final store = await createStore();

    return ObjectBox(store: store);
  }
}