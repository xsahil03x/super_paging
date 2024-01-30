// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoadParams<Key> {
  /// Key for the page to be loaded.
  ///
  /// [key] can be `null` only if this [LoadParams] is [Refresh], and either no `initialKey`
  /// is provided to the [Pager] or [PagingSource.getRefreshKey] from the previous
  /// [PagingSource] returns `null`.
  ///
  /// The value of [key] is dependent on the type of [LoadParams]:
  ///  * [Refresh]
  ///      * On initial load, the nullable `initialKey` passed to the [Pager].
  ///      * On subsequent loads due to invalidation or refresh, the result of
  ///      [PagingSource.getRefreshKey].
  ///  * [Prepend] - [LoadResult.Page.prevKey] of the loaded page at the front of the list.
  ///  * [Append] - [LoadResult.Page.nextKey] of the loaded page at the end of the list.
  Key? get key => throw _privateConstructorUsedError;
  int get loadSize => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Key? key, int loadSize) refresh,
    required TResult Function(Key key, int loadSize) append,
    required TResult Function(Key key, int loadSize) prepend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Key? key, int loadSize)? refresh,
    TResult? Function(Key key, int loadSize)? append,
    TResult? Function(Key key, int loadSize)? prepend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Key? key, int loadSize)? refresh,
    TResult Function(Key key, int loadSize)? append,
    TResult Function(Key key, int loadSize)? prepend,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Refresh<Key> value) refresh,
    required TResult Function(Append<Key> value) append,
    required TResult Function(Prepend<Key> value) prepend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Refresh<Key> value)? refresh,
    TResult? Function(Append<Key> value)? append,
    TResult? Function(Prepend<Key> value)? prepend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Refresh<Key> value)? refresh,
    TResult Function(Append<Key> value)? append,
    TResult Function(Prepend<Key> value)? prepend,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoadParamsCopyWith<Key, LoadParams<Key>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadParamsCopyWith<Key, $Res> {
  factory $LoadParamsCopyWith(
          LoadParams<Key> value, $Res Function(LoadParams<Key>) then) =
      _$LoadParamsCopyWithImpl<Key, $Res, LoadParams<Key>>;
  @useResult
  $Res call({int loadSize});
}

