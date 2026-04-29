import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/utils/result_share.dart';
import '../domain/decision_record.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  IconData _modeIcon(DecisionMode mode) {
    switch (mode) {
      case DecisionMode.wheel:
        return Icons.pie_chart_rounded;
      case DecisionMode.coin:
        return Icons.monetization_on_outlined;
      case DecisionMode.list:
        return Icons.list_alt_rounded;
      case DecisionMode.yesNo:
        return Icons.help_outline_rounded;
    }
  }

  Color _modeColor(DecisionMode mode) {
    switch (mode) {
      case DecisionMode.wheel:
        return AppColors.wheelPalette[0];
      case DecisionMode.coin:
        return AppColors.wheelPalette[3];
      case DecisionMode.list:
        return AppColors.wheelPalette[1];
      case DecisionMode.yesNo:
        return AppColors.wheelPalette[7];
    }
  }

  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.history_clear_confirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.history_clear_all),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(historyProvider.notifier).clear();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(historyProvider);
    final haptics = ref.read(hapticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.history_title),
        actions: [
          history.maybeWhen(
            data: (records) => records.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: l10n.history_clear_all,
                    onPressed: () {
                      haptics.heavy();
                      _confirmClear(context, ref);
                    },
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (records) {
          if (records.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inbox_outlined,
                        size: 64, color: context.colors.onSurface.withValues(alpha: 0.3)),
                    const SizedBox(height: 16),
                    Text(l10n.history_empty,
                        style: context.textStyles.bodyLarge,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemCount: records.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final r = records[i];
              final color = _modeColor(r.mode);
              return _HistoryTile(
                record: r,
                icon: _modeIcon(r.mode),
                color: color,
                relative: formatRelativeTime(r.timestamp),
                onShare: () => ResultShare.shareResult(l10n, r.result),
              );
            },
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.record,
    required this.icon,
    required this.color,
    required this.relative,
    required this.onShare,
  });

  final DecisionRecord record;
  final IconData icon;
  final Color color;
  final String relative;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onShare,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.theme.dividerColor, width: 0.5),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (record.question != null) ...[
                      Text(
                        record.question!,
                        style: context.textStyles.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      record.result,
                      style: context.textStyles.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                relative,
                style: context.textStyles.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
