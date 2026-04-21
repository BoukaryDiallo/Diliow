import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'saved_list.freezed.dart';
part 'saved_list.g.dart';

@freezed
@HiveType(typeId: 0)
class SavedList with _$SavedList {
  const factory SavedList({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required List<String> options,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) required DateTime updatedAt,
  }) = _SavedList;

  factory SavedList.fromJson(Map<String, dynamic> json) => _$SavedListFromJson(json);
}
