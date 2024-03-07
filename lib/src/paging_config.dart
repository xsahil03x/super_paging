/// An object used to configure loading behavior within a [Pager], as it
/// loads content from a [PagingSource].
class PagingConfig {
  const PagingConfig({
    required this.pageSize,
    this.prefetchIndex = 3,
    int? initialLoadSize,
    this.maxSize,
  })  : initialLoadSize = initialLoadSize ?? pageSize * initialPageMultiplier,
        assert(
          prefetchIndex == null || prefetchIndex <= pageSize / 2,
          'Prefetch index must be less than pageSize / 2',
        ),
        assert(
          maxSize == null || maxSize >= pageSize * 3,
          'Maximum size must be at least 3 * pageSize',
        );

  /// The default multiplier for [initialLoadSize].
  static const initialPageMultiplier = 3;

  /// Defines the number of items loaded at once from the [PagingSource].
  ///
  /// Should be several times the number of visible items onscreen.
  ///
  /// Configuring your page size depends on how your data is being loaded and
  /// used. Smaller page sizes improve memory usage, latency, and avoid
  /// GC churn. Larger pages generally improve loading throughput.
  ///
  /// If you're loading data for very large, social-media style cards that take
  /// up most of a screen, and your database isn't a bottleneck, 10-20 may make
  /// sense. If you're displaying dozens of items in a tiled grid, which can
  /// present items during a scroll much more quickly, consider closer to 100.
  ///
  /// Note: [pageSize] is used to inform [LoadParams.loadSize], but is not
  /// enforced. A [PagingSource] may completely ignore this value and still
  /// return a valid [Page].
  final int pageSize;

  /// Prefetch index defines how far from the edge of loaded content an access
  /// must be to trigger further loading.
  ///
  /// E.g., If this value is set to 3, a [Pager] will attempt to load the
  /// next page in advance when the user scrolls within 3 items of the end of
  /// currently loaded content.
  ///
  /// A value of `null` indicates that no list items will be loaded until they
  /// are specifically requested. This is generally not recommended, so that
  /// users don't observe a end of list while scrolling.
  final int? prefetchIndex;

  /// Defines requested load size for initial load from [PagingSource],
  /// typically larger than [pageSize], so on first load data there's a large
  /// enough range of content loaded to cover small scrolls.
  ///
  /// Note: [initialLoadSize] is used to inform [LoadParams.loadSize], but is
  /// not enforced. A [PagingSource] may completely ignore this value and still
  /// return a valid initial [Page].
  final int initialLoadSize;

  /// Defines the maximum number of items that may be loaded into [PagingData]
  /// before pages should be dropped.
  ///
  /// If set to null (Default), pages will never be dropped.
  ///
  /// This can be used to cap the number of items kept in memory by dropping
  /// pages. This value is typically many pages so old pages are cached in case
  /// the user scrolls back.
  ///
  /// This value must be at least three times the [pageSize]. This constraint
  /// prevent loads from being continuously fetched and discarded due to
  /// prefetching.
  ///
  /// [maxSize] is best effort, not a guarantee. In practice, if [maxSize] is
  /// many times [pageSize], the number of items held by [PagingData] will not
  /// grow above this number.
  ///
  /// Exceptions are made as necessary to guarantee:
  ///  * Pages are never dropped until there are more than two pages loaded.
  ///  Note that a [PagingSource] may not be held strictly to [pageSize], so
  /// two pages may be larger than expected.
  final int? maxSize;
}
