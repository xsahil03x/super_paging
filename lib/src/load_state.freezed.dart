// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'load_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoadState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool endOfPaginationReached) notLoading,
    required TResult Function() loading,
    required TResult Function(Object? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool endOfPaginationReached)? notLoading,
    TResult? Function()? loading,
    TResult? Function(Object? error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool endOfPaginationReached)? notLoading,
    TResult Function()? loading,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotLoading value) notLoading,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotLoading value)? notLoading,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotLoading value)? notLoading,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadStateCopyWith<$Res> {
  factory $LoadStateCopyWith(LoadState value, $Res Function(LoadState) then) =
      _$LoadStateCopyWithImpl<$Res, LoadState>;
}

/// @nodoc
class _$LoadStateCopyWithImpl<$Res, $Val extends LoadState>
    implements $LoadStateCopyWith<$Res> {
  _$LoadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotLoadingImplCopyWith<$Res> {
  factory _$$NotLoadingImplCopyWith(
          _$NotLoadingImpl value, $Res Function(_$NotLoadingImpl) then) =
      __$$NotLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool endOfPaginationReached});
}

/// @nodoc
class __$$NotLoadingImplCopyWithImpl<$Res>
    extends _$LoadStateCopyWithImpl<$Res, _$NotLoadingImpl>
    implements _$$NotLoadingImplCopyWith<$Res> {
  __$$NotLoadingImplCopyWithImpl(
      _$NotLoadingImpl _value, $Res Function(_$NotLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endOfPaginationReached = null,
  }) {
    return _then(_$NotLoadingImpl(
      endOfPaginationReached: null == endOfPaginationReached
          ? _value.endOfPaginationReached
          : endOfPaginationReached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NotLoadingImpl implements NotLoading {
  const _$NotLoadingImpl({required this.endOfPaginationReached});

  @override
  final bool endOfPaginationReached;

  @override
  String toString() {
    return 'LoadState.notLoading(endOfPaginationReached: $endOfPaginationReached)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotLoadingImpl &&
            (identical(other.endOfPaginationReached, endOfPaginationReached) ||
                other.endOfPaginationReached == endOfPaginationReached));
  }

  @override
  int get hashCode => Object.hash(runtimeType, endOfPaginationReached);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotLoadingImplCopyWith<_$NotLoadingImpl> get copyWith =>
      __$$NotLoadingImplCopyWithImpl<_$NotLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool endOfPaginationReached) notLoading,
    required TResult Function() loading,
    required TResult Function(Object? error) error,
  }) {
    return notLoading(endOfPaginationReached);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool endOfPaginationReached)? notLoading,
    TResult? Function()? loading,
    TResult? Function(Object? error)? error,
  }) {
    return notLoading?.call(endOfPaginationReached);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool endOfPaginationReached)? notLoading,
    TResult Function()? loading,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (notLoading != null) {
      return notLoading(endOfPaginationReached);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotLoading value) notLoading,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return notLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotLoading value)? notLoading,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return notLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotLoading value)? notLoading,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (notLoading != null) {
      return notLoading(this);
    }
    return orElse();
  }
}

abstract class NotLoading implements LoadState {
  const factory NotLoading({required final bool endOfPaginationReached}) =
      _$NotLoadingImpl;

  bool get endOfPaginationReached;

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotLoadingImplCopyWith<_$NotLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$LoadStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LoadState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool endOfPaginationReached) notLoading,
    required TResult Function() loading,
    required TResult Function(Object? error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool endOfPaginationReached)? notLoading,
    TResult? Function()? loading,
    TResult? Function(Object? error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool endOfPaginationReached)? notLoading,
    TResult Function()? loading,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotLoading value) notLoading,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotLoading value)? notLoading,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotLoading value)? notLoading,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements LoadState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$LoadStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$ErrorImpl(
      freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl([this.error]);

  @override
  final Object? error;

  @override
  String toString() {
    return 'LoadState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool endOfPaginationReached) notLoading,
    required TResult Function() loading,
    required TResult Function(Object? error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool endOfPaginationReached)? notLoading,
    TResult? Function()? loading,
    TResult? Function(Object? error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool endOfPaginationReached)? notLoading,
    TResult Function()? loading,
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
    required TResult Function(NotLoading value) notLoading,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotLoading value)? notLoading,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotLoading value)? notLoading,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements LoadState {
  const factory Error([final Object? error]) = _$ErrorImpl;

  Object? get error;

  /// Create a copy of LoadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
