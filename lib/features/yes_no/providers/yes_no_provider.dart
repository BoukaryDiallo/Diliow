import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/yes_no_answer.dart';

class YesNoNotifier extends Notifier<YesNoAnswer?> {
  final _random = Random();

  @override
  YesNoAnswer? build() => null;

  YesNoAnswer decide() {
    final roll = _random.nextInt(100);
    final answer = roll < 45
        ? YesNoAnswer.yes
        : roll < 90
            ? YesNoAnswer.no
            : YesNoAnswer.maybe;
    state = answer;
    return answer;
  }

  void reset() => state = null;
}

final yesNoProvider =
    NotifierProvider<YesNoNotifier, YesNoAnswer?>(YesNoNotifier.new);
