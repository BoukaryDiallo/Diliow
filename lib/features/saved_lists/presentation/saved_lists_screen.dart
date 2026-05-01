import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../domain/saved_list.dart';
import '../providers/saved_lists_provider.dart';
import 'widgets/saved_list_tile.dart';

class SavedListsScreen extends ConsumerWidget {
  const SavedListsScreen({super.key});

  Future<String?> _promptName(BuildContext context, {String? initial}) {
    final ctrl = TextEditingController(text: initial ?? '');
    final l10n = context.l10n;
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.list_save_cta),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.saved_list_name_placeholder),
          onSubmitted: (v) => Navigator.of(ctx).pop(v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(ctrl.text),
            child: Text(l10n.common_save),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    SavedList list,
  ) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(savedListsProvider.notifier);

    await notifier.delete(list.id);
    if (!context.mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.saved_list_deleted),
        action: SnackBarAction(
          label: l10n.saved_list_undo,
          onPressed: () => notifier.restore(list),
        ),
      ),
    );
  }

  Future<void> _createNew(BuildContext context, WidgetRef ref) async {
    final name = await _promptName(context);
    if (name == null || name.trim().isEmpty) return;
    if (!context.mounted) return;
    final created = await ref.read(savedListsProvider.notifier).create(
          name: name.trim(),
          options: const [],
        );
    if (!context.mounted) return;
    context.push('/list?savedListId=${created.id}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final haptics = ref.read(hapticsProvider);
    final async = ref.watch(savedListsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.saved_lists_title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          haptics.selection();
          _createNew(context, ref);
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.list_save_cta),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (lists) {
          if (lists.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bookmark_border_rounded,
                      size: 64,
                      color: context.colors.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.saved_lists_empty,
                      style: context.textStyles.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
            itemCount: lists.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final list = lists[i];
              return Dismissible(
                key: ValueKey(list.id),
                direction: DismissDirection.endToStart,
                background: _DeleteBackground(label: l10n.common_delete),
                confirmDismiss: (_) async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (dctx) => AlertDialog(
                      title: Text(l10n.saved_list_delete_confirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(dctx).pop(false),
                          child: Text(l10n.common_cancel),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.of(dctx).pop(true),
                          child: Text(l10n.common_delete),
                        ),
                      ],
                    ),
                  );
                  return ok ?? false;
                },
                onDismissed: (_) {
                  haptics.heavy();
                  _confirmDelete(context, ref, list);
                },
                child: SavedListTile(
                  list: list,
                  onTap: () {
                    haptics.selection();
                    context.push('/list?savedListId=${list.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: context.colors.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete_outline_rounded, color: context.colors.error),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.textStyles.labelLarge?.copyWith(
              color: context.colors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
