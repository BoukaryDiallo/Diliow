import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';

class OptionInput extends StatefulWidget {
  const OptionInput({super.key, required this.onAdd});

  final ValueChanged<String> onAdd;

  @override
  State<OptionInput> createState() => _OptionInputState();
}

class _OptionInputState extends State<OptionInput> {
  final _ctrl = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      final hasText = _ctrl.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_ctrl.text.trim().isEmpty) return;
    widget.onAdd(_ctrl.text);
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ctrl,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: context.l10n.list_add_placeholder,
              prefixIcon: const Icon(Icons.add_rounded, size: 22),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: _hasText ? _submit : null,
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text(context.l10n.common_done),
          ),
        ),
      ],
    );
  }
}
