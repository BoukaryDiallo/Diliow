import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../features/coin/presentation/coin_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/list_picker/presentation/list_picker_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/saved_lists/presentation/saved_lists_screen.dart';
import '../features/wheel/presentation/wheel_screen.dart';
import '../features/yes_no/presentation/yes_no_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final box = Hive.box('settings');
    final onboardingDone = box.get('onboarding_complete', defaultValue: false) as bool;
    if (!onboardingDone && state.matchedLocation != '/onboarding') {
      return '/onboarding';
    }
    if (onboardingDone && state.matchedLocation == '/onboarding') {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
    GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/wheel', builder: (_, _) => const WheelScreen()),
    GoRoute(path: '/coin', builder: (_, _) => const CoinScreen()),
    GoRoute(
      path: '/list',
      builder: (_, state) => ListPickerScreen(
        savedListId: state.uri.queryParameters['savedListId'],
      ),
    ),
    GoRoute(path: '/yesno', builder: (_, _) => const YesNoScreen()),
    GoRoute(path: '/saved', builder: (_, _) => const SavedListsScreen()),
    GoRoute(path: '/history', builder: (_, _) => const HistoryScreen()),
  ],
);
