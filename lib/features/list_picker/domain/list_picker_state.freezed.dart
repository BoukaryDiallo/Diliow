// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_picker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ListPickerState {
  List<String> get options => throw _privateConstructorUsedError;
  int? get winnerIndex => throw _privateConstructorUsedError;
  bool get isPicking => throw _privateConstructorUsedError;

  /// Create a copy of ListPickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListPickerStateCopyWith<ListPickerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListPickerStateCopyWith<$Res> {
  factory $ListPickerStateCopyWith(
    ListPickerState value,
    $Res Function(ListPickerState) then,
  ) = _$ListPickerStateCopyWithImpl<$Res, ListPickerState>;
  @useResult
  $Res call({List<String> options, int? winnerIndex, bool isPicking});
}

/// @nodoc
class _$ListPickerStateCopyWithImpl<$Res, $Val extends ListPickerState>
    implements $ListPickerStateCopyWith<$Res> {
  _$ListPickerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListPickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? winnerIndex = freezed,
    Object? isPicking = null,
  }) {
    return _then(
      _value.copyWith(
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            winnerIndex: freezed == winnerIndex
                ? _value.winnerIndex
                : winnerIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            isPicking: null == isPicking
                ? _value.isPicking
                : isPicking // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListPickerStateImplCopyWith<$Res>
    implements $ListPickerStateCopyWith<$Res> {
  factory _$$ListPickerStateImplCopyWith(
    _$ListPickerStateImpl value,
    $Res Function(_$ListPickerStateImpl) then,
  ) = __$$ListPickerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> options, int? winnerIndex, bool isPicking});
}

/// @nodoc
class __$$ListPickerStateImplCopyWithImpl<$Res>
    extends _$ListPickerStateCopyWithImpl<$Res, _$ListPickerStateImpl>
    implements _$$ListPickerStateImplCopyWith<$Res> {
  __$$ListPickerStateImplCopyWithImpl(
    _$ListPickerStateImpl _value,
    $Res Function(_$ListPickerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListPickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? winnerIndex = freezed,
    Object? isPicking = null,
  }) {
    return _then(
      _$ListPickerStateImpl(
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        winnerIndex: freezed == winnerIndex
            ? _value.winnerIndex
            : winnerIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        isPicking: null == isPicking
            ? _value.isPicking
            : isPicking // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ListPickerStateImpl implements _ListPickerState {
  const _$ListPickerStateImpl({
    final List<String> options = const <String>[],
    this.winnerIndex,
    this.isPicking = false,
  }) : _options = options;

  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int? winnerIndex;
  @override
  @JsonKey()
  final bool isPicking;

  @override
  String toString() {
    return 'ListPickerState(options: $options, winnerIndex: $winnerIndex, isPicking: $isPicking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListPickerStateImpl &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.winnerIndex, winnerIndex) ||
                other.winnerIndex == winnerIndex) &&
            (identical(other.isPicking, isPicking) ||
                other.isPicking == isPicking));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_options),
    winnerIndex,
    isPicking,
  );

  /// Create a copy of ListPickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListPickerStateImplCopyWith<_$ListPickerStateImpl> get copyWith =>
      __$$ListPickerStateImplCopyWithImpl<_$ListPickerStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ListPickerState implements ListPickerState {
  const factory _ListPickerState({
    final List<String> options,
    final int? winnerIndex,
    final bool isPicking,
  }) = _$ListPickerStateImpl;

  @override
  List<String> get options;
  @override
  int? get winnerIndex;
  @override
  bool get isPicking;

  /// Create a copy of ListPickerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListPickerStateImplCopyWith<_$ListPickerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
