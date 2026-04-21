// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DecisionRecordAdapter extends TypeAdapter<DecisionRecord> {
  @override
  final typeId = 1;

  @override
  DecisionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DecisionRecord(
      id: fields[0] as String,
      mode: fields[1] as DecisionMode,
      result: fields[2] as String,
      question: fields[3] as String?,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DecisionRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mode)
      ..writeByte(2)
      ..write(obj.result)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DecisionModeAdapter extends TypeAdapter<DecisionMode> {
  @override
  final typeId = 2;

  @override
  DecisionMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DecisionMode.wheel;
      case 1:
        return DecisionMode.coin;
      case 2:
        return DecisionMode.list;
      case 3:
        return DecisionMode.yesNo;
      default:
        return DecisionMode.wheel;
    }
  }

  @override
  void write(BinaryWriter writer, DecisionMode obj) {
    switch (obj) {
      case DecisionMode.wheel:
        writer.writeByte(0);
      case DecisionMode.coin:
        writer.writeByte(1);
      case DecisionMode.list:
        writer.writeByte(2);
      case DecisionMode.yesNo:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DecisionRecordImpl _$$DecisionRecordImplFromJson(Map<String, dynamic> json) =>
    _$DecisionRecordImpl(
      id: json['id'] as String,
      mode: $enumDecode(_$DecisionModeEnumMap, json['mode']),
      result: json['result'] as String,
      question: json['question'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DecisionRecordImplToJson(
  _$DecisionRecordImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mode': _$DecisionModeEnumMap[instance.mode]!,
  'result': instance.result,
  'question': instance.question,
  'timestamp': instance.timestamp.toIso8601String(),
};

const _$DecisionModeEnumMap = {
  DecisionMode.wheel: 'wheel',
  DecisionMode.coin: 'coin',
  DecisionMode.list: 'list',
  DecisionMode.yesNo: 'yesNo',
};
