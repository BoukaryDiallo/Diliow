import 'package:freezed_annotation/freezed_annotation.dart';

part 'wheel_segment.freezed.dart';
part 'wheel_segment.g.dart';

@freezed
class WheelSegment with _$WheelSegment {
  const factory WheelSegment({
    required String id,
    required String label,
    required int colorIndex,
  }) = _WheelSegment;

  factory WheelSegment.fromJson(Map<String, dynamic> json) =>
      _$WheelSegmentFromJson(json);
}
