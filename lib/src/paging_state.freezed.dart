// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PagingState<Key, Value> {
  /// List with all the pages loaded so far.
  PagingList<LoadResultPage<Key, Value>> get pages =>
      throw _privateConstructorUsedError;

  /// Load state of the initial page.
  LoadState get refreshLoadState => throw _privateConstructorUsedError;

  /// Load state of the previous page.
  LoadState get prependLoadState => throw _privateConstructorUsedError;

  /// Load state of the next page.
  LoadState get appendLoadState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PagingStateCopyWith<Key, Value, PagingState<Key, Value>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingStateCopyWith<Key, Value, $Res> {
  factory $PagingStateCopyWith(PagingState<Key, Value> value,
          $Res Function(PagingState<Key, Value>) then) =
      _$PagingStateCopyWithImpl<Key, Value, $Res, PagingState<Key, Value>>;
  @useResult
  $Res call(
      {PagingList<LoadResultPage<Key, Value>> pages,
      LoadState refreshLoadState,
      LoadState prependLoadState,
      LoadState appendLoadState});

  $LoadStateCopyWith<$Res> get refreshLoadState;
  $LoadStateCopyWith<$Res> get prependLoadState;
  $LoadStateCopyWith<$Res> get appendLoadState;
}

/// @nodoc
class _$PagingStateCopyWithImpl<Key, Value, $Res,
        $Val extends PagingState<Key, Value>>
    implements $PagingStateCopyWith<Key, Value, $Res> {
  _$PagingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
    Object? refreshLoadState = null,
    Object? prependLoadState = null,
    Object? appendLoadState = null,
  }) {
    return _then(_value.copyWith(
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as PagingList<LoadResultPage<Key, Value>>,
      refreshLoadState: null == refreshLoadState
          ? _value.refreshLoadState
          : refreshLoadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      prependLoadState: null == prependLoadState
          ? _value.prependLoadState
          : prependLoadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      appendLoadState: null == appendLoadState
          ? _value.appendLoadState
          : appendLoadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoadStateCopyWith<$Res> get refreshLoadState {
    return $LoadStateCopyWith<$Res>(_value.refreshLoadState, (value) {
      return _then(_value.copyWith(refreshLoadState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LoadStateCopyWith<$Res> get prependLoadState {
    return $LoadStateCopyWith<$Res>(_value.prependLoadState, (value) {
      return _then(_value.copyWith(prependLoadState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LoadStateCopyWith<$Res> get appendLoadState {
    return $LoadStateCopyWith<$Res>(_value.appendLoadState, (value) {
      return _then(_value.copyWith(appendLoadState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PagingStateImplCopyWith<Key, Value, $Res>
    implements $PagingStateCopyWith<Key, Value, $Res> {
  factory _$$PagingStateImplCopyWith(_$PagingStateImpl<Key, Value> value,
          $Res Function(_$PagingStateImpl<Key, Value>) then) =
      __$$PagingStateImplCopyWithImpl<Key, Value, $Res>;
  @override
  @useResult
  $Res call(
      {PagingList<LoadResultPage<Key, Value>> pages,
      LoadState refreshLoadState,
      LoadState prependLoadState,
      LoadState appendLoadState});

  @override
  $LoadStateCopyWith<$Res> get refreshLoadState;
  @override
  $LoadStateCopyWith<$Res> get prependLoadState;
  @override
  $LoadStateCopyWith<$Res> get appendLoadState;
}

/// @nodoc
class __$$PagingStateImplCopyWithImpl<Key, Value, $Res>
    extends _$PagingStateCopyWithImpl<Key, Value, $Res,
        _$PagingStateImpl<Key, Value>>
    implements _$$PagingStateImplCopyWith<Key, Value, $Res> {
  __$$PagingStateImplCopyWithImpl(_$PagingStateImpl<Key, Value> _value,
      $Res Function(_$PagingStateImpl<Key, Value>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
    Object? refreshLoadState = null,
    Object? prependLoadState = null,
    Object? appendLoadState = null,
  }) {
    return _then(_$PagingStateImpl<Key, Value>(
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as PagingList<LoadResultPage<Key, Value>>,
      refreshLoadState: null == refreshLoadState
          ? _value.refreshLoadState
          : refreshLoadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      prependLoadState: null == prependLoadState
          ? _value.prependLoadState
          : prependLoadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      appendLoadState: null == appendLoadState
          ? _value.appendLoadState
          : appendLoadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
    ));
  }
}

/// @nodoc

class _$PagingStateImpl<Key, Value> implements _PagingState<Key, Value> {
  const _$PagingStateImpl(
      {this.pages = const PagingList(),
      this.refreshLoadState = LoadState.notLoadingIncomplete,
      this.prependLoadState = LoadState.notLoadingIncomplete,
      this.appendLoadState = LoadState.notLoadingIncomplete});

  /// List with all the pages loaded so far.
  @override
  @JsonKey()
  final PagingList<LoadResultPage<Key, Value>> pages;

  /// Load state of the initial page.
  @override
  @JsonKey()
  final LoadState refreshLoadState;

  /// Load state of the previous page.
  @override
  @JsonKey()
  final LoadState prependLoadState;

  /// Load state of the next page.
  @override
  @JsonKey()
  final LoadState appendLoadState;

  @override
  String toString() {
    return 'PagingState<$Key, $Value>(pages: $pages, refreshLoadState: $refreshLoadState, prependLoadState: $prependLoadState, appendLoadState: $appendLoadState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingStateImpl<Key, Value> &&
            const DeepCollectionEquality().equals(other.pages, pages) &&
            (identical(other.refreshLoadState, refreshLoadState) ||
                other.refreshLoadState == refreshLoadState) &&
            (identical(other.prependLoadState, prependLoadState) ||
                other.prependLoadState == prependLoadState) &&
            (identical(other.appendLoadState, appendLoadState) ||
                other.appendLoadState == appendLoadState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pages),
      refreshLoadState,
      prependLoadState,
      appendLoadState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingStateImplCopyWith<Key, Value, _$PagingStateImpl<Key, Value>>
      get copyWith => __$$PagingStateImplCopyWithImpl<Key, Value,
          _$PagingStateImpl<Key, Value>>(this, _$identity);
}

abstract class _PagingState<Key, Value> implements PagingState<Key, Value> {
  const factory _PagingState(
      {final PagingList<LoadResultPage<Key, Value>> pages,
      final LoadState refreshLoadState,
      final LoadState prependLoadState,
      final LoadState appendLoadState}) = _$PagingStateImpl<Key, Value>;

  @override

  /// List with all the pages loaded so far.
  PagingList<LoadResultPage<Key, Value>> get pages;
  @override

  /// Load state of the initial page.
  LoadState get refreshLoadState;
  @override

  /// Load state of the previous page.
  LoadState get prependLoadState;
  @override

  /// Load state of the next page.
  LoadState get appendLoadState;
  @override
  @JsonKey(ignore: true)
  _$$PagingStateImplCopyWith<Key, Value, _$PagingStateImpl<Key, Value>>
      get copyWith => throw _privateConstructorUsedError;
}
