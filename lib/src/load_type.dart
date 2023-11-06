/// Type of load a [PagingData] can trigger a [PagingSource] to perform.
///
/// [LoadState] of any [LoadType] may be observed for UI purposes by registering a listener via
/// [androidx.paging.PagingDataAdapter.addLoadStateListener] or
/// [androidx.paging.AsyncPagingDataDiffer.addLoadStateListener].
enum LoadType {
  /// [PagingData] content being refreshed, which can be a result of refresh
  /// that may contain content updates, or the initial load.
  refresh,

  /// Load at the start of a [PagingData].
  prepend,

  /// Load at the end of a [PagingData].
  append,
}
