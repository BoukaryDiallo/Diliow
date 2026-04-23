import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/history_repository.dart';
import '../domain/decision_record.dart';

class HistoryNotifier extends AsyncNotifier<List<DecisionRecord>> {
  late HistoryRepository _repo;

  @override
  Future<List<DecisionRecord>> build() async {
    _repo = ref.watch(historyRepositoryProvider);
    final sub = _repo.watch().listen((_) {
      state = AsyncData(_repo.getAll());
    });
    ref.onDispose(sub.cancel);
    return _repo.getAll();
  }

  Future<DecisionRecord> record({
    required DecisionMode mode,
    required String result,
    String? question,
  }) {
    return _repo.add(mode: mode, result: result, question: question);
  }

  Future<void> clear() => _repo.clear();
}

final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<DecisionRecord>>(HistoryNotifier.new);
