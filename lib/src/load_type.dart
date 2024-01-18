/// Type of load a [SuperPager] can trigger a [PageFetcher] to perform.
///
/// [LoadState] of any [LoadType] may be observed for UI purposes by registering
/// a listener via [SuperPager.addListener].
enum LoadType {
  /// [SuperPager] content being refreshed, which can be a result of refresh
  /// that may contain content updates, or the initial load.
  refresh,

  /// Load at the start of a [SuperPager].
  prepend,

  /// Load at the end of a [SuperPager].
  append,
}
