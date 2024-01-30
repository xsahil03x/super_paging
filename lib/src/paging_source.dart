import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_pager/src/paging_config.dart';
import 'package:super_pager/src/super_pager.dart';

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
/// ### Loading Pages
///
/// [SuperPager] queries data from its [PagingSource] in response to loading
/// hints generated as the user scrolls in a `PagingListView`.
///
/// To control how and when a [SuperPager] queries data from its [PagingSource],
/// see [PagingConfig], which defines behavior such as [PagingConfig.pageSize]
/// and [PagingConfig.prefetchIndex].
///
/// * [Key] - refers to the Type of key which define what data to load. E.g. [Int]
///   to represent either a page number or item position, or [String] if your
///   network uses Strings as next tokens returned with each response.
/// * [Value] - refers to the Type of data loaded in by this [PagingSource].
///   E.g., the type of data that will be displayed in a list view.
///
/// {@tool snippet}
///
/// This example shows how to implement a [PagingSource] that loads data from
/// network.
///
/// ```dart
/// class ExamplePagingSource extends PagingSource<int, String> {
///   @override
///   Future<LoadResult<int, String>> load(LoadParams<int> params) async {
///     try {
///       // Start refresh at page 1 if undefined.
///       final nextPageKey = params.key ?? 1;
///       final response = await http.get(Uri.parse(
///           'https://jsonplaceholder.typicode.com/posts?_page=$nextPageKey'));
///       final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
///       final nextPage = nextPageKey + 1;
///       return LoadResult.page(
///         items: parsed.map<String>((json) => json['title'] as String).toList(),
///         prevKey: null, // Only paging forward.
///         nextKey: nextPage,
///       );
///     } catch (e) {
///       return LoadResult.error(e);
///     }
///   }
/// }
/// ```
///
/// {@end-tool}
///
/// see also:
///
///  * [SuperPager], which uses a [PagingSource] to load data.
///  * [PagingConfig], which configures the behavior of a [SuperPager].
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
  /// [PagingSource.load] or a refresh triggered by [PagingSource.refresh].
  const factory LoadParams.refresh({
    /// Key for the page to be loaded.
    ///
    /// [key] can be `null` only if this [LoadParams] is [Refresh], and either
    /// no `initialKey` is provided to the [SuperPager].
    ///
    /// The value of [key] is dependent on the type of [LoadParams]:
    ///  * [Refresh] - The nullable `initialKey` passed to the [SuperPager].
    ///  * [Prepend] - [LoadResultPage.prevKey] of the loaded page at the front
    ///    of the list.
    ///  * [Append] - [LoadResultPage.nextKey] of the loaded page at the end of
    ///    the list.
    Key? key,
    required int loadSize,
  }) = Refresh<Key>;

  /// Params to load a page of data from a [PagingSource] via
  /// [PagingSource.load] to be appended to the end of the list.
  const factory LoadParams.append({
    required Key key,
    required int loadSize,
  }) = Append<Key>;

  /// Params to load a page of data from a [PagingSource] via
  /// [PagingSource.load] to be prepended to the start of the list.
  const factory LoadParams.prepend({
    required Key key,
    required int loadSize,
  }) = Prepend<Key>;

  /// Creates a [LoadParams] from [loadType] and [loadSize].
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
  }) = LoadResultPage<Key, Value>;

  /// Error result object for [PagingSource.load].
  ///
  /// This return type indicates an expected, recoverable error (such as a
  /// network load failure). This failure will be forwarded to the UI as a
  /// [LoadResultError], and may be retried.
  const factory LoadResult.error([Object? error]) = LoadResultError;
}
