# Diliow — QueFaire

> **Decision-maker mobile app** — Spin a wheel, flip a coin, pick from a list, or ask yes/no. Built with Flutter for Android (Play Store), with iOS roadmap.

This README is the **single source of truth** for the project. An autonomous coding agent should be able to build the MVP from this document alone, without further clarification.

---

## 1. Project overview

| Item | Value |
|---|---|
| **App name (brand)** | Diliow |
| **Play Store title (EN)** | `Diliow — What to Do` |
| **Play Store title (FR)** | `Diliow: QueFaire` |
| **Package name** | `com.boukarydiallo.diliow` |
| **Min SDK** | 23 (Android 6.0) |
| **Target SDK** | 35 (Android 15) |
| **Flutter channel** | stable, ≥ 3.24 |
| **Dart SDK** | ≥ 3.5.0 |
| **Languages** | English (default), French |
| **Monetization V1** | None (100% free, no ads, no IAP) |
| **Deadline** | 5 days dev + 14 days closed testing |

### Goals
1. Ship a Play Store-publishable MVP fast.
2. Pass Google Play closed-testing requirements (12 testers × 14 days).
3. Build a foundation that can scale to V1.1 features (dice, group picker, themes, stats).

### Non-goals (V1)
- No backend, no auth, no cloud sync.
- No ads, no IAP, no analytics SDK (except Play Console default).
- No iOS build (project must remain iOS-compatible, but Android is the only build target now).

---

## 2. Tech stack

### Runtime dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State management
  flutter_riverpod: ^2.5.1

  # Navigation
  go_router: ^14.2.0

  # Local persistence
  hive_ce: ^2.10.1
  hive_ce_flutter: ^2.0.1
  path_provider: ^2.1.4

  # Models
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0

  # UI / UX
  google_fonts: ^6.2.1
  flutter_animate: ^4.5.0
  intl: ^0.19.0

  # Sharing
  share_plus: ^10.0.0
  path: ^1.9.0

  # Utility
  uuid: ^4.5.1
  collection: ^1.18.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  build_runner: ^2.4.13
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  hive_ce_generator: ^1.7.0
  flutter_launcher_icons: ^0.14.1
  flutter_native_splash: ^2.4.1
