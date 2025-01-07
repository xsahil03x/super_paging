import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_position.freezed.dart';

@freezed
class ItemPosition with _$ItemPosition {
  const factory ItemPosition({
    /// Index of the item.
    required int index,

    /// Distance in proportion of the viewport's main axis length from the
    /// leading edge of the viewport to the leading edge of the item.
    ///
    /// Note: It may be negative if the item is partially visible.
    required double itemLeadingEdge,

    /// Distance in proportion of the viewport's main axis length from the
    /// leading edge of the viewport to the trailing edge of the item.
    ///
    /// Note: It may be greater than one if the item is partially visible.
    required double itemTrailingEdge,
  }) = _ItemPosition;
}

extension ItemPositionX on Set<ItemPosition> {
  /// Gets the top item in the viewport.
  ItemPosition? get topItem {
    if (isEmpty) return null;

    return where((it) => it.itemTrailingEdge > 0).reduce(
      (min, it) => it.itemTrailingEdge < min.itemTrailingEdge ? it : min,
    );
  }

  /// Gets the bottom item in the viewport.
  ItemPosition? get bottomItem {
    if (isEmpty) return null;

    return where((it) => it.itemLeadingEdge < 1).reduce(
      (max, it) => it.itemLeadingEdge > max.itemLeadingEdge ? it : max,
    );
  }

  /// Checks if an item at the given [index] is at least partially visible in
  /// the viewport.
  ///
  /// If [fullyVisible] is true, it checks if the item is fully visible.
  bool isItemVisible({
    required int index,
    bool fullyVisible = false,
  }) {
    final item = firstWhereOrNull((it) => it.index == index);
    if (item == null) return false; // Item not found.

    if (fullyVisible) {
      return item.itemLeadingEdge >= 0 && item.itemTrailingEdge <= 1;
    }

    return item.itemTrailingEdge > 0 && item.itemLeadingEdge < 1;
  }
}
