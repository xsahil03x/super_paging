import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:super_paging/src/widget/positions_notifier/indexed_key.dart';
import 'package:super_paging/src/widget/positions_notifier/item_position.dart';

/// A widget that listens to a [ScrollController] and notifies its parent
/// about the positions of its child items.
///
/// The [ItemPositionsNotifier] widget is useful for tracking the positions
/// of items in a scrollable list. It provides a callback that is triggered
/// whenever the positions of the items change.
///
/// The widget requires a [ScrollController] to listen to and a child widget
/// to display. The positions of the items are reported through the
/// [onPositionsChanged] callback.
///
/// Example usage:
///
/// ```dart
/// ItemPositionsNotifier(
///   controller: _scrollController,
///   onPositionsChanged: (positions) {
///     // Handle the positions of the items.
///   },
///   child: ListView.builder(
///     controller: _scrollController,
///     itemCount: 100,
///     itemBuilder: (context, index) {
///       return RegisteredElementWidget(
///         key: IndexedKey(index),
///         child: ListTile(
///           title: Text('Item $index'),
///         ),
///       );
///     },
///   ),
/// );
/// ```
///
/// See also:
///  * [ScrollController], which is used to control the scrolling of the list.
///  * [ItemPosition], which represents the position of an item in the list.
class ItemPositionsNotifier extends StatefulWidget {
  /// Creates an [ItemPositionsNotifier].
  ///
  /// The [controller] and [child] parameters must not be null.
  const ItemPositionsNotifier({
    super.key,
    required this.child,
    required this.controller,
    this.onPositionsChanged,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The [ScrollController] that this widget will listen to.
  final ScrollController controller;

  /// Optional callback that is called when the set of [ItemPosition]s
  /// changes.
  final ValueSetter<Set<ItemPosition>>? onPositionsChanged;

  @override
  State<ItemPositionsNotifier> createState() => _ItemPositionsNotifierState();
}

class _ItemPositionsNotifierState extends State<ItemPositionsNotifier> {
  final _elements = <Element>{};

  void register(Element element) {
    _elements.add(element);
    _schedulePositionNotificationUpdate();
  }

  void unregister(Element element) {
    _elements.remove(element);
    _schedulePositionNotificationUpdate();
  }

  bool _updateScheduled = false;
  void _schedulePositionNotificationUpdate() {
    if (_updateScheduled) return;
    _updateScheduled = true;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_elements.isNotEmpty) {
        final positions = <ItemPosition>{};
        for (final element in _elements) {
          final position = element.toItemPosition(widget.controller.position);
          if (position != null) {
            positions.add(position);
          }
        }

        widget.onPositionsChanged?.call(positions);
      }

      _updateScheduled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_schedulePositionNotificationUpdate);
    _schedulePositionNotificationUpdate();
  }

  @override
  void didUpdateWidget(covariant ItemPositionsNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      // Remove the listener from the old controller.
      oldWidget.controller.removeListener(_schedulePositionNotificationUpdate);

      // Attach the listener to the new controller.
      widget.controller.addListener(_schedulePositionNotificationUpdate);
      _schedulePositionNotificationUpdate();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_schedulePositionNotificationUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RegistryWidget(
      onElementMounted: register,
      onElementUnmounted: unregister,
      child: widget.child,
    );
  }
}

extension on Element {
  ItemPosition? toItemPosition(ScrollPosition scrollPosition) {
    // Only consider elements that have been laid out.
    if (renderObject case RenderBox box? when box.hasSize) {
      if (RenderAbstractViewport.of(box) case RenderViewportBase viewport) {
        final reveal = viewport.getOffsetToReveal(box, 0).offset;
        if (!reveal.isFinite) return null;

        final key = switch (widget.key) { IndexedKey key => key, _ => null };
        if (key == null) return null;

        final anchor = switch (viewport) {
          RenderViewport(anchor: final anchor) => anchor,
          _ => 0.0,
        };

        final itemOffset = reveal -
            viewport.offset.pixels +
            // Adjust for the viewport anchor:
            anchor * viewport.size.height;

        return ItemPosition(
          index: key.index,
          itemLeadingEdge: itemOffset / scrollPosition.viewportDimension,
          itemTrailingEdge:
              (itemOffset + box.size.height) / scrollPosition.viewportDimension,
        );
      }
    }

    return null;
  }
}

class _RegistryWidget extends InheritedWidget {
  const _RegistryWidget({
    this.onElementMounted,
    this.onElementUnmounted,
    required super.child,
  });

  static _RegistryWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RegistryWidget>();
  }

  final ValueSetter<Element>? onElementMounted;
  final ValueSetter<Element>? onElementUnmounted;

  @override
  bool updateShouldNotify(covariant _RegistryWidget oldWidget) => true;
}

/// A widget whose [Element] will be added its nearest ancestor
/// [ItemPositionsNotifier].
class RegisteredElementWidget extends ProxyWidget {
  /// Creates a [RegisteredElementWidget].
  const RegisteredElementWidget({super.key, required super.child});

  @override
  Element createElement() => _RegisteredElement(this);
}

class _RegisteredElement extends ProxyElement {
  _RegisteredElement(super.widget);

  @override
  void notifyClients(ProxyWidget oldWidget) {/* No-op */}

  _RegistryWidget? _registryWidget;

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    final inheritedRegistryWidget = _RegistryWidget.maybeOf(this);
    if (inheritedRegistryWidget == null) {
      throw FlutterError(
        'Could not find a RegistryWidget ancestor for $this. '
        'Make sure that the RegisteredElementWidget is a descendant of a '
        'RegistryWidget.',
      );
    }

    _registryWidget = inheritedRegistryWidget..onElementMounted?.call(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final inheritedRegistryWidget = _RegistryWidget.maybeOf(this);
    if (inheritedRegistryWidget == null) {
      throw FlutterError(
        'Could not find a RegistryWidget ancestor for $this. '
        'Make sure that the RegisteredElementWidget is a descendant of a '
        'RegistryWidget.',
      );
    }

    _registryWidget = inheritedRegistryWidget..onElementMounted?.call(this);
  }

  @override
  void unmount() {
    _registryWidget?.onElementUnmounted?.call(this);
    super.unmount();
  }
}