```

### State management
**Riverpod 2.x** with the modern `NotifierProvider` / `AsyncNotifierProvider` syntax. **Do not use `StateNotifier`** (deprecated pattern). Use code-generation-free Riverpod (no `riverpod_generator`) to keep the build simple.

### Navigation
**go_router** with a `StatefulShellRoute` is overkill for 4 screens — use a flat `GoRouter` with named routes:
- `/` → HomeScreen
- `/wheel` → WheelScreen
- `/coin` → CoinScreen
- `/list` → ListPickerScreen
- `/yesno` → YesNoScreen
- `/saved` → SavedListsScreen
- `/history` → HistoryScreen
- `/onboarding` → OnboardingScreen (shown only on first launch)

### Persistence
**Hive CE** (community-maintained fork). Three boxes:
- `saved_lists` — user-saved reusable lists (`Map<String, SavedList>`)
- `history` — last 20 decision records (`List<DecisionRecord>`)
- `settings` — onboarding flag, theme preference, haptics on/off (`Map<String, dynamic>`)

---

## 3. Folder structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart                       # MaterialApp.router + ProviderScope
│   ├── router.dart                    # GoRouter configuration
│   └── theme/
│       ├── app_theme.dart             # ThemeData.light() + ThemeData.dark()
│       ├── colors.dart                # AppColors class with all tokens
│       └── typography.dart            # AppTextStyles using Google Fonts Inter
├── core/
│   ├── extensions/
│   │   ├── context_extensions.dart    # context.colors, context.textStyles
│   │   └── string_extensions.dart
│   ├── utils/
│   │   ├── haptics.dart               # HapticsService wrapper (respects user setting)
│   │   ├── result_share.dart          # Build shareable text from DecisionRecord
│   │   └── random_helper.dart         # Seeded Random for testable picks
│   └── widgets/
│       ├── primary_button.dart        # Full-width teal CTA
│       ├── secondary_button.dart      # Outlined alternative
│       ├── mode_card.dart             # Reusable card for home grid
│       └── result_reveal.dart         # Animated reveal of any result
├── features/
│   ├── home/
│   │   └── presentation/
│   │       └── home_screen.dart       # 2x2 grid of mode cards + saved lists CTA
│   ├── wheel/
│   │   ├── domain/
│   │   │   └── wheel_segment.dart     # @freezed: id, label, color
│   │   ├── presentation/
│   │   │   ├── wheel_screen.dart
│   │   │   └── widgets/
│   │   │       ├── spinning_wheel.dart    # CustomPainter + AnimationController
│   │   │       └── segment_editor.dart    # Bottom sheet to edit segments
│   │   └── providers/
│   │       └── wheel_provider.dart    # NotifierProvider<WheelNotifier, List<WheelSegment>>
│   ├── coin/
│   │   ├── domain/
│   │   │   └── coin_side.dart         # enum: heads, tails
│   │   ├── presentation/
│   │   │   └── coin_screen.dart       # 3D flip animation
│   │   └── providers/
│   │       └── coin_provider.dart
│   ├── list_picker/
│   │   ├── domain/
│   │   │   └── list_picker_state.dart # @freezed: options, lastPick
│   │   ├── presentation/
│   │   │   ├── list_picker_screen.dart
│   │   │   └── widgets/
│   │   │       └── option_input.dart
│   │   └── providers/
│   │       └── list_picker_provider.dart
│   ├── yes_no/
│   │   ├── domain/
│   │   │   └── yes_no_answer.dart     # enum + extension for emoji
│   │   ├── presentation/
│   │   │   └── yes_no_screen.dart     # Big question field + dramatic reveal
│   │   └── providers/
│   │       └── yes_no_provider.dart
│   ├── saved_lists/
│   │   ├── domain/
│   │   │   └── saved_list.dart        # @freezed + @HiveType: id, name, options, createdAt
│   │   ├── data/
│   │   │   └── saved_lists_repository.dart  # Hive box wrapper
│   │   ├── presentation/
│   │   │   ├── saved_lists_screen.dart
│   │   │   └── widgets/
│   │   │       └── saved_list_tile.dart
│   │   └── providers/
│   │       └── saved_lists_provider.dart    # AsyncNotifierProvider
│   ├── history/
│   │   ├── domain/
│   │   │   └── decision_record.dart   # @freezed + @HiveType: id, mode, result, timestamp
│   │   ├── data/
│   │   │   └── history_repository.dart
│   │   ├── presentation/
│   │   │   └── history_screen.dart
│   │   └── providers/
│   │       └── history_provider.dart
│   └── onboarding/
│       └── presentation/
│           └── onboarding_screen.dart # 2 pages: welcome + how-to
└── l10n/
    ├── app_en.arb
    ├── app_fr.arb
    └── l10n.yaml                       # gen-class: AppLocalizations
```

---

## 4. Feature specifications

### 4.1 Wheel (hero feature)
- **Default state**: 6 segments labeled "Option 1" → "Option 6" with alternating colors from the palette.
- **Edit**: tap pencil icon → bottom sheet with editable list (add / remove / rename segments). Min 2 segments, max 12.
- **Spin**: tap center "Spin" button → wheel rotates with `Curves.decelerate`, 3–5 seconds duration, random end angle.
- **Result reveal**: when wheel stops, the winning segment scales up briefly with haptic medium impact, then a result card slides in from the bottom with the chosen label.
- **Persistence**: segment configuration auto-saves to Hive (key `wheel_segments`).
- **Implementation**: use `CustomPainter` to draw the wheel; use `AnimationController` + `Tween<double>` for the rotation. Do NOT use a third-party fortune-wheel package.

### 4.2 Coin flip
- **Animation**: 3D flip using `Transform(matrix: Matrix4.rotationX(...))`, 1.2-second duration, 4–6 half-rotations, random end side.
- **Display**: large coin image with simple "H" / "T" letters (drawn with `CustomPainter`, no external assets).
- **Haptic**: light impact on flip start, medium on landing.
- **Result reveal**: text "Heads" / "Tails" with `flutter_animate` fade + scale.

### 4.3 Pick from list
- **Input**: text field at top, "Add" button. Options shown as chips below.
- **Empty state**: friendly placeholder text "Add at least 2 options".
- **Pick**: big "Pick one" CTA at bottom (disabled if fewer than 2 options).
- **Animation**: chips shake rapidly (250ms), then non-winners fade to 30% opacity, winner scales to 1.15× with haptic medium.
- **Load from saved**: top-right icon opens a bottom sheet listing saved lists; tap one to populate the input.
- **Save**: floating "Save list" button if options.length ≥ 2 and not already saved.

