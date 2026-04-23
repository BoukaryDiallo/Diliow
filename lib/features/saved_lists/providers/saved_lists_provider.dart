import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/saved_lists_repository.dart';
import '../domain/saved_list.dart';

class SavedListsNotifier extends AsyncNotifier<List<SavedList>> {
  late SavedListsRepository _repo;

  @override
  Future<List<SavedList>> build() async {
    _repo = ref.watch(savedListsRepositoryProvider);
    final sub = _repo.watch().listen((_) {
      state = AsyncData(_repo.getAll());
    });
    ref.onDispose(sub.cancel);
    return _repo.getAll();
  }

  Future<SavedList> create({required String name, required List<String> options}) {
    return _repo.create(name: name, options: options);
  }

  Future<void> save(SavedList list) => _repo.update(list);

  Future<void> delete(String id) => _repo.delete(id);

  Future<void> restore(SavedList list) => _repo.restore(list);
}

final savedListsProvider =
    AsyncNotifierProvider<SavedListsNotifier, List<SavedList>>(SavedListsNotifier.new);
