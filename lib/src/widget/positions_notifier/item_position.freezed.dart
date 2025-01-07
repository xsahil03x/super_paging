// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ItemPosition {
  /// Index of the item.
  int get index => throw _privateConstructorUsedError;

  /// Distance in proportion of the viewport's main axis length from the
  /// leading edge of the viewport to the leading edge of the item.
  ///
  /// Note: It may be negative if the item is partially visible.
  double get itemLeadingEdge => throw _privateConstructorUsedError;

  /// Distance in proportion of the viewport's main axis length from the
  /// leading edge of the viewport to the trailing edge of the item.
  ///
  /// Note: It may be greater than one if the item is partially visible.
  double get itemTrailingEdge => throw _privateConstructorUsedError;

  /// Create a copy of ItemPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemPositionCopyWith<ItemPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemPositionCopyWith<$Res> {
  factory $ItemPositionCopyWith(
          ItemPosition value, $Res Function(ItemPosition) then) =
      _$ItemPositionCopyWithImpl<$Res, ItemPosition>;
  @useResult
  $Res call({int index, double itemLeadingEdge, double itemTrailingEdge});
}

/// @nodoc
class _$ItemPositionCopyWithImpl<$Res, $Val extends ItemPosition>
    implements $ItemPositionCopyWith<$Res> {
  _$ItemPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? itemLeadingEdge = null,
    Object? itemTrailingEdge = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      itemLeadingEdge: null == itemLeadingEdge
          ? _value.itemLeadingEdge
          : itemLeadingEdge // ignore: cast_nullable_to_non_nullable
              as double,
      itemTrailingEdge: null == itemTrailingEdge
          ? _value.itemTrailingEdge
          : itemTrailingEdge // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemPositionImplCopyWith<$Res>
    implements $ItemPositionCopyWith<$Res> {
  factory _$$ItemPositionImplCopyWith(
          _$ItemPositionImpl value, $Res Function(_$ItemPositionImpl) then) =
      __$$ItemPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, double itemLeadingEdge, double itemTrailingEdge});
}

/// @nodoc
class __$$ItemPositionImplCopyWithImpl<$Res>
    extends _$ItemPositionCopyWithImpl<$Res, _$ItemPositionImpl>
    implements _$$ItemPositionImplCopyWith<$Res> {
  __$$ItemPositionImplCopyWithImpl(
      _$ItemPositionImpl _value, $Res Function(_$ItemPositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? itemLeadingEdge = null,
    Object? itemTrailingEdge = null,
  }) {
    return _then(_$ItemPositionImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      itemLeadingEdge: null == itemLeadingEdge
          ? _value.itemLeadingEdge
          : itemLeadingEdge // ignore: cast_nullable_to_non_nullable
              as double,
      itemTrailingEdge: null == itemTrailingEdge
          ? _value.itemTrailingEdge
          : itemTrailingEdge // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ItemPositionImpl implements _ItemPosition {
  const _$ItemPositionImpl(
      {required this.index,
      required this.itemLeadingEdge,
      required this.itemTrailingEdge});

  /// Index of the item.
  @override
  final int index;

  /// Distance in proportion of the viewport's main axis length from the
  /// leading edge of the viewport to the leading edge of the item.
  ///
  /// Note: It may be negative if the item is partially visible.
  @override
  final double itemLeadingEdge;

  /// Distance in proportion of the viewport's main axis length from the
  /// leading edge of the viewport to the trailing edge of the item.
  ///
  /// Note: It may be greater than one if the item is partially visible.
  @override
  final double itemTrailingEdge;

  @override
  String toString() {
    return 'ItemPosition(index: $index, itemLeadingEdge: $itemLeadingEdge, itemTrailingEdge: $itemTrailingEdge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemPositionImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.itemLeadingEdge, itemLeadingEdge) ||
                other.itemLeadingEdge == itemLeadingEdge) &&
            (identical(other.itemTrailingEdge, itemTrailingEdge) ||
                other.itemTrailingEdge == itemTrailingEdge));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, index, itemLeadingEdge, itemTrailingEdge);

  /// Create a copy of ItemPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemPositionImplCopyWith<_$ItemPositionImpl> get copyWith =>
      __$$ItemPositionImplCopyWithImpl<_$ItemPositionImpl>(this, _$identity);
}

abstract class _ItemPosition implements ItemPosition {
  const factory _ItemPosition(
      {required final int index,
      required final double itemLeadingEdge,
      required final double itemTrailingEdge}) = _$ItemPositionImpl;

  /// Index of the item.
  @override
  int get index;

  /// Distance in proportion of the viewport's main axis length from the
  /// leading edge of the viewport to the leading edge of the item.
  ///
  /// Note: It may be negative if the item is partially visible.
  @override
  double get itemLeadingEdge;

  /// Distance in proportion of the viewport's main axis length from the
  /// leading edge of the viewport to the trailing edge of the item.
  ///
  /// Note: It may be greater than one if the item is partially visible.
  @override
  double get itemTrailingEdge;

  /// Create a copy of ItemPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemPositionImplCopyWith<_$ItemPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