### 4.4 Yes / No
- **Input**: large question text field, placeholder "What's on your mind?".
- **CTA**: big "Decide" button (disabled if question is empty).
- **Logic**: weighted random — 45% Yes, 45% No, 10% "Maybe" (adds delightful unpredictability).
- **Reveal**: full-screen color flash (green for Yes, red for No, amber for Maybe), 0.5s, then the verdict in 64pt Inter Bold, with haptic heavy impact.
- **History**: question + answer both saved.

### 4.5 Saved lists
- List view sorted by `updatedAt DESC`.
- Tile shows name, option count, last used.
- Tap → opens List Picker pre-populated.
- Swipe-to-delete (with undo snackbar).
- "+" FAB to create new list directly.

### 4.6 History
- Reverse-chronological list of decision records (mode icon + result + relative time "2h ago").
- Tap a record → share or replay.
- Auto-trim to 20 most recent entries.
- "Clear all" action with confirmation dialog.

### 4.7 Onboarding (first launch only)
- 2 screens with `PageView`:
  1. **Welcome**: logo, tagline "Stuck? Let Diliow decide.", "Get started" button.
  2. **How it works**: visual showing the 4 modes, "Let's go" button → marks `onboarding_complete` in settings box and routes to `/`.

---

## 5. Data models

All models use `freezed` for immutability + JSON serialization, and `hive_ce_generator` for persistence where needed.

### `SavedList` (persisted)
```dart
@freezed
@HiveType(typeId: 0)
class SavedList with _$SavedList {
  const factory SavedList({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required List<String> options,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) required DateTime updatedAt,
  }) = _SavedList;
}
```

### `DecisionRecord` (persisted)
```dart
@freezed
@HiveType(typeId: 1)
class DecisionRecord with _$DecisionRecord {
  const factory DecisionRecord({
    @HiveField(0) required String id,
    @HiveField(1) required DecisionMode mode,    // enum @HiveType(typeId: 2)
    @HiveField(2) required String result,
    @HiveField(3) String? question,              // for yes/no mode
    @HiveField(4) required DateTime timestamp,
  }) = _DecisionRecord;
}

@HiveType(typeId: 2)
enum DecisionMode {
  @HiveField(0) wheel,
  @HiveField(1) coin,
  @HiveField(2) list,
  @HiveField(3) yesNo,
}
```

### `WheelSegment` (in-memory, persisted as JSON in settings box)
```dart
@freezed
class WheelSegment with _$WheelSegment {
  const factory WheelSegment({
    required String id,
    required String label,
    required int colorIndex,    // index into AppColors.wheelPalette
  }) = _WheelSegment;
}
```

---

## 6. Design system

### 6.1 Color tokens (`lib/app/theme/colors.dart`)

```dart
class AppColors {
  // Brand
  static const primary = Color(0xFF00B8A9);       // Teal
  static const primaryDark = Color(0xFF008B80);
  static const accent = Color(0xFFFF6B6B);        // Coral

  // Light mode
  static const bgLight = Color(0xFFFAFAFC);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const textLight = Color(0xFF1A1A22);
  static const mutedLight = Color(0xFF8E8E93);
  static const borderLight = Color(0xFFE5E5EA);

  // Dark mode
  static const bgDark = Color(0xFF0F0F14);
  static const surfaceDark = Color(0xFF1A1A22);
  static const textDark = Color(0xFFF5F5F7);
  static const mutedDark = Color(0xFF8E8E93);
  static const borderDark = Color(0xFF2C2C36);

  // Semantic
  static const success = Color(0xFF34C759);
  static const danger = Color(0xFFFF3B30);
  static const warning = Color(0xFFFFCC00);

  // Wheel palette (8 distinct colors that work on both light/dark)
  static const wheelPalette = [
    Color(0xFF00B8A9), Color(0xFFFF6B6B), Color(0xFF34C759),
    Color(0xFFFFCC00), Color(0xFFEC4899), Color(0xFFFF9500),
    Color(0xFFAF52DE), Color(0xFF5AC8FA),
  ];
}
```

### 6.2 Typography (`lib/app/theme/typography.dart`)
Use `GoogleFonts.interTextTheme()` and override the relevant weights:
- `displayLarge` — 32 / w700 / -0.5 letterSpacing
- `displayMedium` — 28 / w600
- `titleLarge` — 22 / w600
- `titleMedium` — 17 / w500
- `bodyLarge` — 16 / w400 / 1.5 line-height
- `bodyMedium` — 14 / w400
- `labelLarge` — 14 / w500 (buttons)
- `labelSmall` — 12 / w500

