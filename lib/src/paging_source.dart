import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'load_type.dart';
import 'preconditions.dart';

part 'paging_source.freezed.dart';

/// Base class for an abstraction of pageable static data from some source,
/// where loading pages of data is typically an expensive operation. Some
/// examples of common [PagingSource]s might be from network or from a database.
///
/// An instance of a [PagingSource] is used to load pages of data for an
/// instance of [PagingState].
///
/// A [PagingState] can grow as it loads more data, but the data loaded cannot
/// be updated. If the underlying data set is modified, a new [PagingSource]
/// must be created to represent an updated snapshot of the data.
///
/// ### Loading Pages
///
/// [PagingData] queries data from its [PagingSource] in response to loading hints generated as
/// the user scrolls in a `RecyclerView`.
///
/// To control how and when a [PagingData] queries data from its [PagingSource], see [PagingConfig],
/// which defines behavior such as [PagingConfig.pageSize] and [PagingConfig.prefetchIndex].
///
/// ### Updating Data
///
/// A [PagingSource] / [PagingData] pair is a snapshot of the data set. A new [PagingData] /
/// [PagingData] must be created if an update occurs, such as a reorder, insert, delete, or content
/// update occurs. A [PagingSource] must detect that it cannot continue loading its snapshot
/// (for instance, when Database query notices a table being invalidated), and call [invalidate].
/// Then a new [PagingSource] / [PagingData] pair would be created to represent data from the new
/// state of the database query.
///
/// ### Presenting Data to UI
///
/// To present data loaded by a [PagingSource] to a `RecyclerView`, create an instance of [Pager],
/// which provides a stream of [PagingData] that you may collect from and submit to a
/// [PagingDataAdapter][androidx.paging.PagingDataAdapter].
///
/// @param Key Type of key which define what data to load. E.g. [Int] to represent either a page
/// number or item position, or [String] if your network uses Strings as next tokens returned with
/// each response.
/// @param Value Type of data loaded in by this [PagingSource]. E.g., the type of data that will be
/// passed to a [PagingDataAdapter][androidx.paging.PagingDataAdapter] to be displayed in a
/// `RecyclerView`.
///
/// @sample androidx.paging.samples.pageKeyedPagingSourceSample
/// @sample androidx.paging.samples.pageIndexedPagingSourceSample
///
/// @see Pager
abstract mixin class PagingSource<Key, Value> {
  const PagingSource();

  /// Loading API for [PagingSource].
  ///
  /// Implement this method to trigger your async load (e.g. from database or
  /// network).
  Future<LoadResult<Key, Value>> load(LoadParams<Key> params);
}

/// Params for a load request on a [PagingSource] from [PagingSource.load].
@freezed
sealed class LoadParams<Key> with _$LoadParams<Key> {
  /// Params for an initial load request on a [PagingSource] from
  /// [PagingSource.load] or a refresh triggered by [invalidate].
  const factory LoadParams.refresh({
    /// Key for the page to be loaded.
    ///
    /// [key] can be `null` only if this [LoadParams] is [Refresh], and either no `initialKey`
    /// is provided to the [Pager] or [PagingSource.getRefreshKey] from the previous
    /// [PagingSource] returns `null`.
    ///
    /// The value of [key] is dependent on the type of [LoadParams]:
    ///  * [Refresh]
    ///      * On initial load, the nullable `initialKey` passed to the [Pager].
    ///      * On subsequent loads due to invalidation or refresh, the result of
    ///      [PagingSource.getRefreshKey].
    ///  * [Prepend] - [LoadResult.Page.prevKey] of the loaded page at the front of the list.
    ///  * [Append] - [LoadResult.Page.nextKey] of the loaded page at the end of the list.
    Key? key,
    required int loadSize,
  }) = Refresh<Key>;

  /// Params to load a page of data from a [PagingSource] via [PagingSource.load] to be
  /// appended to the end of the list.
  const factory LoadParams.append({
    required Key key,
    required int loadSize,
  }) = Append<Key>;

  /// Params to load a page of data from a [PagingSource] via [PagingSource.load] to be
  /// prepended to the start of the list.
  const factory LoadParams.prepend({
    required Key key,
    required int loadSize,
  }) = Prepend<Key>;

  factory LoadParams({
    required LoadType loadType,
    required int loadSize,
    Key? key,
  }) {
    return switch (loadType) {
      LoadType.refresh => Refresh(key: key, loadSize: loadSize),
      LoadType.prepend => Prepend(key: requireNotNull(key), loadSize: loadSize),
      LoadType.append => Append(key: requireNotNull(key), loadSize: loadSize),
    };
  }
}

/// Result of a load request from [PagingSource.load].
@freezed
sealed class LoadResult<Key, Value> with _$LoadResult<Key, Value> {
  /// Success result object for [PagingSource.load].
  const factory LoadResult.page({
    /// Loaded items.
    required List<Value> items,

    /// [Key] for previous page if more items can be loaded in that direction,
    /// `null` otherwise.
    Key? prevKey,

    /// [Key] for next page if more items can be loaded in that direction,
    /// `null` otherwise.
    Key? nextKey,
  }) = Page<Key, Value>;

  /// Error result object for [PagingSource.load].
  ///
  /// This return type indicates an expected, recoverable error (such as a network load
  /// failure). This failure will be forwarded to the UI as a [LoadState.Error], and may be
  /// retried.
  const factory LoadResult.error([Object? error]) = Error;
}
