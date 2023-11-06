import 'package:freezed_annotation/freezed_annotation.dart';

part 'load_state.freezed.dart';

/// LoadState of a PagedList load - associated with a [LoadType]
///
/// [LoadState] of any [LoadType] may be observed for UI purposes by registering a listener via
/// [androidx.paging.PagingDataAdapter.addLoadStateListener] or
/// [androidx.paging.AsyncPagingDataDiffer.addLoadStateListener]
///
/// [endOfPaginationReached] `false` if there is more data to load in the [LoadType] this
/// [LoadState] is associated with, `true` otherwise. This parameter informs [Pager] if it
/// should continue to make requests for additional data in this direction or if it should
/// halt as the end of the dataset has been reached.
///
/// @see LoadType
@freezed
sealed class LoadState with _$LoadState {
  /// Indicates the [PagingData] is not currently loading, and no error currently observed.
  ///
  /// [endOfPaginationReached] `false` if there is more data to load in the [LoadType] this
  /// [LoadState] is associated with, `true` otherwise. This parameter informs [Pager] if it
  /// should continue to make requests for additional data in this direction or if it should
  /// halt as the end of the dataset has been reached.
  const factory LoadState.notLoading({
    required bool endOfPaginationReached,
  }) = NotLoading;

  static const notLoadingComplete = NotLoading(endOfPaginationReached: true);
  static const notLoadingIncomplete = NotLoading(endOfPaginationReached: false);

  /// Loading is in progress.
  const factory LoadState.loading() = Loading;

  /// Loading hit an error.
  ///
  /// @param error [Throwable] that caused the load operation to generate this error state.
  ///
  /// @see androidx.paging.PagedList.retry
  const factory LoadState.error([Object? error]) = Error;
}
