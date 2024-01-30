import 'package:flutter/foundation.dart';
import 'package:super_pager/src/widget/bidirectional_paging_list_view.dart';

import 'load_type.dart';
import 'logger.dart';
import 'page_fetcher.dart';
import 'paging_config.dart';
import 'paging_source.dart';
import 'paging_state.dart';

typedef PageFetcherFactory<Key, Value> = PageFetcher<Key, Value> Function(
  PagingState<Key, Value> initialState,
);

/// A higher-level abstraction for managing paginated data using a
/// [PagingSource].
///
/// The [SuperPager] class facilitates the coordination of a [PageFetcher] with
/// its associated [PagingSource], providing methods for loading data,
/// retrying failed loads, and refreshing the dataset.
///
/// It implements [ValueListenable] to allow observers to listen for changes in
/// the [PagingState] of the paginated data.
///
/// [SuperPager] is designed to be used with [PagingListView] and
/// [BidirectionalPagingListView] to display the paginated data but can be used
/// with any widget that consumes a [ValueListenable].
///
/// see also:
///
///  * [PagingSource], which is the source of data for this [SuperPager].
///  * [PagingState], which represents the state of the paginated data.
///  * [PagingConfig], which configures the behavior of this [SuperPager].
class SuperPager<Key, Value>
    implements ValueListenable<PagingState<Key, Value>> {
  /// Creates a [SuperPager]
  SuperPager({
    Key? initialKey,
    required PagingConfig config,
    required PagingSource<Key, Value> pagingSource,
    PagingState<Key, Value> initialState = const PagingState(),
  })  : _notifier = ValueNotifier(initialState),
        _pageFetcherFactory = ((initialState) {
          final pageFetcher = PageFetcher(
            initialKey: initialKey,
            config: config,
            pagingSource: pagingSource,
            initialState: initialState,
          );

          log.fine('Generated new PageFetcher');

          return pageFetcher;
        }) {
    // Create a new page fetcher and listen to its state changes.
    _pageFetcher = _pageFetcherFactory.call(initialState);
    _pageFetcher.addListener(_onPageFetcherStateChange);
  }

  @visibleForTesting
  SuperPager.custom({
    required PageFetcherFactory<Key, Value> pageFetcherFactory,
    PagingState<Key, Value> initialState = const PagingState(),
  })  : _notifier = ValueNotifier(initialState),
        _pageFetcherFactory = pageFetcherFactory {
    // Create a new page fetcher and listen to its state changes.
    _pageFetcher = _pageFetcherFactory.call(initialState);
    _pageFetcher.addListener(_onPageFetcherStateChange);
  }

  // Called whenever the page fetcher's state changes.
  void _onPageFetcherStateChange() {
    _notifier.value = _pageFetcher.value;
  }

  late PageFetcher<Key, Value> _pageFetcher;
  final PageFetcherFactory<Key, Value> _pageFetcherFactory;

  final ValueNotifier<PagingState<Key, Value>> _notifier;

  /// The [PagingConfig] used by this [SuperPager].
  PagingConfig get config => _pageFetcher.config;

  @override
  PagingState<Key, Value> get value => _notifier.value;

  @override
  void addListener(VoidCallback listener) {
    return _notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    return _notifier.removeListener(listener);
  }

  /// Load data from the [PagingSource] represented by this [SuperPager].
  Future<void> load(LoadType loadType) {
    return _pageFetcher.load(loadType);
  }

  /// Retry any failed load requests that would result in a [LoadState.error]
  /// update to this [PagingState].
  ///
  /// Unlike [refresh], this does not invalidate [PageFetcher], it only retries
  /// failed loads within the same generation of [PageFetcher].
  ///
  /// [LoadState.error] can be generated from types of load requests:
  ///  * [PagingSource.load] returning [LoadResult.error]
  Future<void> retry() => _pageFetcher.retry();

  /// Refresh the data presented by this [SuperPager].
  ///
  /// [refresh] triggers the creation of a new [PagingState] with a new instance
  /// of [PageFetcher] to represent an updated snapshot of the backing dataset.
  ///
  /// Note: This API is intended for UI-driven refresh signals, such as
  /// swipe-to-refresh.
  Future<void> refresh({bool resetPages = true}) {
    final current = _pageFetcher;

    // Dispose the current page fetcher.
    current.removeListener(_onPageFetcherStateChange);
    current.dispose();

    // Determine the initial state for the new page fetcher.
    //
    // If resetPages is true, we reset the state, otherwise we use the
    // pages from the current page fetcher.
    var initialState = PagingState.fromPages(value.pages);
    if (resetPages) {
      initialState = const PagingState();
    }

    // Create a new page fetcher.
    _pageFetcher = _pageFetcherFactory.call(initialState);
    _pageFetcher.addListener(_onPageFetcherStateChange);

    // Load the new page fetcher.
    return _pageFetcher.load(LoadType.refresh);
  }

  /// Discards any resources used by the [SuperPager]. After this is called, the
  /// object is not in a usable state and should be discarded (calls to
  /// [addListener] will throw after the object is disposed).
  ///
  /// This method should only be called by the object's owner.
  @mustCallSuper
  void dispose() {
    _pageFetcher.removeListener(_onPageFetcherStateChange);
    _pageFetcher.dispose();
    _notifier.dispose();
  }
}
