import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'decision_record.freezed.dart';
part 'decision_record.g.dart';

@HiveType(typeId: 2)
enum DecisionMode {
  @HiveField(0)
  wheel,
  @HiveField(1)
  coin,
  @HiveField(2)
  list,
  @HiveField(3)
  yesNo,
}

@freezed
@HiveType(typeId: 1)
class DecisionRecord with _$DecisionRecord {
  const factory DecisionRecord({
    @HiveField(0) required String id,
    @HiveField(1) required DecisionMode mode,
    @HiveField(2) required String result,
    @HiveField(3) String? question,
    @HiveField(4) required DateTime timestamp,
  }) = _DecisionRecord;

  factory DecisionRecord.fromJson(Map<String, dynamic> json) =>
      _$DecisionRecordFromJson(json);
}
