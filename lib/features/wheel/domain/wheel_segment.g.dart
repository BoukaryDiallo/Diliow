// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wheel_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WheelSegmentImpl _$$WheelSegmentImplFromJson(Map<String, dynamic> json) =>
    _$WheelSegmentImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      colorIndex: (json['colorIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$WheelSegmentImplToJson(_$WheelSegmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'colorIndex': instance.colorIndex,
    };
