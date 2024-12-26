import 'package:flutter/widgets.dart';
import 'package:super_paging/src/pager.dart';
import 'package:super_paging/src/widget/common.dart';
import 'package:super_paging/src/widget/paging_sliver_list.dart';

/// A Flutter widget that represents a paginated list, capable of displaying
/// various states such as loading, error, empty, and the actual list of items.
///
/// It is designed to work with the [Pager] for efficient pagination and
/// state management.
///
/// see also:
///
///  * [PagingSliverList], which is the sliver version of this widget.
class PagingListView<Key, Value> extends BoxScrollView {
  PagingListView({
    super.key,
    required this.pager,
    required this.itemBuilder,
    required this.emptyBuilder,
    required this.errorBuilder,
    required this.loadingBuilder,
    this.appendStateBuilder = defaultAppendStateBuilder,
    this.prependStateBuilder = defaultPrependStateBuilder,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : separatorBuilder = null,
        assert(
          pager.config.maxSize == null,
          'PagingListView does not support maxSize',
        );

  PagingListView.separated({
    super.key,
    required this.pager,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.emptyBuilder,
    required this.errorBuilder,
    required this.loadingBuilder,
    this.appendStateBuilder = defaultAppendStateBuilder,
    this.prependStateBuilder = defaultPrependStateBuilder,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.padding,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  }) : assert(
          pager.config.maxSize == null,
          'PagingListView does not support maxSize',
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

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.findChildIndexCallback}
  final ChildIndexGetter? findChildIndexCallback;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addAutomaticKeepAlives}
  final bool addAutomaticKeepAlives;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addRepaintBoundaries}
  final bool addRepaintBoundaries;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addSemanticIndexes}
  final bool addSemanticIndexes;

  @override
  Widget buildChildLayout(BuildContext context) {
    if (separatorBuilder != null) {
      return PagingSliverList.separated(
        pager: pager,
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        emptyBuilder: emptyBuilder,
        errorBuilder: errorBuilder,
        loadingBuilder: loadingBuilder,
        appendStateBuilder: appendStateBuilder,
        prependStateBuilder: prependStateBuilder,
        findChildIndexCallback: findChildIndexCallback,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      );
    }

    return PagingSliverList(
      pager: pager,
      itemBuilder: itemBuilder,
      emptyBuilder: emptyBuilder,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
      appendStateBuilder: appendStateBuilder,
      prependStateBuilder: prependStateBuilder,
      findChildIndexCallback: findChildIndexCallback,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );
  }
}
