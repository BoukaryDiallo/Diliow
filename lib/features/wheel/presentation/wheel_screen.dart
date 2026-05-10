import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/utils/result_share.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/result_reveal.dart';
import '../../history/domain/decision_record.dart';
import '../../history/providers/history_provider.dart';
import '../providers/wheel_provider.dart';
import 'widgets/segment_editor.dart';
import 'widgets/spinning_wheel.dart';

class WheelScreen extends ConsumerStatefulWidget {
  const WheelScreen({super.key});

  @override
  ConsumerState<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends ConsumerState<WheelScreen>
    with TickerProviderStateMixin {
  late final AnimationController _spinCtrl;
  late final AnimationController _winnerCtrl;
  Animation<double>? _spinTween;
  double _baseRotation = 0;
  int? _winnerIndex;
  String? _result;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(vsync: this);
    _winnerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    _winnerCtrl.dispose();
    super.dispose();
  }

  Future<void> _spin() async {
    final segments = ref.read(wheelProvider);
    if (segments.length < 2 || _spinCtrl.isAnimating) return;

    final haptics = ref.read(hapticsProvider);
    haptics.light();

    setState(() {
      _winnerIndex = null;
      _result = null;
    });
    _winnerCtrl.reset();

    final n = segments.length;
    final sweep = 2 * math.pi / n;
    final winner = _random.nextInt(n);

    // Rotate so segment `winner`'s center lands exactly under the pointer.
    final targetMod = (-winner * sweep) % (2 * math.pi);
    final currentMod = _baseRotation % (2 * math.pi);
    final delta = (targetMod - currentMod) % (2 * math.pi);
    final turns = 4 + _random.nextInt(2);
    final end = _baseRotation + turns * 2 * math.pi + delta;

    _spinTween = Tween<double>(begin: _baseRotation, end: end).animate(
      CurvedAnimation(parent: _spinCtrl, curve: Curves.decelerate),
    );

    final durationMs = 3000 + _random.nextInt(2000);
    _spinCtrl.duration = Duration(milliseconds: durationMs);
    _spinCtrl.reset();
    await _spinCtrl.forward();
    _baseRotation = end;

    final winnerLabel = segments[winner].label;
    haptics.medium();
    setState(() {
      _winnerIndex = winner;
      _result = winnerLabel;
    });
    _winnerCtrl.forward();

    ref.read(historyProvider.notifier).record(
          mode: DecisionMode.wheel,
          result: winnerLabel,
        );
  }

  Future<void> _editSegments() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SegmentEditorSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final segments = ref.watch(wheelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wheel_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.wheel_edit_segments,
            onPressed: _editSegments,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_spinCtrl, _winnerCtrl]),
                    builder: (_, _) {
                      final rotation = _spinTween?.value ?? _baseRotation;
                      final scale = 1 + 0.08 * Curves.easeOutBack.transform(_winnerCtrl.value);
                      return SpinningWheel(
                        segments: segments,
                        rotation: rotation,
                        winnerIndex: _winnerIndex,
                        winnerScale: scale,
                      );
                    },
                  ),
                ),
              ),
              if (_result != null) ...[
                const SizedBox(height: 16),
                ResultReveal(
                  result: _result!,
                  accentColor: AppColors.wheelPalette[
                      (segments[_winnerIndex!].colorIndex) % AppColors.wheelPalette.length],
                  onShare: () => ResultShare.shareResult(l10n, _result!),
                ),
              ],
              const SizedBox(height: 16),
              PrimaryButton(
                label: l10n.wheel_spin_cta,
                icon: Icons.refresh_rounded,
                onPressed: _spinCtrl.isAnimating ? null : _spin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
