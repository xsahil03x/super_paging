import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:super_paging/src/load_state.dart';
import 'package:super_paging/src/load_type.dart';
import 'package:super_paging/src/paging_source.dart';
import 'package:super_paging/src/paging_state.dart';
import 'package:super_paging/src/pager.dart';
import 'package:super_paging/src/widget/common.dart';
import 'package:super_paging/src/widget/paging_widget_builder.dart';

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
class BidirectionalPagingListView<Key, Value> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return PagingWidgetBuilder(
      pager: pager,
      pageListBuilder: _buildPageList,
      emptyBuilder: (context) {
        final emptyWidget = emptyBuilder.call(context);
        return Center(child: emptyWidget);
      },
      errorBuilder: (context, error) {
        final errorWidget = errorBuilder.call(context, error);
        return Center(child: errorWidget);
      },
      loadingBuilder: (context) {
        final loadingWidget = loadingBuilder.call(context);
        return Center(child: loadingWidget);
      },
    );
  }

  EdgeInsets get _effectivePadding => padding ?? EdgeInsets.zero;

  EdgeInsets get _leadingSliverPadding => switch (scrollDirection) {
        Axis.vertical => _effectivePadding.copyWith(
            bottom: reverse ? _effectivePadding.bottom : 0,
            top: reverse ? 0 : _effectivePadding.top,
          ),
        Axis.horizontal => _effectivePadding.copyWith(
            right: reverse ? _effectivePadding.right : 0,
            left: reverse ? 0 : _effectivePadding.left,
          ),
      };

  EdgeInsets get _centerSliverPadding => switch (scrollDirection) {
        Axis.vertical => _effectivePadding.copyWith(top: 0, bottom: 0),
        Axis.horizontal => _effectivePadding.copyWith(right: 0, left: 0),
      };

  EdgeInsets get _trailingSliverPadding => switch (scrollDirection) {
        Axis.vertical => _effectivePadding.copyWith(
            top: reverse ? _effectivePadding.top : 0,
            bottom: reverse ? 0 : _effectivePadding.bottom,
          ),
        Axis.horizontal => _effectivePadding.copyWith(
            left: reverse ? _effectivePadding.left : 0,
            right: reverse ? 0 : _effectivePadding.right,
          ),
      };

  Widget _buildPageList(
    BuildContext context,
    PagingList<LoadResultPage<Key, Value>> pages,
    LoadState prependLoadState,
    LoadState appendLoadState,
  ) {
    const centerKey = ValueKey('bottom-paging-sliver-list');

    final topPages = pages.top;
    final bottomPages = pages.bottom;

    return CustomScrollView(
      center: centerKey,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      scrollBehavior: scrollBehavior,
      cacheExtent: cacheExtent,
      semanticChildCount: pages.items.length,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      slivers: <Widget>[
        ...{
          // Handle prepend load state.
          SliverPadding(
            padding: _leadingSliverPadding,
            sliver: SliverToBoxAdapter(
              child: prependStateBuilder.call(
                context,
                prependLoadState,
                pager.load,
                pager.retry,
              ),
            ),
          ),

          SliverPadding(
            padding: _centerSliverPadding,
            sliver: SliverToBoxAdapter(
              child: headerBuilder?.call(context),
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
                  // If the bottom list contain items, we don't need to handle
                  // append here.
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
                  // If the top list contain items, we don't need to handle
                  // prepend here.
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
              child: footerBuilder?.call(context),
            ),
          ),

          // Handle append load state.
          SliverPadding(
            padding: _trailingSliverPadding,
            sliver: SliverToBoxAdapter(
              child: appendStateBuilder.call(
                context,
                appendLoadState,
                pager.load,
                pager.retry,
              ),
            ),
          ),
        }.whereType(), // Remove nulls.
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (addSemanticIndexes) {
      return IndexedSemantics(
        index: index,
        child: itemBuilder(context, index),
      );
    }

    return itemBuilder(context, index);
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
      // If there is no prefetch index, we don't need to generate any
      // notifications.
      if (prefetchIndex == null) return;

      // Check if the index is near the edge of the list based on the prefetch
      // index and the direction of the list.
      final (shouldPrependItems, shouldAppendItems) = switch (reverse) {
        true => (index >= itemCount - prefetchIndex, index <= prefetchIndex),
        false => (index <= prefetchIndex, index >= itemCount - prefetchIndex),
      };

      // Generate notifications.
      if (shouldPrependItems) onBuildingPrependLoadTriggerItem?.call();
      if (shouldAppendItems) onBuildingAppendLoadTriggerItem?.call();
    }

    final separatorBuilder = this.separatorBuilder;
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
        findChildIndexCallback: findChildIndexCallback,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
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
      findChildIndexCallback: findChildIndexCallback,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: false,
    );
  }
}
