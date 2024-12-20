import 'package:example/src/event.dart';
import 'package:example/src/event_card.dart';
import 'package:example/src/event_source.dart';
import 'package:example/src/object_box.dart';
import 'package:flutter/material.dart';
import 'package:super_paging/super_paging.dart';

class EventTestApp extends StatelessWidget {
  final ObjectBox db;
  
  const EventTestApp({
    super.key,
    required this.db
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(useMaterial3: true),
      home: EventTestPage(db: db),
    );
  }
}

class EventTestPage extends StatefulWidget {
  final ObjectBox db;
  
  const EventTestPage({
    super.key,
    required this.db
  });

  @override
  State<EventTestPage> createState() => _EventTestPageState();
}

class _EventTestPageState extends State<EventTestPage> {
  late final Pager<int, Event> pager;
  final DateTime currentTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    pager = Pager(
      initialKey: 0,
      config: const PagingConfig(pageSize: 20, initialLoadSize: 60),
      pagingSourceFactory: () => EventsSource(currentTime: currentTime, db: widget.db),
    );

    super.initState();
  }

  @override
  void dispose() {
    pager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BidirectionalPagingListView(
      pager: pager,

      itemBuilder: (BuildContext context, int index) {
        final eventData = pager.items.elementAt(index);

        return EventCard(
            eventData: eventData,
          );
      },

      emptyBuilder: (BuildContext context) {
        return const Center(
          child: Text('No characters found'),
        );
      },

      errorBuilder: (BuildContext context, Object? error) {
        return Center(child: Text('$error'));
      },

      loadingBuilder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
