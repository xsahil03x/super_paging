import 'package:flutter/foundation.dart';

import 'package:super_paging/src/load_state.dart';
import 'package:super_paging/src/load_type.dart';
import 'package:super_paging/src/logger.dart';
import 'package:super_paging/src/page_fetcher.dart';
import 'package:super_paging/src/paging_config.dart';
import 'package:super_paging/src/paging_source.dart';
import 'package:super_paging/src/paging_state.dart';

typedef PagingSourceFactory<Key, Value> = PagingSource<Key, Value> Function();

typedef PageFetcherFactory<Key, Value> = PageFetcher<Key, Value> Function(
  Key? initialKey,
  PagingState<Key, Value> initialState,
);

/// A higher-level abstraction for managing paginated data using a
/// [PagingSource].
///
/// The [Pager] class facilitates the coordination of a [PageFetcher] with
/// its associated [PagingSource], providing methods for loading data,
/// retrying failed loads, and refreshing the dataset.
///
/// It implements [ValueListenable] to allow observers to listen for changes in
/// the [PagingState] of the paginated data.
///
/// [Pager] is designed to be used with [PagingListView] and
/// [BidirectionalPagingListView] to display the paginated data but can be used
/// with any widget that consumes a [ValueListenable].
///
/// see also:
///
///  * [PagingSource], which is the source of data for this [Pager].
///  * [PagingState], which represents the state of the paginated data.
///  * [PagingConfig], which configures the behavior of this [Pager].
class Pager<Key, Value> implements ValueListenable<PagingState<Key, Value>> {
  /// Creates a new [Pager] with the provided [config] and [pagingSource].
  Pager({
    Key? initialKey,
    required PagingConfig config,
    PagingState<Key, Value> initialState = const PagingState(),
    required PagingSourceFactory<Key, Value> pagingSourceFactory,
  })  : _notifier = ValueNotifier(initialState),
        _pageFetcherFactory = ((initialKey, initialState) {
          final pageFetcher = PageFetcher(
            initialKey: initialKey,
            config: config,
            initialState: initialState,
            pagingSource: pagingSourceFactory.call(),
          );

          log.fine('Generated new PageFetcher');

          return pageFetcher;
        }) {
    // Create a new page fetcher and listen to its state changes.
    _pageFetcher = _pageFetcherFactory.call(initialKey, initialState);
    _pageFetcher.addListener(_onPageFetcherStateChange);
  }

  @visibleForTesting
  Pager.custom({
    Key? initialKey,
    PagingState<Key, Value> initialState = const PagingState(),
    required PageFetcherFactory<Key, Value> pageFetcherFactory,
  })  : _notifier = ValueNotifier(initialState),
        _pageFetcherFactory = pageFetcherFactory {
    // Create a new page fetcher and listen to its state changes.
    _pageFetcher = _pageFetcherFactory.call(initialKey, initialState);
    _pageFetcher.addListener(_onPageFetcherStateChange);
  }

  // Called whenever the page fetcher's state changes.
  void _onPageFetcherStateChange() {
    _notifier.value = _pageFetcher.value;
  }

  late PageFetcher<Key, Value> _pageFetcher;
  final PageFetcherFactory<Key, Value> _pageFetcherFactory;

  final ValueNotifier<PagingState<Key, Value>> _notifier;

  /// The [PagingConfig] used by this [Pager].
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

  /// Load data from the [PagingSource] represented by this [Pager].
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

  /// Refresh the data presented by this [Pager].
  ///
  /// [refresh] triggers the creation of a new [PagingState] with a new instance
  /// of [PageFetcher] to represent an updated snapshot of the backing dataset.
  ///
  /// Note: This API is intended for UI-driven refresh signals, such as
  /// swipe-to-refresh.
  Future<void> refresh({
    /// Optional key to use as the initial key for the new page fetcher.
    ///
    /// This is useful when you want to refresh the data with a different key.
    /// For eg, when you want to directly go to the nth page instead of
    /// swiping through all the pages.
    ///
    /// If not provided, the initial key of the previous page fetcher will be
    /// used.
    Key? refreshKey,
    bool resetPages = true,
  }) {
    final previousPageFetcher = _pageFetcher;

    // Dispose the current page fetcher and remove its listener.
    previousPageFetcher.removeListener(_onPageFetcherStateChange);
    previousPageFetcher.dispose();

    // Determine the initial state for the new page fetcher.
    //
    // If resetPages is true, we reset the state, otherwise we use the
    // pages from the previous page fetcher.
    var initialState = PagingState.fromPages(previousPageFetcher.value.pages);
    if (resetPages) {
      initialState = const PagingState();
    }

    // Create a new page fetcher.
    final initialKey = refreshKey ?? previousPageFetcher.initialKey;
    _pageFetcher = _pageFetcherFactory.call(initialKey, initialState);
    _pageFetcher.addListener(_onPageFetcherStateChange);

    // Load the new page fetcher.
    return _pageFetcher.load(LoadType.refresh);
  }

  /// Discards any resources used by the [Pager]. After this is called, the
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

/// Extension methods for [Pager].
extension PagerExtension<Key, Value> on Pager<Key, Value> {
  /// Returns all the loaded items accumulated from pager.
  Iterable<Value> get items => pages.items;

  /// List with all the pages loaded so far.
  PagingList<LoadResultPage<Key, Value>> get pages => value.pages;

  /// Load state of the initial page.
  LoadState get refreshLoadState => value.refreshLoadState;

  /// Load state of the previous page.
  LoadState get prependLoadState => value.prependLoadState;

  /// Load state of the next page.
  LoadState get appendLoadState => value.appendLoadState;
}
