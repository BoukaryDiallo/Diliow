import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/coin_side.dart';

class CoinNotifier extends Notifier<CoinSide?> {
  final _random = Random();

  @override
  CoinSide? build() => null;

  CoinSide flip() {
    final result = _random.nextBool() ? CoinSide.heads : CoinSide.tails;
    state = result;
    return result;
  }

  void reset() => state = null;
}

final coinProvider = NotifierProvider<CoinNotifier, CoinSide?>(CoinNotifier.new);
