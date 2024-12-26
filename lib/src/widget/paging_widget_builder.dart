import 'package:flutter/material.dart';

import 'package:super_paging/src/load_state.dart';
import 'package:super_paging/src/load_type.dart';
import 'package:super_paging/src/pager.dart';
import 'package:super_paging/src/paging_state.dart';
import 'package:super_paging/src/widget/common.dart';

class PagingWidgetBuilder<Key, Value> extends StatefulWidget {
  const PagingWidgetBuilder({
    super.key,
    required this.pager,
    required this.emptyBuilder,
    required this.errorBuilder,
    required this.loadingBuilder,
    required this.pageListBuilder,
  });

  /// The [PagedValueNotifier] used to control the list of items.
  final Pager<Key, Value> pager;

  /// A builder that is called to build the empty state of the list.
  final PagingStateEmptyBuilder emptyBuilder;

  /// A builder that is called to build the error state of the list.
  final PagingStateErrorBuilder errorBuilder;

  /// A builder that is called to build the loading state of the list.
  final PagingStateLoadingBuilder loadingBuilder;

  /// A builder that is called to build the pages of the list.
  final PageListBuilder<Key, Value> pageListBuilder;

  @override
  State<PagingWidgetBuilder> createState() =>
      _PagingWidgetBuilderState<Key, Value>();
}

class _PagingWidgetBuilderState<Key, Value>
    extends State<PagingWidgetBuilder<Key, Value>> {
  Pager<Key, Value> get pager => widget.pager;

  void _loadInitialIfRequired() {
    final refreshState = pager.value.refreshLoadState;
    if (refreshState is NotLoading) {
      // If the load is already completed, we don't have to call it again.
      if (refreshState.endOfPaginationReached) return;

      // Otherwise, do initial load.
      pager.load(LoadType.refresh);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialIfRequired();
  }

  @override
  void didUpdateWidget(covariant PagingWidgetBuilder<Key, Value> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pager != widget.pager) {
      _loadInitialIfRequired();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pager,
      builder: (context, state, child) {
        // All the loaded pages.
        final pages = state.pages;

        // Handle the refresh state.
        // The refresh state is the state of the first page.
        final refreshState = state.refreshLoadState;
        return refreshState.when(
          error: (error) => widget.errorBuilder.call(context, error),
          loading: () {
            // We are only going to show the loading widget if there are no
            // pages.
            if (pages.isListEmpty) return widget.loadingBuilder.call(context);

            // Otherwise, we are going to build our list of pages.
            return widget.pageListBuilder(
              context,
              pages,
              state.prependLoadState,
              state.appendLoadState,
            );
          },
          notLoading: (_) {
            // If there are no pages, we are going to show the empty widget.
            if (pages.isListEmpty) return widget.emptyBuilder.call(context);

            // Otherwise, we are going to build our list of pages.
            return widget.pageListBuilder(
              context,
              pages,
              state.prependLoadState,
              state.appendLoadState,
            );
          },
        );
      },
    );
  }
}
