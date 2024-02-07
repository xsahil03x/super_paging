import 'package:flutter/widgets.dart';
import 'package:super_pager/super_pager.dart';

/// A Flutter widget that represents a paginated sliver list, capable of
/// displaying various states such as loading, error, empty, and the actual list
/// of items.
///
/// It is designed to work with the [SuperPager] for efficient pagination and
/// state management.
///
/// see also:
///
///  * <https://flutter.dev/docs/development/ui/advanced/slivers>, a description
///    of what slivers are and how to use them.
///  * [PagingListView], a list view version of this widget.
class PagingSliverList<Key, Value> extends StatefulWidget {
  const PagingSliverList({
    super.key,
    required this.pager,
    required this.itemBuilder,
    required this.emptyBuilder,
    required this.errorBuilder,
    required this.loadingBuilder,
    this.appendStateBuilder = defaultAppendStateBuilder,
    this.prependStateBuilder = defaultPrependStateBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : separatorBuilder = null;

  const PagingSliverList.separated({
    super.key,
    required this.pager,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.emptyBuilder,
    required this.errorBuilder,
    required this.loadingBuilder,
    this.appendStateBuilder = defaultAppendStateBuilder,
    this.prependStateBuilder = defaultPrependStateBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  /// The [PagedValueNotifier] used to control the list of items.
  final SuperPager<Key, Value> pager;

  /// A builder that is called to build items in the [ListView].
  final IndexedWidgetBuilder itemBuilder;

  /// A builder that is called to build the list separator.
  final IndexedWidgetBuilder? separatorBuilder;

  /// A builder that is called to build the empty state of the list.
  final PagingStateEmptyBuilder emptyBuilder;

  /// A builder that is called to build the error state of the list.
  final PagingStateErrorBuilder errorBuilder;

  /// A builder that is called to build the loading state of the list.
  final PagingStateLoadingBuilder loadingBuilder;

  /// A builder that is called to build the prepend state of the list.
  final PrependStateBuilder prependStateBuilder;

  /// A builder that is called to build the append state of the list.
  final AppendStateBuilder appendStateBuilder;

  /// A builder that is called to build the header of the list.
  final HeaderBuilder? headerBuilder;

  /// A builder that is called to build the footer of the list.
  final FooterBuilder? footerBuilder;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.findChildIndexCallback}
  final ChildIndexGetter? findChildIndexCallback;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addAutomaticKeepAlives}
  final bool addAutomaticKeepAlives;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addRepaintBoundaries}
  final bool addRepaintBoundaries;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addSemanticIndexes}
  final bool addSemanticIndexes;

  @override
  State<PagingSliverList<Key, Value>> createState() =>
      _PagingSliverListState<Key, Value>();
}

class _PagingSliverListState<Key, Value>
    extends State<PagingSliverList<Key, Value>> {
  SuperPager<Key, Value> get pager => widget.pager;

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
  void didUpdateWidget(covariant PagingSliverList<Key, Value> oldWidget) {
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
          error: (error) {
            final errorWidget = widget.errorBuilder.call(context, error);
            return SliverFillRemaining(child: errorWidget);
          },
          loading: () {
            // We are only going to show the loading widget if there are no
            // pages.
            if (pages.isListEmpty) {
              final loadingWidget = widget.loadingBuilder.call(context);
              return SliverFillRemaining(child: loadingWidget);
            }

            // Otherwise, we are going to build our list of pages.
            return _buildPageList(
              context,
              pages: pages,
              prependLoadState: state.prependLoadState,
              appendLoadState: state.appendLoadState,
            );
          },
          notLoading: (_) {
            // If there are no pages, we are going to show the empty widget.
            if (pages.isListEmpty) {
              final emptyWidget = widget.emptyBuilder.call(context);
              return SliverFillRemaining(child: emptyWidget);
            }

            // Otherwise, we are going to build our list of pages.
            return _buildPageList(
              context,
              pages: pages,
              prependLoadState: state.prependLoadState,
              appendLoadState: state.appendLoadState,
            );
          },
        );
      },
    );
  }

  Widget _buildPageList(
    BuildContext context, {
    required LoadState prependLoadState,
    required PagingList<LoadResultPage<Key, Value>> pages,
    required LoadState appendLoadState,
  }) {
    return SliverMainAxisGroup(
      slivers: [
        ...{
          // Handle prepend load state.
          SliverToBoxAdapter(
            child: widget.prependStateBuilder.call(
              context,
              prependLoadState,
              pager,
            ),
          ),

          SliverToBoxAdapter(
            child: widget.headerBuilder?.call(context),
          ),

          // Handle loaded pages.
          SliverList(
            delegate: _createDelegate(
              pages,
              onBuildingPrependLoadTriggerItem: () {
                final canMakeRequest = prependLoadState.maybeMap(
                  notLoading: (it) => !it.endOfPaginationReached,
                  orElse: () => false,
                );

                if (canMakeRequest) {
                  // Schedules the request for the end of this frame.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pager.load(LoadType.prepend);
                  });
                }
              },
              onBuildingAppendLoadTriggerItem: () {
                final canMakeRequest = appendLoadState.maybeMap(
                  notLoading: (it) => !it.endOfPaginationReached,
                  orElse: () => false,
                );

                if (canMakeRequest) {
                  // Schedules the request for the end of this frame.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pager.load(LoadType.append);
                  });
                }
              },
            ),
          ),

          SliverToBoxAdapter(
            child: widget.footerBuilder?.call(context),
          ),

          // Handle append load state.
          SliverToBoxAdapter(
            child: widget.appendStateBuilder.call(
              context,
              appendLoadState,
              pager,
            ),
          ),
        }.whereType(), // Remove nulls.
      ],
    );
  }

  SliverChildDelegate _createDelegate(
    List<LoadResultPage<Key, Value>> pages, {
    VoidCallback? onBuildingPrependLoadTriggerItem,
    VoidCallback? onBuildingAppendLoadTriggerItem,
  }) {
    final items = pages.items;
    final itemCount = items.length;
    final prefetchIndex = pager.config.prefetchIndex;

    void generatePrependAppendLoadTriggerNotification(int index) {
      // If there is no prefetch index, we don't have to generate any
      // notification.
      if (prefetchIndex == null) return;

      // Generate prepend notification.
      if (index == prefetchIndex) {
        onBuildingPrependLoadTriggerItem?.call();
      }

      // Generate append notification.
      if (index == itemCount - prefetchIndex) {
        onBuildingAppendLoadTriggerItem?.call();
      }
    }

    final itemBuilder = widget.itemBuilder;
    final separatorBuilder = widget.separatorBuilder;
    if (separatorBuilder != null) {
      return SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            // Generate prepend and append notification.
            generatePrependAppendLoadTriggerNotification(itemIndex);

            // Build items.
            return itemBuilder(context, itemIndex);
          }
          // Build separators.
          return separatorBuilder(context, itemIndex);
        },
        childCount: itemCount * 2 - 1,
        findChildIndexCallback: widget.findChildIndexCallback,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        semanticIndexCallback: (Widget widget, int index) {
          return index.isEven ? index ~/ 2 : null;
        },
      );
    }

    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        // Generate prepend and append notification.
        generatePrependAppendLoadTriggerNotification(index);

        // Build items.
        return itemBuilder(context, index);
      },
      childCount: itemCount,
      findChildIndexCallback: widget.findChildIndexCallback,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
    );
  }
}