### 6.3 Spacing
Use multiples of 4: `4, 8, 12, 16, 20, 24, 32, 48`. Default screen padding: `20px` horizontal, `16px` vertical between cards.

### 6.4 Corner radii
- Buttons: `12px`
- Cards: `18px`
- Sheets: `24px` top corners
- Pills / chips: full (height / 2)

### 6.5 Elevation
**Use flat surfaces with subtle borders, not shadows.** Border: `0.5px solid AppColors.borderLight` (or `borderDark`). Exception: result reveal card may use a `BoxShadow` with `0.08` opacity for emphasis.

### 6.6 Voice & tone
| Context | English | French |
|---|---|---|
| Tagline | Stuck? Let Diliow decide. | Bloqué ? Diliow tranche. |
| Empty home subtitle | What's the verdict? | Quel est le verdict ? |
| Result reveal | The verdict is in ✨ | Verdict ! ✨ |
| Yes / No prompt | What's on your mind? | Quelle est la question ? |
| Spin CTA | Spin | Tourner |
| Empty list state | Add at least 2 options | Ajoute au moins 2 options |
| Clear history confirm | Clear all decisions? | Effacer tout l'historique ? |

---

## 7. Localization

Use Flutter's standard `gen_l10n` workflow. `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

**All user-facing strings must come from `AppLocalizations.of(context)`** — no hardcoded text in widgets.

Both ARB files (`app_en.arb`, `app_fr.arb`) must have identical keys. Sample keys to include:
- `appName`, `appTagline`
- `home_subtitle`, `home_mode_wheel`, `home_mode_coin`, `home_mode_list`, `home_mode_yesno`, `home_saved_lists`
- `wheel_spin_cta`, `wheel_edit_segments`, `wheel_min_segments_error`
- `coin_heads`, `coin_tails`, `coin_flip_cta`
- `list_add_placeholder`, `list_pick_cta`, `list_empty_state`, `list_save_cta`
- `yesno_placeholder`, `yesno_decide_cta`, `yesno_answer_yes`, `yesno_answer_no`, `yesno_answer_maybe`
- `saved_lists_title`, `saved_lists_empty`, `saved_list_delete_confirm`
- `history_title`, `history_empty`, `history_clear_all`, `history_clear_confirm`
- `onboarding_welcome_title`, `onboarding_welcome_body`, `onboarding_cta_next`, `onboarding_cta_start`
- `share_result_template` ("Diliow chose: {result}")

---

## 8. Routing

```dart
final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final box = Hive.box('settings');
    final onboardingDone = box.get('onboarding_complete', defaultValue: false);
    if (!onboardingDone && state.matchedLocation != '/onboarding') {
      return '/onboarding';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/wheel', builder: (_, __) => const WheelScreen()),
    GoRoute(path: '/coin', builder: (_, __) => const CoinScreen()),
    GoRoute(path: '/list', builder: (_, __) => const ListPickerScreen()),
    GoRoute(path: '/yesno', builder: (_, __) => const YesNoScreen()),
    GoRoute(path: '/saved', builder: (_, __) => const SavedListsScreen()),
    GoRoute(path: '/history', builder: (_, __) => const HistoryScreen()),
  ],
);
```

---

## 9. Animations guidelines
- Default duration: `200ms` for UI transitions, `400ms` for emphasis.
- Curve: `Curves.easeOutCubic` for arrivals, `Curves.easeInCubic` for exits.
- Wheel spin: `Curves.decelerate`, 3–5 seconds.
- Coin flip: 1.2 seconds, custom curve `Cubic(0.2, 0.0, 0.2, 1.0)`.
- Result reveal: `flutter_animate` chain → `.fadeIn(duration: 300ms).scale(begin: 0.85, end: 1.0, duration: 400ms, curve: Curves.elasticOut)`.

---

## 10. Haptics

Wrap `HapticFeedback` in a service that checks the user's setting (default ON):
- Mode card tap → `selectionClick`
- Spin / flip start → `lightImpact`
- Result reveal → `mediumImpact`
- Yes/No reveal → `heavyImpact`
- Destructive confirm → `heavyImpact`

---

## 11. Build & release

### 11.1 App icons & splash
```bash
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

Config in `pubspec.yaml`:
```yaml
flutter_launcher_icons:
  android: true
  ios: false
  image_path: "assets/icon/icon.png"          # 1024×1024 PNG
  adaptive_icon_background: "#00B8A9"
  adaptive_icon_foreground: "assets/icon/icon_foreground.png"

