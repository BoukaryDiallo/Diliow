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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.appName, style: context.textStyles.displayLarge),
                      const SizedBox(height: 4),
                      Text(l10n.home_subtitle, style: context.textStyles.bodyMedium),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.history_rounded),
                    tooltip: l10n.home_history,
                    onPressed: () => goTo('/history'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                  children: [
                    ModeCard(
                      icon: Icons.pie_chart_rounded,
                      label: l10n.home_mode_wheel,
                      color: AppColors.wheelPalette[0],
                      onTap: () => goTo('/wheel'),
                    ),
                    ModeCard(
                      icon: Icons.monetization_on_outlined,
                      label: l10n.home_mode_coin,
                      color: AppColors.wheelPalette[3],
                      onTap: () => goTo('/coin'),
                    ),
                    ModeCard(
                      icon: Icons.list_alt_rounded,
                      label: l10n.home_mode_list,
                      color: AppColors.wheelPalette[1],
                      onTap: () => goTo('/list'),
                    ),
                    ModeCard(
                      icon: Icons.help_outline_rounded,
                      label: l10n.home_mode_yesno,
                      color: AppColors.wheelPalette[7],
                      onTap: () => goTo('/yesno'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => goTo('/saved'),
                icon: const Icon(Icons.bookmark_border_rounded),
                label: Text(l10n.home_saved_lists),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
