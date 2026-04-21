// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DecisionRecord _$DecisionRecordFromJson(Map<String, dynamic> json) {
  return _DecisionRecord.fromJson(json);
}

/// @nodoc
mixin _$DecisionRecord {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  DecisionMode get mode => throw _privateConstructorUsedError;
  @HiveField(2)
  String get result => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get question => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this DecisionRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionRecordCopyWith<DecisionRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionRecordCopyWith<$Res> {
  factory $DecisionRecordCopyWith(
    DecisionRecord value,
    $Res Function(DecisionRecord) then,
  ) = _$DecisionRecordCopyWithImpl<$Res, DecisionRecord>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) DecisionMode mode,
    @HiveField(2) String result,
    @HiveField(3) String? question,
    @HiveField(4) DateTime timestamp,
  });
}

/// @nodoc
class _$DecisionRecordCopyWithImpl<$Res, $Val extends DecisionRecord>
    implements $DecisionRecordCopyWith<$Res> {
  _$DecisionRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mode = null,
    Object? result = null,
    Object? question = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as DecisionMode,
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as String,
            question: freezed == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecisionRecordImplCopyWith<$Res>
    implements $DecisionRecordCopyWith<$Res> {
  factory _$$DecisionRecordImplCopyWith(
    _$DecisionRecordImpl value,
    $Res Function(_$DecisionRecordImpl) then,
  ) = __$$DecisionRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) DecisionMode mode,
    @HiveField(2) String result,
    @HiveField(3) String? question,
    @HiveField(4) DateTime timestamp,
  });
}

/// @nodoc
class __$$DecisionRecordImplCopyWithImpl<$Res>
    extends _$DecisionRecordCopyWithImpl<$Res, _$DecisionRecordImpl>
    implements _$$DecisionRecordImplCopyWith<$Res> {
  __$$DecisionRecordImplCopyWithImpl(
    _$DecisionRecordImpl _value,
    $Res Function(_$DecisionRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mode = null,
    Object? result = null,
    Object? question = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _$DecisionRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as DecisionMode,
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as String,
        question: freezed == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionRecordImpl implements _DecisionRecord {
  const _$DecisionRecordImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.mode,
    @HiveField(2) required this.result,
    @HiveField(3) this.question,
    @HiveField(4) required this.timestamp,
  });

  factory _$DecisionRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionRecordImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final DecisionMode mode;
  @override
  @HiveField(2)
  final String result;
  @override
  @HiveField(3)
  final String? question;
  @override
  @HiveField(4)
  final DateTime timestamp;

  @override
  String toString() {
    return 'DecisionRecord(id: $id, mode: $mode, result: $result, question: $question, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, mode, result, question, timestamp);

  /// Create a copy of DecisionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionRecordImplCopyWith<_$DecisionRecordImpl> get copyWith =>
      __$$DecisionRecordImplCopyWithImpl<_$DecisionRecordImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionRecordImplToJson(this);
  }
}

abstract class _DecisionRecord implements DecisionRecord {
  const factory _DecisionRecord({
    @HiveField(0) required final String id,
    @HiveField(1) required final DecisionMode mode,
    @HiveField(2) required final String result,
    @HiveField(3) final String? question,
    @HiveField(4) required final DateTime timestamp,
  }) = _$DecisionRecordImpl;

  factory _DecisionRecord.fromJson(Map<String, dynamic> json) =
      _$DecisionRecordImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  DecisionMode get mode;
  @override
  @HiveField(2)
  String get result;
  @override
  @HiveField(3)
  String? get question;
  @override
  @HiveField(4)
  DateTime get timestamp;

  /// Create a copy of DecisionRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionRecordImplCopyWith<_$DecisionRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
