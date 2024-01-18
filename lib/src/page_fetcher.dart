import 'package:cancellation_token/cancellation_token.dart';
import 'package:flutter/foundation.dart';

import 'load_state.dart';
import 'load_type.dart';
import 'logger.dart';
import 'paging_config.dart';
import 'paging_source.dart' hide Error;
import 'paging_state.dart';

class PageFetcher<Key, Value> extends ValueNotifier<PagingState<Key, Value>> {
  PageFetcher({
    this.initialKey,
    required this.config,
    required this.pagingSource,

    /// Initial state of the page fetcher.
    required PagingState<Key, Value> initialState,
  }) : super(initialState);

  final Key? initialKey;
  final PagingConfig config;
  final PagingSource<Key, Value> pagingSource;

  // Cancels any in-flight loads attached to this token. This is used to cancel
  // loads when the page fetcher is disposed.
  final _cancellationToken = CancellationToken();

  @override
  void dispose() {
    // Cancel any in-flight loads.
    _cancellationToken.cancel();
    return super.dispose();
  }

  Future<void> load(LoadType loadType) {
    return switch (loadType) {
      LoadType.refresh => _doInitialLoad(),
      LoadType.append || LoadType.prepend => _doLoad(loadType),
    };
  }

  /// Retry any failed load requests that would result in a [LoadState.Error] update to this
  /// [PagingDataDiffer].
  ///
  /// Unlike [refresh], this does not invalidate [PagingSource], it only retries failed loads
  /// within the same generation of [PagingData].
  ///
  /// [LoadState.Error] can be generated from two types of load requests:
  ///  * [PagingSource.load] returning [PagingSource.LoadResult.Error]
  ///  * [RemoteMediator.load] returning [RemoteMediator.MediatorResult.Error]
  Future<void> retry() async {
    for (final loadType in LoadType.values) {
      final loadState = value.getLoadState(loadType);
      if (loadState is! Error) continue;

      // Reset the error state before calling load.
      value = value.setLoading(loadType);

      load(loadType);
    }
  }

  LoadParams<Key> _loadParams(LoadType loadType, Key? key) {
    return LoadParams(
      loadType: loadType,
      key: key,
      loadSize: loadType == LoadType.refresh
          ? config.initialLoadSize
          : config.pageSize,
    );
  }

  Future<void> _doInitialLoad() {
    return _withCancellationScope(
      token: _cancellationToken,
      onCancelled: (e, stk) {
        log.fine('Initial load cancelled');
      },
      () async {
        // Update load state to loading.
        value = value.setLoading(LoadType.refresh);

        final params = _loadParams(LoadType.refresh, initialKey);

        log.fine(
            'Start REFRESH with loadKey $initialKey on $pagingSource in ${describeIdentity(this)}');

        final result = await _withCancellationScope(
          token: _cancellationToken,
          () => pagingSource.load(params),
        );

        // Return if the load was cancelled.
        if (result == null) return;

        result.map(
          page: (page) {
            log.fine(
                'End REFRESH with loadKey $initialKey in ${describeIdentity(this)}');

            // Update value with the loaded page.
            value = value.insertPage(LoadType.refresh, page);
          },
          error: (it) {
            log.finer(
                'End REFRESH with loadKey $initialKey. Returned $it in ${describeIdentity(this)}');

            // Update value with the error.
            value = value.setError(LoadType.refresh, it.error);
          },
        );
      },
    );
  }

  Future<void> _doLoad(LoadType loadType) {
    return _withCancellationScope(
      token: _cancellationToken,
      onCancelled: (e, stk) {
        log.fine('$loadType cancelled');
      },
      () async {
        assert(
          loadType != LoadType.refresh,
          'Use doInitialLoad for LoadType == refresh',
        );

        final loadKey = _nextLoadKeyOrNull(loadType);
        if (loadKey == null) return;

        // Update load state to loading.
        value = value.setLoading(loadType);

        final params = _loadParams(loadType, loadKey);

        log.fine(
            'Start $loadType with loadKey $loadKey on $pagingSource in ${describeIdentity(this)}');

        final result = await _withCancellationScope(
          token: _cancellationToken,
          () => pagingSource.load(params),
        );

        // Return if the load was cancelled.
        if (result == null) return;

        result.map(
          page: (page) {
            // First, check for common error case where the same key is re-used to load
            // new pages, often resulting in infinite loops.
            final nextKey = switch (loadType) {
              LoadType.prepend => page.prevKey,
              LoadType.append => page.nextKey,
              _ => throw ArgumentError(
                  'Use doInitialLoad for LoadType == refresh'),
            };

            if (nextKey == loadKey) {
              throw StateError(
                '''The same value, $loadKey, was passed as the ${loadType == LoadType.prepend ? 'prevKey' : 'nextKey'} 
            in two sequential Pages loaded from a PagingSource. Re-using load keys in PagingSource is often an error''',
              );
            }

            log.fine(
                'End $loadType with loadKey $loadKey. Returned $page in ${describeIdentity(this)}');

            // Update value with the loaded page.
            value = value.insertPage(loadType, page);
          },
          error: (it) {
            log.finer(
                'End $loadType with loadKey $loadKey. Returned $it in ${describeIdentity(this)}');

            // Update value with the error.
            value = value.setError(loadType, it.error);
          },
        );

        final dropType = switch (loadType) {
          LoadType.prepend => LoadType.append,
          _ => LoadType.prepend,
        };

        // Drop pages if necessary.
        final pagesToDropCount = _pagesToDropCount(dropType);
        if (pagesToDropCount <= 0) return;

        log.fine(
            'Dropping $pagesToDropCount pages for $dropType in ${describeIdentity(this)}');

        // Drop pages.
        value = value.dropPages(dropType, pageCount: pagesToDropCount);
      },
    );
  }