/// @nodoc
class _$LoadParamsCopyWithImpl<Key, $Res, $Val extends LoadParams<Key>>
    implements $LoadParamsCopyWith<Key, $Res> {
  _$LoadParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadSize = null,
  }) {
    return _then(_value.copyWith(
      loadSize: null == loadSize
          ? _value.loadSize
          : loadSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefreshImplCopyWith<Key, $Res>
    implements $LoadParamsCopyWith<Key, $Res> {
  factory _$$RefreshImplCopyWith(
          _$RefreshImpl<Key> value, $Res Function(_$RefreshImpl<Key>) then) =
      __$$RefreshImplCopyWithImpl<Key, $Res>;
  @override
  @useResult
  $Res call({Key? key, int loadSize});
}

/// @nodoc
class __$$RefreshImplCopyWithImpl<Key, $Res>
    extends _$LoadParamsCopyWithImpl<Key, $Res, _$RefreshImpl<Key>>
    implements _$$RefreshImplCopyWith<Key, $Res> {
  __$$RefreshImplCopyWithImpl(
      _$RefreshImpl<Key> _value, $Res Function(_$RefreshImpl<Key>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? loadSize = null,
  }) {
    return _then(_$RefreshImpl<Key>(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as Key?,
      loadSize: null == loadSize
          ? _value.loadSize
          : loadSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RefreshImpl<Key> with DiagnosticableTreeMixin implements Refresh<Key> {
  const _$RefreshImpl({this.key, required this.loadSize});

  /// Key for the page to be loaded.
  ///
  /// [key] can be `null` only if this [LoadParams] is [Refresh], and either no `initialKey`
  /// is provided to the [Pager] or [PagingSource.getRefreshKey] from the previous
  /// [PagingSource] returns `null`.
  ///
  /// The value of [key] is dependent on the type of [LoadParams]:
  ///  * [Refresh]
  ///      * On initial load, the nullable `initialKey` passed to the [Pager].
  ///      * On subsequent loads due to invalidation or refresh, the result of
  ///      [PagingSource.getRefreshKey].
  ///  * [Prepend] - [LoadResult.Page.prevKey] of the loaded page at the front of the list.
  ///  * [Append] - [LoadResult.Page.nextKey] of the loaded page at the end of the list.
  @override
  final Key? key;
  @override
  final int loadSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoadParams<$Key>.refresh(key: $key, loadSize: $loadSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoadParams<$Key>.refresh'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('loadSize', loadSize));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshImpl<Key> &&
            const DeepCollectionEquality().equals(other.key, key) &&
            (identical(other.loadSize, loadSize) ||
                other.loadSize == loadSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(key), loadSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshImplCopyWith<Key, _$RefreshImpl<Key>> get copyWith =>
      __$$RefreshImplCopyWithImpl<Key, _$RefreshImpl<Key>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Key? key, int loadSize) refresh,
    required TResult Function(Key key, int loadSize) append,
    required TResult Function(Key key, int loadSize) prepend,
  }) {
    return refresh(key, loadSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Key? key, int loadSize)? refresh,
    TResult? Function(Key key, int loadSize)? append,
    TResult? Function(Key key, int loadSize)? prepend,
  }) {
    return refresh?.call(key, loadSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Key? key, int loadSize)? refresh,
    TResult Function(Key key, int loadSize)? append,
    TResult Function(Key key, int loadSize)? prepend,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(key, loadSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Refresh<Key> value) refresh,
    required TResult Function(Append<Key> value) append,
    required TResult Function(Prepend<Key> value) prepend,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Refresh<Key> value)? refresh,
    TResult? Function(Append<Key> value)? append,
    TResult? Function(Prepend<Key> value)? prepend,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Refresh<Key> value)? refresh,
    TResult Function(Append<Key> value)? append,
    TResult Function(Prepend<Key> value)? prepend,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class Refresh<Key> implements LoadParams<Key> {
  const factory Refresh({final Key? key, required final int loadSize}) =
      _$RefreshImpl<Key>;

  @override

  /// Key for the page to be loaded.
  ///
  /// [key] can be `null` only if this [LoadParams] is [Refresh], and either no `initialKey`
  /// is provided to the [Pager] or [PagingSource.getRefreshKey] from the previous
  /// [PagingSource] returns `null`.
  ///
  /// The value of [key] is dependent on the type of [LoadParams]:
  ///  * [Refresh]
  ///      * On initial load, the nullable `initialKey` passed to the [Pager].
  ///      * On subsequent loads due to invalidation or refresh, the result of
  ///      [PagingSource.getRefreshKey].
  ///  * [Prepend] - [LoadResult.Page.prevKey] of the loaded page at the front of the list.
  ///  * [Append] - [LoadResult.Page.nextKey] of the loaded page at the end of the list.
  Key? get key;
  @override
  int get loadSize;
  @override
  @JsonKey(ignore: true)
  _$$RefreshImplCopyWith<Key, _$RefreshImpl<Key>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppendImplCopyWith<Key, $Res>
    implements $LoadParamsCopyWith<Key, $Res> {
  factory _$$AppendImplCopyWith(
          _$AppendImpl<Key> value, $Res Function(_$AppendImpl<Key>) then) =
      __$$AppendImplCopyWithImpl<Key, $Res>;
  @override
  @useResult
  $Res call({Key key, int loadSize});
}

/// @nodoc
class __$$AppendImplCopyWithImpl<Key, $Res>
    extends _$LoadParamsCopyWithImpl<Key, $Res, _$AppendImpl<Key>>
    implements _$$AppendImplCopyWith<Key, $Res> {
  __$$AppendImplCopyWithImpl(
      _$AppendImpl<Key> _value, $Res Function(_$AppendImpl<Key>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? loadSize = null,
  }) {
    return _then(_$AppendImpl<Key>(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as Key,
      loadSize: null == loadSize
          ? _value.loadSize
          : loadSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AppendImpl<Key> with DiagnosticableTreeMixin implements Append<Key> {
  const _$AppendImpl({required this.key, required this.loadSize});

  @override
  final Key key;
  @override
  final int loadSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoadParams<$Key>.append(key: $key, loadSize: $loadSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoadParams<$Key>.append'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('loadSize', loadSize));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppendImpl<Key> &&
            const DeepCollectionEquality().equals(other.key, key) &&
            (identical(other.loadSize, loadSize) ||
                other.loadSize == loadSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(key), loadSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppendImplCopyWith<Key, _$AppendImpl<Key>> get copyWith =>
      __$$AppendImplCopyWithImpl<Key, _$AppendImpl<Key>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Key? key, int loadSize) refresh,
    required TResult Function(Key key, int loadSize) append,
    required TResult Function(Key key, int loadSize) prepend,
  }) {
    return append(key, loadSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Key? key, int loadSize)? refresh,
    TResult? Function(Key key, int loadSize)? append,
    TResult? Function(Key key, int loadSize)? prepend,
  }) {
    return append?.call(key, loadSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Key? key, int loadSize)? refresh,
    TResult Function(Key key, int loadSize)? append,
    TResult Function(Key key, int loadSize)? prepend,
    required TResult orElse(),
  }) {
    if (append != null) {
      return append(key, loadSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Refresh<Key> value) refresh,
    required TResult Function(Append<Key> value) append,
    required TResult Function(Prepend<Key> value) prepend,
  }) {
    return append(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Refresh<Key> value)? refresh,
    TResult? Function(Append<Key> value)? append,
    TResult? Function(Prepend<Key> value)? prepend,
  }) {
    return append?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Refresh<Key> value)? refresh,
    TResult Function(Append<Key> value)? append,
    TResult Function(Prepend<Key> value)? prepend,
    required TResult orElse(),
  }) {
    if (append != null) {
      return append(this);
    }
    return orElse();
  }
}

abstract class Append<Key> implements LoadParams<Key> {
  const factory Append({required final Key key, required final int loadSize}) =
      _$AppendImpl<Key>;

  @override
  Key get key;
  @override
  int get loadSize;
  @override
  @JsonKey(ignore: true)
  _$$AppendImplCopyWith<Key, _$AppendImpl<Key>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PrependImplCopyWith<Key, $Res>
    implements $LoadParamsCopyWith<Key, $Res> {
  factory _$$PrependImplCopyWith(
          _$PrependImpl<Key> value, $Res Function(_$PrependImpl<Key>) then) =
      __$$PrependImplCopyWithImpl<Key, $Res>;
  @override
  @useResult
  $Res call({Key key, int loadSize});
}

/// @nodoc
class __$$PrependImplCopyWithImpl<Key, $Res>
    extends _$LoadParamsCopyWithImpl<Key, $Res, _$PrependImpl<Key>>
    implements _$$PrependImplCopyWith<Key, $Res> {
  __$$PrependImplCopyWithImpl(
      _$PrependImpl<Key> _value, $Res Function(_$PrependImpl<Key>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? loadSize = null,
  }) {
    return _then(_$PrependImpl<Key>(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as Key,
      loadSize: null == loadSize
          ? _value.loadSize
          : loadSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PrependImpl<Key> with DiagnosticableTreeMixin implements Prepend<Key> {
  const _$PrependImpl({required this.key, required this.loadSize});

  @override
  final Key key;
  @override
  final int loadSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoadParams<$Key>.prepend(key: $key, loadSize: $loadSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoadParams<$Key>.prepend'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('loadSize', loadSize));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrependImpl<Key> &&
            const DeepCollectionEquality().equals(other.key, key) &&
            (identical(other.loadSize, loadSize) ||
                other.loadSize == loadSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(key), loadSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrependImplCopyWith<Key, _$PrependImpl<Key>> get copyWith =>
      __$$PrependImplCopyWithImpl<Key, _$PrependImpl<Key>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Key? key, int loadSize) refresh,
    required TResult Function(Key key, int loadSize) append,
    required TResult Function(Key key, int loadSize) prepend,
  }) {
    return prepend(key, loadSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Key? key, int loadSize)? refresh,
    TResult? Function(Key key, int loadSize)? append,
    TResult? Function(Key key, int loadSize)? prepend,
  }) {
    return prepend?.call(key, loadSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Key? key, int loadSize)? refresh,
    TResult Function(Key key, int loadSize)? append,
    TResult Function(Key key, int loadSize)? prepend,
    required TResult orElse(),
  }) {
    if (prepend != null) {
      return prepend(key, loadSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Refresh<Key> value) refresh,
    required TResult Function(Append<Key> value) append,
    required TResult Function(Prepend<Key> value) prepend,
  }) {
    return prepend(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Refresh<Key> value)? refresh,
    TResult? Function(Append<Key> value)? append,
    TResult? Function(Prepend<Key> value)? prepend,
  }) {
    return prepend?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Refresh<Key> value)? refresh,
    TResult Function(Append<Key> value)? append,
    TResult Function(Prepend<Key> value)? prepend,
    required TResult orElse(),
  }) {
    if (prepend != null) {
      return prepend(this);
    }
    return orElse();
  }
}

abstract class Prepend<Key> implements LoadParams<Key> {
  const factory Prepend({required final Key key, required final int loadSize}) =
      _$PrependImpl<Key>;

  @override
  Key get key;
  @override
  int get loadSize;
  @override
  @JsonKey(ignore: true)
  _$$PrependImplCopyWith<Key, _$PrependImpl<Key>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoadResult<Key, Value> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Value> items, Key? prevKey, Key? nextKey)
        page,
    required TResult Function(Object? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Value> items, Key? prevKey, Key? nextKey)? page,
    TResult? Function(Object? error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Value> items, Key? prevKey, Key? nextKey)? page,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadResultPage<Key, Value> value) page,
    required TResult Function(LoadResultError<Key, Value> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadResultPage<Key, Value> value)? page,
    TResult? Function(LoadResultError<Key, Value> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadResultPage<Key, Value> value)? page,
    TResult Function(LoadResultError<Key, Value> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadResultCopyWith<Key, Value, $Res> {
  factory $LoadResultCopyWith(LoadResult<Key, Value> value,
          $Res Function(LoadResult<Key, Value>) then) =
      _$LoadResultCopyWithImpl<Key, Value, $Res, LoadResult<Key, Value>>;
}

/// @nodoc
class _$LoadResultCopyWithImpl<Key, Value, $Res,
        $Val extends LoadResult<Key, Value>>
    implements $LoadResultCopyWith<Key, Value, $Res> {
  _$LoadResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadResultPageImplCopyWith<Key, Value, $Res> {
  factory _$$LoadResultPageImplCopyWith(_$LoadResultPageImpl<Key, Value> value,
          $Res Function(_$LoadResultPageImpl<Key, Value>) then) =
      __$$LoadResultPageImplCopyWithImpl<Key, Value, $Res>;
  @useResult
  $Res call({List<Value> items, Key? prevKey, Key? nextKey});
}

/// @nodoc
class __$$LoadResultPageImplCopyWithImpl<Key, Value, $Res>
    extends _$LoadResultCopyWithImpl<Key, Value, $Res,
        _$LoadResultPageImpl<Key, Value>>
    implements _$$LoadResultPageImplCopyWith<Key, Value, $Res> {
  __$$LoadResultPageImplCopyWithImpl(_$LoadResultPageImpl<Key, Value> _value,
      $Res Function(_$LoadResultPageImpl<Key, Value>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? prevKey = freezed,
    Object? nextKey = freezed,
  }) {
    return _then(_$LoadResultPageImpl<Key, Value>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Value>,
      prevKey: freezed == prevKey
          ? _value.prevKey
          : prevKey // ignore: cast_nullable_to_non_nullable
              as Key?,
      nextKey: freezed == nextKey
          ? _value.nextKey
          : nextKey // ignore: cast_nullable_to_non_nullable
              as Key?,
    ));
  }
}

/// @nodoc

class _$LoadResultPageImpl<Key, Value>
    with DiagnosticableTreeMixin
    implements LoadResultPage<Key, Value> {
  const _$LoadResultPageImpl(
      {required final List<Value> items, this.prevKey, this.nextKey})
      : _items = items;

  /// Loaded items.
  final List<Value> _items;

  /// Loaded items.
  @override
  List<Value> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// [Key] for previous page if more items can be loaded in that direction,
  /// `null` otherwise.
  @override
  final Key? prevKey;

  /// [Key] for next page if more items can be loaded in that direction,
  /// `null` otherwise.
  @override
  final Key? nextKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoadResult<$Key, $Value>.page(items: $items, prevKey: $prevKey, nextKey: $nextKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoadResult<$Key, $Value>.page'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('prevKey', prevKey))
      ..add(DiagnosticsProperty('nextKey', nextKey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadResultPageImpl<Key, Value> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other.prevKey, prevKey) &&
            const DeepCollectionEquality().equals(other.nextKey, nextKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(prevKey),
      const DeepCollectionEquality().hash(nextKey));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadResultPageImplCopyWith<Key, Value, _$LoadResultPageImpl<Key, Value>>
      get copyWith => __$$LoadResultPageImplCopyWithImpl<Key, Value,
          _$LoadResultPageImpl<Key, Value>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Value> items, Key? prevKey, Key? nextKey)
        page,
    required TResult Function(Object? error) error,
  }) {
    return page(items, prevKey, nextKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Value> items, Key? prevKey, Key? nextKey)? page,
    TResult? Function(Object? error)? error,
  }) {
    return page?.call(items, prevKey, nextKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Value> items, Key? prevKey, Key? nextKey)? page,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (page != null) {
      return page(items, prevKey, nextKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadResultPage<Key, Value> value) page,
    required TResult Function(LoadResultError<Key, Value> value) error,
  }) {
    return page(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadResultPage<Key, Value> value)? page,
    TResult? Function(LoadResultError<Key, Value> value)? error,
  }) {
    return page?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadResultPage<Key, Value> value)? page,
    TResult Function(LoadResultError<Key, Value> value)? error,
    required TResult orElse(),
  }) {
    if (page != null) {
      return page(this);
    }
    return orElse();
  }
}

