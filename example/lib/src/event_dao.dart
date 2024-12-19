import 'dart:math';

import 'package:example/objectbox.g.dart';
import 'package:example/src/event.dart';

class EventDao {
  final Store store;
  final Box<Event> eventBox;

  EventDao({
    required this.store
  }) : eventBox = store.box<Event>();

  Future<List<Event>> getFutureEventsAsync(DateTime from, int limit, int offset) async {
    await ensureEventsExist();
    
    final fromDay = DateTime(from.year, from.month, from.day);

    var builder = eventBox
      .query(Event_.timestamp.greaterOrEqual(fromDay.millisecondsSinceEpoch))
      .order(Event_.timestamp);

    var query = builder
      .build()
      ..offset = offset
      ..limit = limit;

    return await query.findAsync();
  }

  Future<List<Event>> getPastEventsAsync(DateTime from, int limit, int offset) async {
    await ensureEventsExist();

    final fromDay = DateTime(from.year, from.month, from.day);

    var builder = eventBox
      .query(Event_.timestamp.lessThan(fromDay.millisecondsSinceEpoch))
      .order(Event_.timestamp, flags: Order.descending);

    var query = builder
      .build()
      ..offset = offset
      ..limit = limit;

    return await query.findAsync();
  }

  Future<void> ensureEventsExist() async {
    final eventCount = eventBox.count();

    if (eventCount == 0) {
      final random = Random();
      final now = DateTime.now();

      final events = List.generate(100, (index) {
        final randomDays = random.nextInt(365) * (random.nextBool() ? 1 : -1);
        final randomDate = now.add(Duration(days: randomDays));
        return Event(
          timestamp: randomDate,
          name: 'Random Event #${index + 1}',
        );
      });

      await eventBox.putManyAsync(events);
    }
  }
}