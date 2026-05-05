import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/utils/result_share.dart';
import '../../../core/widgets/primary_button.dart';
import '../../history/domain/decision_record.dart';
import '../../history/providers/history_provider.dart';
import '../domain/coin_side.dart';
import '../providers/coin_provider.dart';

class CoinScreen extends ConsumerStatefulWidget {
  const CoinScreen({super.key});

  @override
  ConsumerState<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends ConsumerState<CoinScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late Animation<double> _rotation;
  final _random = math.Random();
  CoinSide? _flipResult;
  int _halfTurns = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _rotation = Tween<double>(begin: 0, end: 0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _flip() async {
    if (_ctrl.isAnimating) return;
    final haptics = ref.read(hapticsProvider);
    final l10n = context.l10n;
    haptics.light();

    final result = ref.read(coinProvider.notifier).flip();
    setState(() => _flipResult = null);

    // 4-6 half rotations
    final halfTurns = 4 + _random.nextInt(3);
    // If result is heads, end facing up (even half turns from current).
    // If tails, end facing flipped (odd half turns).
    final desiredParity = result == CoinSide.heads ? 0 : 1;
    final adjusted = halfTurns + ((halfTurns + _halfTurns) % 2 == desiredParity ? 0 : 1);
    final endRotation = (_halfTurns + adjusted) * math.pi;

    _rotation = Tween<double>(
      begin: _halfTurns * math.pi,
      end: endRotation.toDouble(),
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: const Cubic(0.2, 0.0, 0.2, 1.0)),
    );

    _halfTurns += adjusted;
    _ctrl.reset();
    await _ctrl.forward();

    haptics.medium();
    setState(() => _flipResult = result);

    ref.read(historyProvider.notifier).record(
          mode: DecisionMode.coin,
          result: result.label(l10n.coin_heads, l10n.coin_tails),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.coin_title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _rotation,
                    builder: (_, _) {
                      final angle = _rotation.value;
                      // Show heads side when normalized angle is closer to 0 mod 2π.
                      final normalized = angle % (2 * math.pi);
                      final showHeads = normalized < math.pi / 2 ||
                          normalized > 3 * math.pi / 2;
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(angle),
                        child: _CoinFace(side: showHeads ? CoinSide.heads : CoinSide.tails),
                      );
                    },
                  ),
                ),
              ),
              if (_flipResult != null) ...[
                const SizedBox(height: 12),
                Text(
                  _flipResult!.label(l10n.coin_heads, l10n.coin_tails),
                  style: context.textStyles.displayLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1, 1),
                      duration: 400.ms,
                      curve: Curves.elasticOut,
                    ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => ResultShare.shareResult(
                    l10n,
                    _flipResult!.label(l10n.coin_heads, l10n.coin_tails),
                  ),
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: Text(l10n.history_share),
                ),
              ],
              const SizedBox(height: 16),
              PrimaryButton(
                label: l10n.coin_flip_cta,
                icon: Icons.refresh_rounded,
                onPressed: _ctrl.isAnimating ? null : _flip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoinFace extends StatelessWidget {
  const _CoinFace({required this.side});
  final CoinSide side;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: CustomPaint(painter: _CoinPainter(side: side)),
    );
  }
}

class _CoinPainter extends CustomPainter {
  _CoinPainter({required this.side});
  final CoinSide side;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;

    // Gold gradient body
    final body = Paint()
      ..shader = RadialGradient(
        colors: [
          side == CoinSide.heads ? AppColors.primary : AppColors.accent,
          side == CoinSide.heads ? AppColors.primaryDark : const Color(0xFFD94545),
        ],
        center: Alignment.topLeft,
        radius: 1.0,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, body);

    // Inner ring
    final ring = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius * 0.85, ring);

    // Letter
    final tp = TextPainter(
      text: TextSpan(
        text: side.letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 110,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_CoinPainter old) => old.side != side;
}
