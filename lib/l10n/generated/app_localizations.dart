import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Dilio'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Stuck? Let Dilio decide.'**
  String get appTagline;

  /// No description provided for @home_subtitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s the verdict?'**
  String get home_subtitle;

  /// No description provided for @home_mode_wheel.
  ///
  /// In en, this message translates to:
  /// **'Spin the wheel'**
  String get home_mode_wheel;

  /// No description provided for @home_mode_coin.
  ///
  /// In en, this message translates to:
  /// **'Flip a coin'**
  String get home_mode_coin;

  /// No description provided for @home_mode_list.
  ///
  /// In en, this message translates to:
  /// **'Pick from a list'**
  String get home_mode_list;

  /// No description provided for @home_mode_yesno.
  ///
  /// In en, this message translates to:
  /// **'Yes or no'**
  String get home_mode_yesno;

  /// No description provided for @home_saved_lists.
  ///
  /// In en, this message translates to:
  /// **'Saved lists'**
  String get home_saved_lists;

  /// No description provided for @home_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get home_history;

  /// No description provided for @wheel_title.
  ///
  /// In en, this message translates to:
  /// **'Wheel'**
  String get wheel_title;

  /// No description provided for @wheel_spin_cta.
  ///
  /// In en, this message translates to:
  /// **'Spin'**
  String get wheel_spin_cta;

  /// No description provided for @wheel_edit_segments.
  ///
  /// In en, this message translates to:
  /// **'Edit segments'**
  String get wheel_edit_segments;

  /// No description provided for @wheel_min_segments_error.
  ///
  /// In en, this message translates to:
  /// **'You need at least 2 segments'**
  String get wheel_min_segments_error;

  /// No description provided for @wheel_max_segments_error.
  ///
  /// In en, this message translates to:
  /// **'Maximum 12 segments'**
  String get wheel_max_segments_error;

  /// No description provided for @wheel_segment_add.
  ///
  /// In en, this message translates to:
  /// **'Add segment'**
  String get wheel_segment_add;

  /// No description provided for @wheel_default_segment.
  ///
  /// In en, this message translates to:
  /// **'Option {index}'**
  String wheel_default_segment(int index);

  /// No description provided for @coin_title.
  ///
  /// In en, this message translates to:
  /// **'Coin'**
  String get coin_title;

  /// No description provided for @coin_heads.
  ///
  /// In en, this message translates to:
  /// **'Heads'**
  String get coin_heads;

  /// No description provided for @coin_tails.
  ///
  /// In en, this message translates to:
  /// **'Tails'**
  String get coin_tails;

  /// No description provided for @coin_flip_cta.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get coin_flip_cta;

  /// No description provided for @list_title.
  ///
  /// In en, this message translates to:
  /// **'Pick one'**
  String get list_title;

  /// No description provided for @list_add_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Add an option'**
  String get list_add_placeholder;

  /// No description provided for @list_pick_cta.
  ///
  /// In en, this message translates to:
  /// **'Pick one'**
  String get list_pick_cta;

  /// No description provided for @list_empty_state.
  ///
  /// In en, this message translates to:
  /// **'Add at least 2 options'**
  String get list_empty_state;

  /// No description provided for @list_save_cta.
  ///
  /// In en, this message translates to:
  /// **'Save list'**
  String get list_save_cta;

  /// No description provided for @list_load_saved.
  ///
  /// In en, this message translates to:
  /// **'Load saved list'**
  String get list_load_saved;

  /// No description provided for @list_saved_toast.
  ///
  /// In en, this message translates to:
  /// **'List saved'**
  String get list_saved_toast;

  /// No description provided for @yesno_title.
  ///
  /// In en, this message translates to:
  /// **'Yes or no'**
  String get yesno_title;

  /// No description provided for @yesno_placeholder.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get yesno_placeholder;

  /// No description provided for @yesno_decide_cta.
  ///
  /// In en, this message translates to:
  /// **'Decide'**
  String get yesno_decide_cta;

  /// No description provided for @yesno_answer_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesno_answer_yes;

  /// No description provided for @yesno_answer_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get yesno_answer_no;

  /// No description provided for @yesno_answer_maybe.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get yesno_answer_maybe;

  /// No description provided for @saved_lists_title.
  ///
  /// In en, this message translates to:
  /// **'Saved lists'**
  String get saved_lists_title;

  /// No description provided for @saved_lists_empty.
  ///
  /// In en, this message translates to:
  /// **'No saved lists yet'**
  String get saved_lists_empty;

  /// No description provided for @saved_list_delete_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this list?'**
  String get saved_list_delete_confirm;

  /// No description provided for @saved_list_deleted.
  ///
  /// In en, this message translates to:
  /// **'List deleted'**
  String get saved_list_deleted;

  /// No description provided for @saved_list_undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get saved_list_undo;

  /// No description provided for @saved_list_name_placeholder.
  ///
  /// In en, this message translates to:
  /// **'List name'**
  String get saved_list_name_placeholder;

  /// No description provided for @saved_list_option_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 option} other{{count} options}}'**
  String saved_list_option_count(int count);

  /// No description provided for @history_title.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history_title;

  /// No description provided for @history_empty.
  ///
  /// In en, this message translates to:
  /// **'No decisions yet'**
  String get history_empty;

  /// No description provided for @history_clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get history_clear_all;

  /// No description provided for @history_clear_confirm.
  ///
  /// In en, this message translates to:
  /// **'Clear all decisions?'**
  String get history_clear_confirm;

  /// No description provided for @history_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get history_share;

  /// No description provided for @history_replay.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get history_replay;

  /// No description provided for @onboarding_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Stuck? Let Dilio decide.'**
  String get onboarding_welcome_title;

  /// No description provided for @onboarding_welcome_body.
  ///
  /// In en, this message translates to:
  /// **'Spin a wheel, flip a coin, pick from a list, or ask yes or no.'**
  String get onboarding_welcome_body;

  /// No description provided for @onboarding_how_title.
  ///
  /// In en, this message translates to:
  /// **'Four ways to decide'**
  String get onboarding_how_title;

  /// No description provided for @onboarding_how_body.
  ///
  /// In en, this message translates to:
  /// **'Wheel, coin, list picker, or yes/no — choose your method and let Dilio do the rest.'**
  String get onboarding_how_body;

  /// No description provided for @onboarding_cta_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_cta_next;

  /// No description provided for @onboarding_cta_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go'**
  String get onboarding_cta_start;

  /// No description provided for @share_result_template.
  ///
  /// In en, this message translates to:
  /// **'Dilio chose: {result}'**
  String share_result_template(String result);

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get common_done;

  /// No description provided for @common_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get common_back;

  /// No description provided for @verdict_label.
  ///
  /// In en, this message translates to:
  /// **'The verdict is in'**
  String get verdict_label;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
