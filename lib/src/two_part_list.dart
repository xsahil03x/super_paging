import 'dart:collection';
import 'dart:math' show Random;

/// A Unmodifiable list that combines two separate lists, one for top elements
/// and one for bottom elements.
///
/// The top list is accessed first, followed by the bottom list.
///
/// ```dart
/// final numbers = TwoPartList(
///  top: [10, 20, 30],
///  bottom: [40, 50],
///  );
///
/// print(numbers); // [10, 20, 30, 40, 50]
/// ```
class TwoPartList<E> extends UnmodifiableListBase<E> {
  /// Creates a new instance of [TwoPartList] with optional top and bottom lists.
  ///
  /// The [top] and [bottom] lists default to empty lists if not provided.
  const TwoPartList({
    Iterable<E> top = const [],
    Iterable<E> bottom = const [],
  })  : _top = top,
        _bottom = bottom;

  /// Creates a empty instance of [TwoPartList].
  const factory TwoPartList.empty() = TwoPartList;

  /// Returns an unmodifiable view of the top list.
  List<E> get top => List.unmodifiable(_top);
  final Iterable<E> _top;

  /// Returns an unmodifiable view of the bottom list.
  List<E> get bottom => List.unmodifiable(_bottom);
  final Iterable<E> _bottom;

  @override
  Iterator<E> get iterator {
    if (_top.isEmpty) return _bottom.iterator;
    if (_bottom.isEmpty) return _top.iterator;
    return _top.followedBy(_bottom).iterator;
  }

  @override
  int get length => _top.length + _bottom.length;

  @override
  E operator [](int index) {
    if (index < _top.length) return _top.elementAt(index);
    return _bottom.elementAt(index - _top.length);
  }
}

/// Abstract implementation of an unmodifiable list.
///
/// All operations are defined in terms of `length` and `operator[]`,
/// which need to be implemented.
abstract class UnmodifiableListBase<E> = ListBase<E>
    with UnmodifiableListMixin<E>;

/// Mixin for an unmodifiable [List] class.
///
/// This overrides all mutating methods with methods that throw.
/// This mixin is intended to be mixed in on top of [ListMixin] on
/// unmodifiable lists.
mixin UnmodifiableListMixin<E> implements List<E> {
  @override
  void operator []=(int index, E value) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot change the length of an unmodifiable list');
  }

  @override
  set first(E element) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  set last(E element) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  void setAll(int at, Iterable<E> iterable) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  void add(E value) {
    throw UnsupportedError('Cannot add to an unmodifiable list');
  }

  @override
  void insert(int index, E element) {
    throw UnsupportedError('Cannot insert into an unmodifiable list');
  }

  @override
  void insertAll(int at, Iterable<E> iterable) {
    throw UnsupportedError('Cannot insert into an unmodifiable list');
  }

  @override
  void addAll(Iterable<E> iterable) {
    throw UnsupportedError('Cannot add to an unmodifiable list');
  }

  @override
  bool remove(Object? element) {
    throw UnsupportedError('Cannot remove from an unmodifiable list');
  }

  @override
  void removeWhere(bool Function(E element) test) {
    throw UnsupportedError('Cannot remove from an unmodifiable list');
  }

  @override
  void retainWhere(bool Function(E element) test) {
    throw UnsupportedError('Cannot remove from an unmodifiable list');
  }

  @override
  void sort([Comparator<E>? compare]) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  void shuffle([Random? random]) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  void clear() {
    throw UnsupportedError('Cannot clear an unmodifiable list');
  }

  @override
  E removeAt(int index) {
    throw UnsupportedError('Cannot remove from an unmodifiable list');
  }

  @override
  E removeLast() {
    throw UnsupportedError('Cannot remove from an unmodifiable list');
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  void removeRange(int start, int end) {
    throw UnsupportedError('Cannot remove from an unmodifiable list');
  }

  @override
  void replaceRange(int start, int end, Iterable<E> iterable) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    throw UnsupportedError('Cannot modify an unmodifiable list');
  }
}
