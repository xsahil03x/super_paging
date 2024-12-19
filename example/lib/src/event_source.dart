import 'package:example/src/event.dart';
import 'package:super_paging/super_paging.dart';
import 'package:example/src/object_box.dart';

class EventsSource extends PagingSource<int, Event> {
  final ObjectBox db;
  final DateTime currentTime;

  EventsSource({
    required this.db,
    required this.currentTime
  });

  @override
  Future<LoadResult<int, Event>> load(LoadParams<int> params) async {
    var pageToLoad = params.key ?? 0;

    try {
      if (pageToLoad >= 0) {
        final events = await db.eventDao.getFutureEventsAsync(currentTime, params.loadSize, params.loadSize * pageToLoad);

        return LoadResult.page(
          items: events,
          prevKey: pageToLoad - 1,
          nextKey: pageToLoad + 1,
        );
      } else {
        final events = await db.eventDao.getPastEventsAsync(currentTime, params.loadSize, params.loadSize * pageToLoad);

        return LoadResult.page(
          items: events,
          prevKey: pageToLoad - 1,
          nextKey: pageToLoad + 1,
        );
      }
    } catch (e) {
      return LoadResult.error(e);
    }
  }
}