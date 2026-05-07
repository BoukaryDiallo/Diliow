import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/list_picker_state.dart';

class ListPickerNotifier extends Notifier<ListPickerState> {
  final _random = Random();

  @override
  ListPickerState build() => const ListPickerState();

  void addOption(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    state = state.copyWith(
      options: [...state.options, trimmed],
      winnerIndex: null,
    );
  }

  void removeAt(int index) {
    final next = [...state.options]..removeAt(index);
    state = state.copyWith(options: next, winnerIndex: null);
  }

  void clear() {
    state = const ListPickerState();
  }

  void loadOptions(List<String> options) {
    state = ListPickerState(options: List.of(options));
  }

  void startPicking() {
    state = state.copyWith(isPicking: true, winnerIndex: null);
  }

  String? finishPicking() {
    if (state.options.length < 2) {
      state = state.copyWith(isPicking: false);
      return null;
    }
    final winner = _random.nextInt(state.options.length);
    state = state.copyWith(isPicking: false, winnerIndex: winner);
    return state.options[winner];
  }
}

final listPickerProvider =
    NotifierProvider<ListPickerNotifier, ListPickerState>(ListPickerNotifier.new);
