/// Type of load a [Pager] can trigger a [PageFetcher] to perform.
///
/// [LoadState] of any [LoadType] may be observed for UI purposes by registering
/// a listener via [Pager.addListener].
enum LoadType {
  /// [Pager] content being refreshed, which can be a result of refresh
  /// that may contain content updates, or the initial load.
  refresh,

  /// Load at the start of a [Pager].
  prepend,

  /// Load at the end of a [Pager].
  append,
}
