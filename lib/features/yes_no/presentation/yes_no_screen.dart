import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/utils/result_share.dart';
import '../../../core/widgets/primary_button.dart';
import '../../history/domain/decision_record.dart';
import '../../history/providers/history_provider.dart';
import '../domain/yes_no_answer.dart';
import '../providers/yes_no_provider.dart';

class YesNoScreen extends ConsumerStatefulWidget {
  const YesNoScreen({super.key});

  @override
  ConsumerState<YesNoScreen> createState() => _YesNoScreenState();
}

class _YesNoScreenState extends ConsumerState<YesNoScreen> {
  final _ctrl = TextEditingController();
  bool _flashing = false;
  YesNoAnswer? _answer;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _decide() async {
    final q = _ctrl.text.trim();
    if (q.isEmpty) return;
    final l10n = context.l10n;
    final haptics = ref.read(hapticsProvider);

    haptics.medium();
    setState(() {
      _answer = null;
    });

    final answer = ref.read(yesNoProvider.notifier).decide();
    setState(() {
      _flashing = true;
      _answer = answer;
    });
    haptics.heavy();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _flashing = false);

    final label = answer.label(
      l10n.yesno_answer_yes,
      l10n.yesno_answer_no,
      l10n.yesno_answer_maybe,
    );
    await ref.read(historyProvider.notifier).record(
          mode: DecisionMode.yesNo,
          result: label,
          question: q,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canDecide = _ctrl.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.yesno_title)),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                children: [
                  TextField(
                    controller: _ctrl,
                    maxLines: 4,
                    minLines: 3,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _decide(),
                    style: context.textStyles.titleMedium,
                    decoration: InputDecoration(
                      hintText: l10n.yesno_placeholder,
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Center(
                      child: _answer == null
                          ? Icon(
                              Icons.help_outline_rounded,
                              size: 96,
                              color: context.colors.onSurface.withValues(alpha: 0.15),
                            )
                          : _AnswerView(
                              key: ValueKey(_answer),
                              answer: _answer!,
                              label: _answer!.label(
                                l10n.yesno_answer_yes,
                                l10n.yesno_answer_no,
                                l10n.yesno_answer_maybe,
                              ),
                            ),
                    ),
                  ),
                  if (_answer != null) ...[
                    TextButton.icon(
                      onPressed: () => ResultShare.shareResult(
                        l10n,
                        _answer!.label(
                          l10n.yesno_answer_yes,
                          l10n.yesno_answer_no,
                          l10n.yesno_answer_maybe,
                        ),
                      ),
                      icon: const Icon(Icons.share_outlined, size: 18),
                      label: Text(l10n.history_share),
                    ),
                    const SizedBox(height: 4),
                  ],
                  PrimaryButton(
                    label: l10n.yesno_decide_cta,
                    icon: Icons.gavel_rounded,
                    onPressed: canDecide ? _decide : null,
                  ),
                ],
              ),
            ),
          ),
          if (_flashing && _answer != null)
            IgnorePointer(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _flashing ? 0.85 : 0.0,
                child: Container(color: _answer!.color),
              ),
            ),
        ],
      ),
    );
  }
}

class _AnswerView extends StatelessWidget {
  const _AnswerView({super.key, required this.answer, required this.label});

  final YesNoAnswer answer;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(answer.emoji, style: const TextStyle(fontSize: 96)),
        const SizedBox(height: 8),
        Text(
          label,
          style: context.textStyles.displayLarge?.copyWith(
            fontSize: 64,
            fontWeight: FontWeight.w800,
            color: answer.color,
            letterSpacing: -1,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .scale(
          begin: const Offset(0.6, 0.6),
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.elasticOut,
        );
  }
}