abstract class LoadResultPage<Key, Value> implements LoadResult<Key, Value> {
  const factory LoadResultPage(
      {required final List<Value> items,
      final Key? prevKey,
      final Key? nextKey}) = _$LoadResultPageImpl<Key, Value>;

  /// Loaded items.
  List<Value> get items;

  /// [Key] for previous page if more items can be loaded in that direction,
  /// `null` otherwise.
  Key? get prevKey;

  /// [Key] for next page if more items can be loaded in that direction,
  /// `null` otherwise.
  Key? get nextKey;
  @JsonKey(ignore: true)
  _$$LoadResultPageImplCopyWith<Key, Value, _$LoadResultPageImpl<Key, Value>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadResultErrorImplCopyWith<Key, Value, $Res> {
  factory _$$LoadResultErrorImplCopyWith(
          _$LoadResultErrorImpl<Key, Value> value,
          $Res Function(_$LoadResultErrorImpl<Key, Value>) then) =
      __$$LoadResultErrorImplCopyWithImpl<Key, Value, $Res>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$LoadResultErrorImplCopyWithImpl<Key, Value, $Res>
    extends _$LoadResultCopyWithImpl<Key, Value, $Res,
        _$LoadResultErrorImpl<Key, Value>>
    implements _$$LoadResultErrorImplCopyWith<Key, Value, $Res> {
  __$$LoadResultErrorImplCopyWithImpl(_$LoadResultErrorImpl<Key, Value> _value,
      $Res Function(_$LoadResultErrorImpl<Key, Value>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$LoadResultErrorImpl<Key, Value>(
      freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$LoadResultErrorImpl<Key, Value>
    with DiagnosticableTreeMixin
    implements LoadResultError<Key, Value> {
  const _$LoadResultErrorImpl([this.error]);

  @override
  final Object? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoadResult<$Key, $Value>.error(error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoadResult<$Key, $Value>.error'))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadResultErrorImpl<Key, Value> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadResultErrorImplCopyWith<Key, Value, _$LoadResultErrorImpl<Key, Value>>
      get copyWith => __$$LoadResultErrorImplCopyWithImpl<Key, Value,
          _$LoadResultErrorImpl<Key, Value>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Value> items, Key? prevKey, Key? nextKey)
        page,
    required TResult Function(Object? error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Value> items, Key? prevKey, Key? nextKey)? page,
    TResult? Function(Object? error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Value> items, Key? prevKey, Key? nextKey)? page,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadResultPage<Key, Value> value) page,
    required TResult Function(LoadResultError<Key, Value> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadResultPage<Key, Value> value)? page,
    TResult? Function(LoadResultError<Key, Value> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadResultPage<Key, Value> value)? page,
    TResult Function(LoadResultError<Key, Value> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LoadResultError<Key, Value> implements LoadResult<Key, Value> {
  const factory LoadResultError([final Object? error]) =
      _$LoadResultErrorImpl<Key, Value>;

  Object? get error;
  @JsonKey(ignore: true)
  _$$LoadResultErrorImplCopyWith<Key, Value, _$LoadResultErrorImpl<Key, Value>>
      get copyWith => throw _privateConstructorUsedError;
}
