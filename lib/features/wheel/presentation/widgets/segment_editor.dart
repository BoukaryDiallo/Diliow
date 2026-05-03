import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../domain/wheel_segment.dart';
import '../../providers/wheel_provider.dart';

const _uuid = Uuid();

class SegmentEditorSheet extends ConsumerStatefulWidget {
  const SegmentEditorSheet({super.key});

  @override
  ConsumerState<SegmentEditorSheet> createState() => _SegmentEditorSheetState();
}

class _SegmentEditorSheetState extends ConsumerState<SegmentEditorSheet> {
  late List<WheelSegment> _segments;

  @override
  void initState() {
    super.initState();
    _segments = List.of(ref.read(wheelProvider));
  }

  void _add() {
    if (_segments.length >= 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.wheel_max_segments_error)),
      );
      return;
    }
    setState(() {
      _segments = [
        ..._segments,
        WheelSegment(
          id: _uuid.v4(),
          label: context.l10n.wheel_default_segment(_segments.length + 1),
          colorIndex: _segments.length % 8,
        ),
      ];
    });
  }

  void _remove(String id) {
    if (_segments.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.wheel_min_segments_error)),
      );
      return;
    }
    setState(() => _segments = _segments.where((s) => s.id != id).toList());
  }

  void _rename(String id, String label) {
    setState(() {
      _segments = [
        for (final s in _segments)
          if (s.id == id) s.copyWith(label: label) else s,
      ];
    });
  }

  void _save() {
    ref.read(wheelProvider.notifier).replaceAll(_segments);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (ctx, scroll) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colors.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(l10n.wheel_edit_segments,
                          style: context.textStyles.titleLarge),
                    ),
                    Text('${_segments.length}/12',
                        style: context.textStyles.labelSmall),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scroll,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  itemCount: _segments.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (ctx, i) {
                    final seg = _segments[i];
                    return _SegmentRow(
                      key: ValueKey(seg.id),
                      segment: seg,
                      onRename: (v) => _rename(seg.id, v),
                      onDelete: () => _remove(seg.id),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  16 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _add,
                        icon: const Icon(Icons.add_rounded),
                        label: Text(l10n.wheel_segment_add),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _save,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.common_done),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SegmentRow extends StatefulWidget {
  const _SegmentRow({
    super.key,
    required this.segment,
    required this.onRename,
    required this.onDelete,
  });

  final WheelSegment segment;
  final ValueChanged<String> onRename;
  final VoidCallback onDelete;

  @override
  State<_SegmentRow> createState() => _SegmentRowState();
}

class _SegmentRowState extends State<_SegmentRow> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.segment.label);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.wheelPalette[widget.segment.colorIndex % AppColors.wheelPalette.length];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.dividerColor, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _ctrl,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
              onChanged: widget.onRename,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline_rounded, size: 22),
            color: context.colors.onSurface.withValues(alpha: 0.6),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}
