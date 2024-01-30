import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_pager/src/two_part_list.dart';

import 'load_state.dart';
import 'paging_source.dart';

part 'paging_state.freezed.dart';

/// Represents the list of pages loaded so far in a [PagingState].
typedef PagingList<E> = TwoPartList<E>;

/// Paged state that can be used with [PagedStateNotifier].
@freezed
sealed class PagingState<Key, Value> with _$PagingState<Key, Value> {
  /// Creates a [PagingState] with the provided parameters.
  const factory PagingState({
    /// List with all the pages loaded so far.
    @Default(PagingList()) PagingList<LoadResultPage<Key, Value>> pages,

    /// Load state of the initial page.
    @Default(LoadState.notLoadingIncomplete) LoadState refreshLoadState,

    /// Load state of the previous page.
    @Default(LoadState.notLoadingIncomplete) LoadState prependLoadState,

    /// Load state of the next page.
    @Default(LoadState.notLoadingIncomplete) LoadState appendLoadState,
  }) = _PagingState<Key, Value>;

  /// Creates a [PagingState] from the provided [pages].
  factory PagingState.fromPages(List<LoadResultPage<Key, Value>> pages) {
    if (pages.isEmpty) return const PagingState();

    return PagingState(
      pages: PagingList(bottom: pages),
      refreshLoadState: LoadState.notLoadingComplete,
      prependLoadState: LoadState.notLoading(
        endOfPaginationReached: pages.first.prevKey == null,
      ),
      appendLoadState: LoadState.notLoading(
        endOfPaginationReached: pages.last.nextKey == null,
      ),
    );
  }
}

extension PagingListExtension<Key, Value> on List<LoadResultPage<Key, Value>> {
  /// Returns the [Key] for the previous page to be fetched if available,
  /// `null` otherwise.
  Key? get prevKey => firstOrNull?.prevKey;

  /// Returns the [Key] for the next page to be fetched if available,
  /// `null` otherwise.
  Key? get nextKey => lastOrNull?.nextKey;

  /// Returns all the loaded items accumulated from [pages].
  Iterable<Value> get items => expand((it) => it.items);

  /// Returns the total number of items in [pages].
  int get itemCount => fold(0, (acc, it) => acc + it.items.length);

  /// Returns `True` if all loaded pages are empty or no pages were loaded when
  /// this [Success] was created, `False` otherwise.
  bool get isListEmpty => isEmpty || every((it) => it.items.isEmpty);

  /// Returns `True` if there is at least one loaded page with items when this
  /// [Success] was created, `False` otherwise.
  bool get isListNotEmpty => isNotEmpty && any((it) => it.items.isNotEmpty);

  /// Returns the first loaded item in the list or `null` if all loaded pages
  /// are empty or no pages were loaded when this [Success] was created.
  Value? get firstItemOrNull => firstOrNull?.items.firstOrNull;

  /// Returns the last loaded item in the list or `null` if all loaded pages are
  /// empty or no pages were loaded when this [Success] was created.
  Value? get lastItemOrNull => lastOrNull?.items.lastOrNull;
}
