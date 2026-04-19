import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HapticsService {
  HapticsService(this._enabled);

  final bool _enabled;

  Future<void> selection() async {
    if (!_enabled) return;
    await HapticFeedback.selectionClick();
  }

  Future<void> light() async {
    if (!_enabled) return;
    await HapticFeedback.lightImpact();
  }

  Future<void> medium() async {
    if (!_enabled) return;
    await HapticFeedback.mediumImpact();
  }

  Future<void> heavy() async {
    if (!_enabled) return;
    await HapticFeedback.heavyImpact();
  }
}

final hapticsEnabledProvider = StateProvider<bool>((ref) {
  final box = Hive.box('settings');
  return box.get('haptics_enabled', defaultValue: true) as bool;
});

final hapticsProvider = Provider<HapticsService>((ref) {
  final enabled = ref.watch(hapticsEnabledProvider);
  return HapticsService(enabled);
});
