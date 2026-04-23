import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../domain/saved_list.dart';

class SavedListsRepository {
  SavedListsRepository(this._box);

  final Box<SavedList> _box;
  static const _uuid = Uuid();

  List<SavedList> getAll() {
    final all = _box.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return all;
  }

  SavedList? get(String id) => _box.get(id);

  Future<SavedList> create({required String name, required List<String> options}) async {
    final now = DateTime.now();
    final list = SavedList(
      id: _uuid.v4(),
      name: name,
      options: options,
      createdAt: now,
      updatedAt: now,
    );
    await _box.put(list.id, list);
    return list;
  }

  Future<void> update(SavedList list) async {
    await _box.put(list.id, list.copyWith(updatedAt: DateTime.now()));
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<void> restore(SavedList list) async {
    await _box.put(list.id, list);
  }

  Stream<BoxEvent> watch() => _box.watch();
}

final savedListsRepositoryProvider = Provider<SavedListsRepository>((ref) {
  final box = Hive.box<SavedList>('saved_lists');
  return SavedListsRepository(box);
});
