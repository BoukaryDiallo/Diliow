import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../domain/wheel_segment.dart';

const _storageKey = 'wheel_segments';
const _uuid = Uuid();

List<WheelSegment> _defaultSegments() {
  return List.generate(6, (i) {
    return WheelSegment(
      id: _uuid.v4(),
      label: 'Option ${i + 1}',
      colorIndex: i,
    );
  });
}

class WheelNotifier extends Notifier<List<WheelSegment>> {
  Box get _box => Hive.box('settings');

  @override
  List<WheelSegment> build() {
    final raw = _box.get(_storageKey);
    if (raw is String && raw.isNotEmpty) {
      try {
        final list = (jsonDecode(raw) as List)
            .map((e) => WheelSegment.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
        if (list.length >= 2) return list;
      } catch (_) {}
    }
    final seeded = _defaultSegments();
    _persist(seeded);
    return seeded;
  }

  Future<void> _persist(List<WheelSegment> segments) async {
    await _box.put(_storageKey, jsonEncode(segments.map((s) => s.toJson()).toList()));
  }

  void replaceAll(List<WheelSegment> segments) {
    state = segments;
    _persist(segments);
  }

  void addSegment(String label) {
    if (state.length >= 12) return;
    final next = WheelSegment(
      id: _uuid.v4(),
      label: label,
      colorIndex: state.length % 8,
    );
    state = [...state, next];
    _persist(state);
  }

  void removeSegment(String id) {
    if (state.length <= 2) return;
    state = state.where((s) => s.id != id).toList();
    _persist(state);
  }

  void renameSegment(String id, String label) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(label: label) else s,
    ];
    _persist(state);
  }
}

final wheelProvider =
    NotifierProvider<WheelNotifier, List<WheelSegment>>(WheelNotifier.new);
