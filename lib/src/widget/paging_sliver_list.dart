import 'package:flutter/widgets.dart';
import 'package:super_paging/src/load_state.dart';
import 'package:super_paging/src/load_type.dart';
import 'package:super_paging/src/pager.dart';
import 'package:super_paging/src/paging_source.dart';
import 'package:super_paging/src/paging_state.dart';
import 'package:super_paging/src/widget/common.dart';
import 'package:super_paging/src/widget/paging_widget_builder.dart';

/// A Flutter widget that represents a paginated sliver list, capable of
/// displaying various states such as loading, error, empty, and the actual list
/// of items.
///
/// It is designed to work with the [Pager] for efficient pagination and
/// state management.
///
/// see also:
///
///  * <https://flutter.dev/docs/development/ui/advanced/slivers>, a description
///    of what slivers are and how to use them.
///  * [PagingListView], a list view version of this widget.
class PagingSliverList<Key, Value> extends StatelessWidget {
  PagingSliverList({
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
  })  : separatorBuilder = null,
        assert(
          pager.config.maxSize == null,
          'PagingSliverList does not support maxSize',
        );

  PagingSliverList.separated({
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
  }) : assert(
          pager.config.maxSize == null,
          'maxSize is not supported in sliver list',
        );

  /// The [PagedValueNotifier] used to control the list of items.
  final Pager<Key, Value> pager;

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
  Widget build(BuildContext context) {
    return PagingWidgetBuilder(
      pager: pager,
      pageListBuilder: _buildPageList,
      emptyBuilder: (context) {
        final emptyWidget = emptyBuilder.call(context);
        return SliverFillRemaining(child: emptyWidget);
      },
      errorBuilder: (context, error) {
        final errorWidget = errorBuilder.call(context, error);
        return SliverFillRemaining(child: errorWidget);
      },
      loadingBuilder: (context) {
        final loadingWidget = loadingBuilder.call(context);
        return SliverFillRemaining(child: loadingWidget);
      },
    );
  }

  Widget _buildPageList(
    BuildContext context,
    PagingList<LoadResultPage<Key, Value>> pages,
    LoadState prependLoadState,
    LoadState appendLoadState,
  ) {
    return SliverMainAxisGroup(
      slivers: [
        ...{
          // Handle prepend load state.
          SliverToBoxAdapter(
            child: prependStateBuilder.call(
              context,
              prependLoadState,
              pager.load,
              pager.retry,
            ),
          ),

          SliverToBoxAdapter(
            child: headerBuilder?.call(context),
          ),

          // Handle loaded pages.
          SliverList(
            delegate: _createDelegate(
              pages,
              onBuildingAppendLoadTriggerItem: () {
                // Schedules the request for the end of this frame.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  pager.load(LoadType.append);
                });
              },
            ),
          ),

          SliverToBoxAdapter(
            child: footerBuilder?.call(context),
          ),

          // Handle append load state.
          SliverToBoxAdapter(
            child: appendStateBuilder.call(
              context,
              appendLoadState,
              pager.load,
              pager.retry,
            ),
          ),
        }.whereType(), // Remove nulls.
      ],
    );
  }

  SliverChildDelegate _createDelegate(
    List<LoadResultPage<Key, Value>> pages, {
    VoidCallback? onBuildingAppendLoadTriggerItem,
  }) {
    final items = pages.items;
    final itemCount = items.length;
    final prefetchIndex = pager.config.prefetchIndex;

    // Helper function to generate prepend and append load trigger notifications
    void generateAppendLoadTriggerNotification(int index) {
      // If there is no prefetch index, we don't have to generate any
      // notification.
      if (prefetchIndex == null) return;

      // Check if the index is close to the end of the list based on the
      // prefetch index.
      final shouldAppendItems = index >= itemCount - prefetchIndex;

      // Generate notification.
      if (shouldAppendItems) onBuildingAppendLoadTriggerItem?.call();
    }

    final itemBuilder = this.itemBuilder;
    final separatorBuilder = this.separatorBuilder;
    if (separatorBuilder != null) {
      return SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            // Generate append notification.
            generateAppendLoadTriggerNotification(itemIndex);

            // Build items.
            return itemBuilder(context, itemIndex);
          }
          // Build separators.
          return separatorBuilder(context, itemIndex);
        },
        childCount: itemCount * 2 - 1,
        findChildIndexCallback: findChildIndexCallback,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        semanticIndexCallback: (Widget widget, int index) {
          return index.isEven ? index ~/ 2 : null;
        },
      );
    }

    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        // Generate append notification.
        generateAppendLoadTriggerNotification(index);

        // Build items.
        return itemBuilder(context, index);
      },
      childCount: itemCount,
      findChildIndexCallback: findChildIndexCallback,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );
  }
}
