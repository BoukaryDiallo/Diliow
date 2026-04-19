import 'dart:math';

class RandomHelper {
  RandomHelper([int? seed]) : _random = Random(seed);

  final Random _random;

  int nextInt(int max) => _random.nextInt(max);
  double nextDouble() => _random.nextDouble();

  T pickOne<T>(List<T> items) {
    assert(items.isNotEmpty, 'Cannot pick from empty list');
    return items[_random.nextInt(items.length)];
  }
}
