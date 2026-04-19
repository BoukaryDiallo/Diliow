import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../extensions/context_extensions.dart';

class ResultReveal extends StatelessWidget {
  const ResultReveal({
    super.key,
    required this.result,
    this.label,
    this.onShare,
    this.accentColor,
  });

  final String result;
  final String? label;
  final VoidCallback? onShare;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? context.colors.primary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label ?? '${context.l10n.verdict_label} ✨',
            style: context.textStyles.labelSmall?.copyWith(
              letterSpacing: 1.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            result,
            textAlign: TextAlign.center,
            style: context.textStyles.displayMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          if (onShare != null) ...[
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: onShare,
              icon: const Icon(Icons.share_outlined, size: 18),
              label: Text(context.l10n.history_share),
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1.0, 1.0),
          duration: 400.ms,
          curve: Curves.elasticOut,
        );
  }
}