flutter_native_splash:
  color: "#FAFAFC"
  color_dark: "#0F0F14"
  image: "assets/splash/logo.png"
  android_12:
    image: "assets/splash/logo.png"
    color: "#FAFAFC"
    color_dark: "#0F0F14"
```

### 11.2 Release build
```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 11.3 Signing
Generate upload keystore once:
```bash
keytool -genkey -v -keystore ~/diliow-upload.keystore -alias diliow \
  -keyalg RSA -keysize 2048 -validity 10000
```

`android/key.properties` (gitignored):
```
storePassword=...
keyPassword=...
keyAlias=diliow
storeFile=/Users/.../diliow-upload.keystore
```

Wire into `android/app/build.gradle` per Flutter docs.

### 11.4 Play Console checklist
- [ ] App name (per locale): `Diliow — What to Do` (en), `Diliow: QueFaire` (fr)
- [ ] Short description (80 char) per locale
- [ ] Full description (4000 char) per locale
- [ ] 2 screenshots min per device type (phone, 7" tablet, 10" tablet) per locale — **use the in-app screens with real content, not Lorem Ipsum**
- [ ] Feature graphic 1024×500 PNG
- [ ] App icon 512×512 PNG
- [ ] Privacy policy URL (host on GitHub Pages — single static HTML page, see `docs/privacy.md`)
- [ ] Content rating questionnaire (answer: no violence, no user content, no ads → rating: 3+)
- [ ] Data safety form: **declare zero data collection** (everything is local)
- [ ] Target audience: 13+
- [ ] App category: Tools (primary) / Lifestyle (secondary)
- [ ] Tags: utility, decision-maker, random, picker
- [ ] Closed testing track: invite ≥ 12 testers, keep active ≥ 14 days

---

## 12. Coding conventions

- Use `const` constructors wherever possible.
- Prefer `final` over `var`; use `var` only when type is obvious from RHS.
- File names: `snake_case.dart`.
- Class names: `PascalCase`.
- Private members: `_leadingUnderscore`.
- Providers naming: `xxxProvider` (e.g. `wheelProvider`, `savedListsProvider`).
- Notifiers naming: `XxxNotifier extends Notifier<T>`.
- No `print()` — use `debugPrint()` and wrap in `kDebugMode` if needed.
- Lint: enable `flutter_lints` defaults, no overrides for V1.
- Tests: at minimum, unit tests for `WheelNotifier`, `ListPickerNotifier`, `YesNoNotifier` random logic (use seeded `Random`).

---

## 13. Day-by-day plan (5 days)

| Day | Deliverable |
|---|---|
| **D1** | `flutter create diliow`, full `pubspec.yaml`, theme system (colors, typography, app_theme), `main.dart` with `ProviderScope` + Hive init, router skeleton, l10n setup, empty screens for all 7 routes. |
| **D2** | Home screen with 4 mode cards (matches mockup), onboarding (2 pages), navigation working end-to-end, History screen with mock data. |
| **D3** | Wheel mode (CustomPainter + animation + segment editor), Coin flip (3D animation), wire to history repository. |
| **D4** | List picker mode + saved lists (Hive integration), Yes/No mode, result share, haptics service, settings persistence. |
| **D5** | App icon + splash, screenshots (in-app screen captures with realistic content), privacy policy HTML, release build, Play Console upload, invite 12 testers. |

---

## 14. Definition of done (V1)

- [ ] App builds successfully in `--release` mode.
- [ ] All 4 modes work end-to-end with no crashes.
- [ ] Saved lists persist across app restarts.
- [ ] History records each decision and persists.
- [ ] Light + dark mode both polished.
- [ ] EN + FR strings complete, no hardcoded text.
- [ ] Haptic feedback fires on all relevant interactions.
- [ ] Sharing a result produces clean text via native share sheet.
- [ ] App passes `flutter analyze` with zero warnings.
- [ ] AAB uploaded to Play Console closed testing track.
- [ ] Privacy policy published and linked.

---

## 15. Out-of-scope (do not build in V1)

- Dice mode (multi-faced d4/d6/d8/d10/d20)
- Group picker (split a list into N teams)
- Stats screen (charts of decision patterns)
- Premium themes / IAP
- Custom sounds on reveal
- Cloud sync / account system
- Widget (home screen widget)
- iOS build & TestFlight submission

These are deliberately deferred to V1.1+. The agent must **not** implement them, even if asked. Flag any such requests back to the human owner.
