import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../domain/decision_record.dart';

class HistoryRepository {
  HistoryRepository(this._box);

  static const int maxEntries = 20;
  static const _uuid = Uuid();

  final Box<DecisionRecord> _box;

  List<DecisionRecord> getAll() {
    final all = _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return all;
  }

  Future<DecisionRecord> add({
    required DecisionMode mode,
    required String result,
    String? question,
  }) async {
    final record = DecisionRecord(
      id: _uuid.v4(),
      mode: mode,
      result: result,
      question: question,
      timestamp: DateTime.now(),
    );
    await _box.put(record.id, record);
    await _trim();
    return record;
  }

  Future<void> clear() => _box.clear();

  Future<void> _trim() async {
    final all = _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    if (all.length <= maxEntries) return;
    final toDelete = all.skip(maxEntries).map((r) => r.id).toList();
    await _box.deleteAll(toDelete);
  }

  Stream<BoxEvent> watch() => _box.watch();
}

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final box = Hive.box<DecisionRecord>('history');
  return HistoryRepository(box);
});
