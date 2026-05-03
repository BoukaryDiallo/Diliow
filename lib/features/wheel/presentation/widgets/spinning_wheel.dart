import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../domain/wheel_segment.dart';

class SpinningWheel extends StatelessWidget {
  const SpinningWheel({
    super.key,
    required this.segments,
    required this.rotation,
    this.winnerIndex,
    this.winnerScale = 1.0,
  });

  final List<WheelSegment> segments;
  final double rotation;
  final int? winnerIndex;
  final double winnerScale;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: rotation,
            child: CustomPaint(
              size: Size.infinite,
              painter: _WheelPainter(
                segments: segments,
                winnerIndex: winnerIndex,
                winnerScale: winnerScale,
              ),
            ),
          ),
          // Pointer at top
          Positioned(
            top: 0,
            child: CustomPaint(
              size: const Size(28, 28),
              painter: _PointerPainter(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          // Center hub
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter({
    required this.segments,
    required this.winnerIndex,
    required this.winnerScale,
  });

  final List<WheelSegment> segments;
  final int? winnerIndex;
  final double winnerScale;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final n = segments.length;
    if (n == 0) return;
    final sweep = 2 * math.pi / n;
    final start = -math.pi / 2 - sweep / 2;

    for (int i = 0; i < n; i++) {
      final seg = segments[i];
      final color = AppColors.wheelPalette[seg.colorIndex % AppColors.wheelPalette.length];
      final isWinner = winnerIndex == i;
      final r = isWinner ? radius * winnerScale : radius;

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final rect = Rect.fromCircle(center: center, radius: r);
      canvas.drawArc(rect, start + i * sweep, sweep, true, paint);
    }

    // Segment borders
    final border = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (int i = 0; i < n; i++) {
      final angle = start + i * sweep;
      final p = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      canvas.drawLine(center, p, border);
    }

    // Outer rim
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Labels
    for (int i = 0; i < n; i++) {
      final seg = segments[i];
      final angle = start + i * sweep + sweep / 2;
      final labelRadius = radius * 0.62;
      final pos = center + Offset(math.cos(angle), math.sin(angle)) * labelRadius;

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      // Rotate so text reads outward from center
      canvas.rotate(angle + math.pi / 2);

      final tp = TextPainter(
        text: TextSpan(
          text: seg.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1)),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: radius * 0.7);

      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_WheelPainter old) =>
      old.segments != segments ||
      old.winnerIndex != winnerIndex ||
      old.winnerScale != winnerScale;
}

class _PointerPainter extends CustomPainter {
  _PointerPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.3), 4, false);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_PointerPainter old) => old.color != color;
}
