import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:super_paging/src/load_state.dart';
import 'package:super_paging/src/load_type.dart';
import 'package:super_paging/src/paging_source.dart';
import 'package:super_paging/src/paging_state.dart';
import 'package:super_paging/src/pager.dart';

import 'common.dart';

/// A Flutter widget that represents a bidirectional paginated list view,
/// capable of displaying various states such as loading, error, empty, and
/// the actual list of items.
///
/// It supports lazy loading in both directions (prepend and append)
/// simultaneously.
///
/// This widget works seamlessly with the [Pager] for efficient pagination
/// and state management.
///
/// see also:
///
///  * [PagingListView], which is the unidirectional version of this widget.
class BidirectionalPagingListView<Key, Value> extends StatefulWidget {
  BidirectionalPagingListView({
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
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.padding,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  })  : separatorBuilder = null,
        assert(
          pager.config.maxSize == null,
          'BidirectionalPagingListView does not support maxSize',
        );

  BidirectionalPagingListView.separated({
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
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.padding,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  }) : assert(
          pager.config.maxSize == null,
          'BidirectionalPagingListView does not support maxSize',
        );

  /// The [PagedValueNotifier] used to control the list of items.
  final Pager<Key, Value> pager;

  /// A builder that is called to build items in the ListView.
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

  /// {@macro flutter.widgets.scroll_view.scrollDirection}
  final Axis scrollDirection;

  /// {@macro flutter.widgets.scroll_view.reverse}
  final bool reverse;

  /// {@macro flutter.widgets.scroll_view.controller}
  final ScrollController? controller;

  /// {@macro flutter.widgets.scroll_view.primary}
  final bool? primary;

  /// {@macro flutter.widgets.scroll_view.physics}
  ///
  /// If an explicit [ScrollBehavior] is provided to [scrollBehavior], the
  /// [ScrollPhysics] provided by that behavior will take precedence after
  /// [physics].
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.shadow.scrollBehavior}
  ///
  /// [ScrollBehavior]s also provide [ScrollPhysics]. If an explicit
  /// [ScrollPhysics] is provided in [physics], it will take precedence,
  /// followed by [scrollBehavior], and then the inherited ancestor
  /// [ScrollBehavior].
  final ScrollBehavior? scrollBehavior;

  /// The amount of space by which to inset the children.
  final EdgeInsets? padding;

  /// {@macro flutter.rendering.RenderViewportBase.cacheExtent}
  final double? cacheExtent;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.scroll_view.keyboardDismissBehavior}
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.findChildIndexCallback}
  final ChildIndexGetter? findChildIndexCallback;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addAutomaticKeepAlives}
  final bool addAutomaticKeepAlives;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addRepaintBoundaries}
  final bool addRepaintBoundaries;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addSemanticIndexes}
  final bool addSemanticIndexes;

  @override
  State<BidirectionalPagingListView<Key, Value>> createState() =>
      _BidirectionalPagingListViewState<Key, Value>();
}