  // @return [PageEvent.Drop] for [loadType] that would allow this [PageFetcher] to
  // respect [PagingConfig.maxSize], `null` if no pages should be dropped for the provided
  // [loadType].
  int _pagesToDropCount(LoadType loadType) {
    final maxSize = config.maxSize;
    if (maxSize == null) return 0;

    // Never drop below 2 pages as this can cause UI flickering with certain configs and it's
    // much more important to protect against this behaviour over respecting a config where
    // maxSize is set unusually (probably incorrectly) strict.
    if (value.pages.length <= 3) return 0;

    if (value.pages.itemCount <= maxSize) return 0;

    if (loadType == LoadType.refresh) {
      throw ArgumentError(
        'LoadType must be Prepend or Append, but got $loadType',
      );
    }

    // Compute pageCount and itemsToDrop.
    var pagesToDrop = 0;
    var itemsToDrop = 0;
    while (pagesToDrop < value.pages.length &&
        value.pages.itemCount - itemsToDrop > maxSize) {
      final pages = value.pages;

      final pageSize = switch (loadType) {
        LoadType.prepend => pages[pagesToDrop].items.length,
        _ => pages[(pages.length - 1) - pagesToDrop].items.length,
      };

      itemsToDrop += pageSize;
      pagesToDrop++;
    }

    return pagesToDrop;
  }

  Key? _nextLoadKeyOrNull(LoadType loadType) {
    return switch (loadType) {
      LoadType.prepend => _nextPrependKey,
      LoadType.append => _nextAppendKey,
      LoadType.refresh => throw ArgumentError('Just use initialKey directly'),
    };
  }

  // The key to use to load next page to prepend or null if we should stop
  // loading in this direction.
  Key? get _nextPrependKey {
    final currentValue = value;
    if (currentValue.pages.isEmpty) return null;
    // Skip load if in error state, unless retrying.
    if (currentValue.prependLoadState is Error) return null;

    return currentValue.pages.first.prevKey;
  }

  // The key to use to load next page to append or null if we should stop
  // loading in this direction.
  Key? get _nextAppendKey {
    final currentValue = value;
    if (currentValue.pages.isEmpty) return null;
    // Skip load if in error state, unless retrying.
    if (currentValue.appendLoadState is Error) return null;

    return currentValue.pages.last.nextKey;
  }

  /// Returns a [Future] that completes with the result of [callback] unless
  /// [token] is cancelled before [callback] completes.
  ///
  /// If [token] is cancelled, the current state of [value] is restored before
  /// the returned [Future] completes.
  ///
  /// If [onCancelled] is provided, it is invoked with the [Object] that caused
  /// the cancellation and the [StackTrace] of the cancellation.
  Future<T?> _withCancellationScope<T>(
    Future<T> Function() callback, {
    required CancellationToken token,
    void Function(Object, StackTrace)? onCancelled,
  }) async {
    // Store the current state to revert to if the callback throws an exception.
    final currentState = value;

    try {
      return await CancellableFuture.from(callback, token);
    } on CancelledException catch (e, stk) {
      // If the callback was cancelled, revert to the previous state.
      value = currentState;

      // Invoke the onCancelled callback if provided.
      if (onCancelled != null) onCancelled(e, stk);

      // Don't rethrow the exception, since we've already reverted to the
      // previous state.
      return null;
    }
  }
}

