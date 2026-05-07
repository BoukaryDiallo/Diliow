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
import '../../saved_lists/domain/saved_list.dart';
import '../../saved_lists/providers/saved_lists_provider.dart';
import '../providers/list_picker_provider.dart';
import 'widgets/option_input.dart';

class ListPickerScreen extends ConsumerStatefulWidget {
  const ListPickerScreen({super.key, this.savedListId});

  final String? savedListId;

  @override
  ConsumerState<ListPickerScreen> createState() => _ListPickerScreenState();
}

class _ListPickerScreenState extends ConsumerState<ListPickerScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final id = widget.savedListId;
    if (id == null) return;
    Future.microtask(() async {
      final lists = await ref.read(savedListsProvider.future);
      final match = lists.where((l) => l.id == id).firstOrNull;
      if (match != null && mounted) {
        ref.read(listPickerProvider.notifier).loadOptions(match.options);
      }
    });
  }

  Future<void> _pick() async {
    final notifier = ref.read(listPickerProvider.notifier);
    final state = ref.read(listPickerProvider);
    if (state.options.length < 2) return;
    final haptics = ref.read(hapticsProvider);

    haptics.light();
    notifier.startPicking();
    await Future.delayed(const Duration(milliseconds: 250));
    final result = notifier.finishPicking();
    if (result == null) return;
    haptics.medium();
    await ref.read(historyProvider.notifier).record(
          mode: DecisionMode.list,
          result: result,
        );
  }

  Future<void> _openLoadSheet() async {
    final lists = await ref.read(savedListsProvider.future);
    if (!mounted) return;
    if (lists.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.saved_lists_empty)),
      );
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _LoadSavedSheet(
        lists: lists,
        onPick: (l) {
          ref.read(listPickerProvider.notifier).loadOptions(l.options);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _saveList() async {
    final state = ref.read(listPickerProvider);
    if (state.options.length < 2) return;
    final l10n = context.l10n;
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => _NameDialog(),
    );
    if (name == null || name.trim().isEmpty) return;
    await ref.read(savedListsProvider.notifier).create(
          name: name.trim(),
          options: state.options,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.list_saved_toast)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(listPickerProvider);
    final canPick = state.options.length >= 2 && !state.isPicking;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.list_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open_rounded),
            tooltip: l10n.list_load_saved,
            onPressed: _openLoadSheet,
          ),
          if (state.options.length >= 2)
            IconButton(
              icon: const Icon(Icons.bookmark_add_outlined),
              tooltip: l10n.list_save_cta,
              onPressed: _saveList,
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            children: [
              OptionInput(
                onAdd: (v) => ref.read(listPickerProvider.notifier).addOption(v),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.options.isEmpty
                    ? _EmptyState(text: l10n.list_empty_state)
                    : SingleChildScrollView(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (int i = 0; i < state.options.length; i++)
                              _OptionChip(
                                key: ValueKey('${state.options[i]}_$i'),
                                label: state.options[i],
                                index: i,
                                state: state,
                                onDelete: () =>
                                    ref.read(listPickerProvider.notifier).removeAt(i),
                              ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 12),
              if (state.winnerIndex != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextButton.icon(
                    onPressed: () => ResultShare.shareResult(
                      l10n,
                      state.options[state.winnerIndex!],
                    ),
                    icon: const Icon(Icons.share_outlined, size: 18),
                    label: Text(l10n.history_share),
                  ),
                ),
              PrimaryButton(
                label: l10n.list_pick_cta,
                icon: Icons.casino_rounded,
                onPressed: canPick ? _pick : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({
    super.key,
    required this.label,
    required this.index,
    required this.state,
    required this.onDelete,
  });

  final String label;
  final int index;
  final dynamic state;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final winner = state.winnerIndex;
    final isWinner = winner == index;
    final hasWinner = winner != null;
    final opacity = hasWinner && !isWinner ? 0.3 : 1.0;

    Widget chip = AnimatedScale(
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      scale: isWinner ? 1.15 : 1.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: opacity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isWinner
                ? AppColors.primary.withValues(alpha: 0.15)
                : context.colors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isWinner ? AppColors.primary : context.theme.dividerColor,
              width: isWinner ? 1.5 : 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textStyles.bodyLarge?.copyWith(
                  fontWeight: isWinner ? FontWeight.w700 : FontWeight.w500,
                  color: isWinner ? AppColors.primary : null,
                ),
              ),
              if (!hasWinner) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: context.colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (state.isPicking) {
      chip = chip
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .shake(duration: 80.ms, hz: 8, offset: const Offset(2, 0));
    }
    return chip;
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.list_alt_rounded,
            size: 56,
            color: context.colors.onSurface.withValues(alpha: 0.25),
          ),
          const SizedBox(height: 12),
          Text(text, style: context.textStyles.bodyLarge),
        ],
      ),
    );
  }
}

class _LoadSavedSheet extends StatelessWidget {
  const _LoadSavedSheet({required this.lists, required this.onPick});
  final List<SavedList> lists;
  final ValueChanged<SavedList> onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(context.l10n.list_load_saved, style: context.textStyles.titleLarge),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 360),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: lists.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (ctx, i) {
                    final l = lists[i];
                    return ListTile(
                      title: Text(l.name),
                      subtitle:
                          Text(context.l10n.saved_list_option_count(l.options.length)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      onTap: () => onPick(l),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameDialog extends StatefulWidget {
  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.list_save_cta),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        decoration: InputDecoration(hintText: l10n.saved_list_name_placeholder),
        onSubmitted: (v) => Navigator.of(context).pop(v),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_ctrl.text),
          child: Text(l10n.common_save),
        ),
      ],
    );
  }
}
