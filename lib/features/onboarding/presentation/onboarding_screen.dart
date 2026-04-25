import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final box = Hive.box('settings');
    await box.put('onboarding_complete', true);
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _OnboardingPage(
                    icon: Icons.auto_awesome,
                    iconColor: AppColors.primary,
                    title: l10n.onboarding_welcome_title,
                    body: l10n.onboarding_welcome_body,
                  ),
                  _OnboardingPage(
                    icon: Icons.apps_rounded,
                    iconColor: AppColors.accent,
                    title: l10n.onboarding_how_title,
                    body: l10n.onboarding_how_body,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (i) {
                      final active = i == _page;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? context.colors.primary
                              : context.colors.primary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  if (_page == 0)
                    PrimaryButton(
                      label: l10n.onboarding_cta_next,
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                      ),
                    )
                  else
                    PrimaryButton(
                      label: l10n.onboarding_cta_start,
                      onPressed: _complete,
                    ),
                  const SizedBox(height: 12),
                  if (_page == 0)
                    SecondaryButton(
                      label: l10n.onboarding_cta_start,
                      onPressed: _complete,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(icon, size: 56, color: iconColor),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textStyles.displayMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            body,
            textAlign: TextAlign.center,
            style: context.textStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