class _BidirectionalPagingListViewState<Key, Value> extends State<BidirectionalPagingListView<Key, Value>> {
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
  void didUpdateWidget(covariant BidirectionalPagingListView<Key, Value> oldWidget) {
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
            return Center(child: errorWidget);
          },
          loading: () {
            // We are only going to show the loading widget if there are no pages.
            if (pages.isListEmpty) {
              final loadingWidget = widget.loadingBuilder.call(context);
              return Center(child: loadingWidget);
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
              return Center(child: emptyWidget);
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

  EdgeInsets get _effectivePadding => widget.padding ?? EdgeInsets.zero;

  EdgeInsets get _leadingSliverPadding => switch (widget.scrollDirection) {
        Axis.vertical => _effectivePadding.copyWith(
            bottom: widget.reverse ? _effectivePadding.bottom : 0,
            top: widget.reverse ? 0 : _effectivePadding.top,
          ),
        Axis.horizontal => _effectivePadding.copyWith(
            right: widget.reverse ? _effectivePadding.right : 0,
            left: widget.reverse ? 0 : _effectivePadding.left,
          ),
      };

  EdgeInsets get _centerSliverPadding => switch (widget.scrollDirection) {
        Axis.vertical => _effectivePadding.copyWith(top: 0, bottom: 0),
        Axis.horizontal => _effectivePadding.copyWith(right: 0, left: 0),
      };

  EdgeInsets get _trailingSliverPadding => switch (widget.scrollDirection) {
        Axis.vertical => _effectivePadding.copyWith(
            top: widget.reverse ? _effectivePadding.top : 0,
            bottom: widget.reverse ? 0 : _effectivePadding.bottom,
          ),
        Axis.horizontal => _effectivePadding.copyWith(
            left: widget.reverse ? _effectivePadding.left : 0,
            right: widget.reverse ? 0 : _effectivePadding.right,
          ),
      };

  Widget _buildPageList(
    BuildContext context, {
    required PagingList<LoadResultPage<Key, Value>> pages,
    required LoadState prependLoadState,
    required LoadState appendLoadState,
  }) {
    const centerKey = ValueKey('bottom-paging-sliver-list');

    final topPages = pages.top;
    final bottomPages = pages.bottom;

    return CustomScrollView(
      center: centerKey,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      scrollBehavior: widget.scrollBehavior,
      // TODO: Add support for shrinkWrap
      shrinkWrap: false,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: pages.items.length,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      slivers: <Widget>[
        ...{
          // Handle prepend load state.
          SliverPadding(
            padding: _leadingSliverPadding,
            sliver: SliverToBoxAdapter(
              child: widget.prependStateBuilder.call(
                context,
                prependLoadState,
                pager,
              ),
            ),
          ),

          SliverPadding(
            padding: _centerSliverPadding,
            sliver: SliverToBoxAdapter(
              child: widget.headerBuilder?.call(context),
            ),
          ),

          SliverPadding(
            padding: _centerSliverPadding,
            sliver: SliverList(
              delegate: _createDelegate(
                topPages,
                reverse: true,
                onBuildingPrependLoadTriggerItem: () {
                  // Schedules the request for the end of this frame.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pager.load(LoadType.prepend);
                  });
                },
                onBuildingAppendLoadTriggerItem: () {
                  // If the bottom list contain items, we don't need to handle append here.
                  if (!bottomPages.isListEmpty) return;

                  // Schedules the request for the end of this frame.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pager.load(LoadType.append);
                  });
                },
              ),
            ),
          ),

          SliverPadding(
            key: centerKey,
            padding: _centerSliverPadding,
            sliver: SliverList(
              delegate: _createDelegate(
                bottomPages,
                onBuildingPrependLoadTriggerItem: () {
                  // If the top list contain items, we don't need to handle prepend here.
                  if (!topPages.isListEmpty) return;

                  // Schedules the request for the end of this frame.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pager.load(LoadType.prepend);
                  });
                },
                onBuildingAppendLoadTriggerItem: () {
                  // Schedules the request for the end of this frame.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pager.load(LoadType.append);
                  });
                },
              ),
            ),
          ),

          SliverPadding(
            padding: _centerSliverPadding,
            sliver: SliverToBoxAdapter(
              child: widget.footerBuilder?.call(context),
            ),
          ),

          // Handle append load state.
          SliverPadding(
            padding: _trailingSliverPadding,
            sliver: SliverToBoxAdapter(
              child: widget.appendStateBuilder.call(
                context,
                appendLoadState,
                pager,
              ),
            ),
          ),
        }.whereType(), // Remove nulls.
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (widget.addSemanticIndexes) {
      return IndexedSemantics(
        index: index,
        child: widget.itemBuilder(context, index),
      );
    }

    return widget.itemBuilder(context, index);
  }

  SliverChildBuilderDelegate _createDelegate(
    List<LoadResultPage<Key, Value>> pages, {
    bool reverse = false,
    VoidCallback? onBuildingPrependLoadTriggerItem,
    VoidCallback? onBuildingAppendLoadTriggerItem,
  }) {
    final items = pages.items;
    final itemCount = items.length;
    final prefetchIndex = pager.config.prefetchIndex;

    // Helper function to generate prepend and append load trigger notifications
    void generatePrependAppendLoadTriggerNotification(int index) {
      // If there is no prefetch index, we don't need to generate any notifications.
      if (prefetchIndex == null) return;

      // Check if the index is near the edge of the list based on the prefetch index and the direction of the list.
      final (shouldPrependItems, shouldAppendItems) = switch (reverse) {
        true => (index >= itemCount - prefetchIndex, index <= prefetchIndex),
        false => (index <= prefetchIndex, index >= itemCount - prefetchIndex),
      };

      // Generate notifications.
      if (shouldPrependItems) onBuildingPrependLoadTriggerItem?.call();
      if (shouldAppendItems) onBuildingAppendLoadTriggerItem?.call();
    }

    final separatorBuilder = widget.separatorBuilder;
    if (separatorBuilder != null) {
      return SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          final actualIndex = reverse
              ? itemCount - itemIndex - 1
              // Start after the top list.
              : pager.value.pages.top.itemCount + itemIndex;

          if (reverse ? index.isOdd : index.isEven) {
            // Generate prepend and append notification.
            generatePrependAppendLoadTriggerNotification(itemIndex);

            return _buildItem(context, actualIndex);
          }

          return separatorBuilder(context, actualIndex);
        },
        childCount: reverse ? itemCount * 2 : itemCount * 2 - 1,
        findChildIndexCallback: widget.findChildIndexCallback,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: false,
      );
    }

    return SliverChildBuilderDelegate(
      (context, index) {
        final actualIndex = reverse
            ? itemCount - index - 1
            : pager.value.pages.top.itemCount + index;

        // Generate prepend and append notification.
        generatePrependAppendLoadTriggerNotification(index);
        return _buildItem(context, actualIndex);
      },
      childCount: itemCount,
      findChildIndexCallback: widget.findChildIndexCallback,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: false,
    );
  }
}