extension<Key, Value> on PagingState<Key, Value> {
  /// Returns the [LoadState] for the given [LoadType].
  LoadState getLoadState(LoadType loadType) {
    return switch (loadType) {
      LoadType.refresh => refreshLoadState,
      LoadType.prepend => prependLoadState,
      LoadType.append => appendLoadState,
    };
  }

  /// Returns the updated [PagingState] after inserting a new [Page] into the
  /// [PagingState].
  PagingState<Key, Value> insertPage(
    LoadType loadType,
    Page<Key, Value> page,
  ) {
    switch (loadType) {
      case LoadType.refresh:
        // We are not checking if pages are empty because a refresh action
        // can be triggered by a user even if there are some pages in the state.
        return PagingState(
          pages: PagingList(bottom: [page]),
          refreshLoadState: LoadState.notLoadingComplete,
          prependLoadState: LoadState.notLoading(
            endOfPaginationReached: page.prevKey == null,
          ),
          appendLoadState: LoadState.notLoading(
            endOfPaginationReached: page.nextKey == null,
          ),
        );
      case LoadType.prepend:
        if (pages.isEmpty) {
          throw StateError('should\'ve received an init before prepend');
        }

        return copyWith(
          pages: PagingList(
            top: [page, ...pages.top],
            bottom: pages.bottom,
          ),
          prependLoadState: LoadState.notLoading(
            endOfPaginationReached: page.prevKey == null,
          ),
        );
      case LoadType.append:
        if (pages.isEmpty) {
          throw StateError('should\'ve received an init before append');
        }

        return copyWith(
          pages: PagingList(
            top: pages.top,
            bottom: [...pages.bottom, page],
          ),
          appendLoadState: LoadState.notLoading(
            endOfPaginationReached: page.nextKey == null,
          ),
        );
    }
  }

  /// Returns the updated [PagingState] after dropping [pageCount] pages from
  /// the [PagingState] in the direction of [dropType].
  PagingState<Key, Value> dropPages(
    LoadType dropType, {
    required int pageCount,
  }) {
    if (pageCount >= pages.length) {
      throw ArgumentError(
        'invalid drop count. have ${pages.length} but wanted to drop $pageCount',
      );
    }

    switch (dropType) {
      case LoadType.prepend:
        {
          // We need to check if the dropPageCount can be applied to the top
          // list. If not, we need to drop the remaining pages from the bottom
          // list.
          final topPageCount = pages.top.length;
          if (pageCount <= topPageCount) {
            // We can drop the pages from the top list.
            return copyWith(
              pages: PagingList(
                top: pages.top.sublist(pageCount),
                bottom: pages.bottom,
              ),
              prependLoadState: LoadState.notLoadingIncomplete,
            );
          }

          // We need to drop the remaining pages from the bottom list.
          return copyWith(
            pages: PagingList(
              top: const [],
              bottom: pages.bottom.sublist(pageCount - topPageCount),
            ),
            prependLoadState: LoadState.notLoadingIncomplete,
          );
        }
      case LoadType.append:
        {
          // We need to check if the dropPageCount can be applied to the bottom
          // list. If not, we need to drop the remaining pages from the top
          // list.
          final bottomPageCount = pages.bottom.length;
          if (pageCount <= bottomPageCount) {
            // We can drop the pages from the bottom list.
            return copyWith(
              pages: PagingList(
                top: pages.top,
                bottom: pages.bottom.sublist(0, bottomPageCount - pageCount),
              ),
              appendLoadState: LoadState.notLoadingIncomplete,
            );
          }

          // We need to drop the remaining pages from the top list.
          final topPageCount = pages.top.length;
          return copyWith(
            pages: PagingList(
              top: pages.top.sublist(
                0,
                topPageCount - (pageCount - bottomPageCount),
              ),
              bottom: const [],
            ),
            appendLoadState: LoadState.notLoadingIncomplete,
          );
        }
      case _:
        throw ArgumentError('invalid drop type: $dropType');
    }
  }

  /// Returns the updated [PagingState] after setting the state to loading.
  PagingState<Key, Value> setLoading(LoadType loadType) {
    return switch (loadType) {
      LoadType.refresh => copyWith(refreshLoadState: const LoadState.loading()),
      LoadType.prepend => copyWith(prependLoadState: const LoadState.loading()),
      LoadType.append => copyWith(appendLoadState: const LoadState.loading()),
    };
  }

  /// Returns the updated [PagingState] after setting the [error] state.
  PagingState<Key, Value> setError(LoadType loadType, [Object? error]) {
    return switch (loadType) {
      LoadType.refresh => copyWith(refreshLoadState: LoadState.error(error)),
      LoadType.prepend => copyWith(prependLoadState: LoadState.error(error)),
      LoadType.append => copyWith(appendLoadState: LoadState.error(error)),
    };
  }
}
