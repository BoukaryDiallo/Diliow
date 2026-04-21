// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedList _$SavedListFromJson(Map<String, dynamic> json) {
  return _SavedList.fromJson(json);
}

/// @nodoc
mixin _$SavedList {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  List<String> get options => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SavedList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedListCopyWith<SavedList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedListCopyWith<$Res> {
  factory $SavedListCopyWith(SavedList value, $Res Function(SavedList) then) =
      _$SavedListCopyWithImpl<$Res, SavedList>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) List<String> options,
    @HiveField(3) DateTime createdAt,
    @HiveField(4) DateTime updatedAt,
  });
}

/// @nodoc
class _$SavedListCopyWithImpl<$Res, $Val extends SavedList>
    implements $SavedListCopyWith<$Res> {
  _$SavedListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? options = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavedListImplCopyWith<$Res>
    implements $SavedListCopyWith<$Res> {
  factory _$$SavedListImplCopyWith(
    _$SavedListImpl value,
    $Res Function(_$SavedListImpl) then,
  ) = __$$SavedListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) List<String> options,
    @HiveField(3) DateTime createdAt,
    @HiveField(4) DateTime updatedAt,
  });
}

/// @nodoc
class __$$SavedListImplCopyWithImpl<$Res>
    extends _$SavedListCopyWithImpl<$Res, _$SavedListImpl>
    implements _$$SavedListImplCopyWith<$Res> {
  __$$SavedListImplCopyWithImpl(
    _$SavedListImpl _value,
    $Res Function(_$SavedListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? options = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SavedListImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedListImpl implements _SavedList {
  const _$SavedListImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.name,
    @HiveField(2) required final List<String> options,
    @HiveField(3) required this.createdAt,
    @HiveField(4) required this.updatedAt,
  }) : _options = options;

  factory _$SavedListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedListImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  final List<String> _options;
  @override
  @HiveField(2)
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @HiveField(3)
  final DateTime createdAt;
  @override
  @HiveField(4)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SavedList(id: $id, name: $name, options: $options, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_options),
    createdAt,
    updatedAt,
  );

  /// Create a copy of SavedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedListImplCopyWith<_$SavedListImpl> get copyWith =>
      __$$SavedListImplCopyWithImpl<_$SavedListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedListImplToJson(this);
  }
}

abstract class _SavedList implements SavedList {
  const factory _SavedList({
    @HiveField(0) required final String id,
    @HiveField(1) required final String name,
    @HiveField(2) required final List<String> options,
    @HiveField(3) required final DateTime createdAt,
    @HiveField(4) required final DateTime updatedAt,
  }) = _$SavedListImpl;

  factory _SavedList.fromJson(Map<String, dynamic> json) =
      _$SavedListImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  List<String> get options;
  @override
  @HiveField(3)
  DateTime get createdAt;
  @override
  @HiveField(4)
  DateTime get updatedAt;

  /// Create a copy of SavedList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedListImplCopyWith<_$SavedListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
