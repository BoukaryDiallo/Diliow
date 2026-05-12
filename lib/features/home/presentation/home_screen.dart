import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/mode_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final haptics = ref.read(hapticsProvider);

    void goTo(String route) {
      haptics.selection();
      context.push(route);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 12, 6, 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.appName,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5,
                            color: context.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.home_subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: context.colors.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.history_rounded),
                      tooltip: l10n.home_history,
                      onPressed: () => goTo('/history'),
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 2.0,
                child: Row(
                  children: [
                    Expanded(
                      child: ModeCard(
                        icon: Icons.rotate_right_rounded,
                        label: l10n.home_mode_wheel,
                        subtitle: l10n.home_mode_wheel_sub,
                        color: AppColors.primary,
                        filled: true,
                        onTap: () => goTo('/wheel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeCard(
                        icon: Icons.circle_outlined,
                        label: l10n.home_mode_coin,
                        subtitle: l10n.home_mode_coin_sub,
                        color: AppColors.accent,
                        filled: false,
                        onTap: () => goTo('/coin'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 2.0,
                child: Row(
                  children: [
                    Expanded(
                      child: ModeCard(
                        icon: Icons.list_rounded,
                        label: l10n.home_mode_list,
                        subtitle: l10n.home_mode_list_sub,
                        color: AppColors.primary,
                        filled: false,
                        onTap: () => goTo('/list'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeCard(
                        icon: Icons.help_outline_rounded,
                        label: l10n.home_mode_yesno,
                        subtitle: l10n.home_mode_yesno_sub,
                        color: AppColors.accent,
                        filled: true,
                        onTap: () => goTo('/yesno'),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _SavedListsCta(onTap: () => goTo('/saved')),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedListsCta extends StatelessWidget {
  const _SavedListsCta({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final bg = isDark ? AppColors.surfaceLight : AppColors.textLight;
    final fg = isDark ? AppColors.textLight : Colors.white;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 52,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bookmark_outline_rounded, size: 18, color: fg),
              const SizedBox(width: 8),
              Text(
                context.l10n.home_saved_lists,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
