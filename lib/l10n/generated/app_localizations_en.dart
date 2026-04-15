// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Dilio';

  @override
  String get appTagline => 'Stuck? Let Dilio decide.';

  @override
  String get home_subtitle => 'What\'s the verdict?';

  @override
  String get home_mode_wheel => 'Spin the wheel';

  @override
  String get home_mode_coin => 'Flip a coin';

  @override
  String get home_mode_list => 'Pick from a list';

  @override
  String get home_mode_yesno => 'Yes or no';

  @override
  String get home_saved_lists => 'Saved lists';

  @override
  String get home_history => 'History';

  @override
  String get wheel_title => 'Wheel';

  @override
  String get wheel_spin_cta => 'Spin';

  @override
  String get wheel_edit_segments => 'Edit segments';

  @override
  String get wheel_min_segments_error => 'You need at least 2 segments';

  @override
  String get wheel_max_segments_error => 'Maximum 12 segments';

  @override
  String get wheel_segment_add => 'Add segment';

  @override
  String wheel_default_segment(int index) {
    return 'Option $index';
  }

  @override
  String get coin_title => 'Coin';

  @override
  String get coin_heads => 'Heads';

  @override
  String get coin_tails => 'Tails';

  @override
  String get coin_flip_cta => 'Flip';

  @override
  String get list_title => 'Pick one';

  @override
  String get list_add_placeholder => 'Add an option';

  @override
  String get list_pick_cta => 'Pick one';

  @override
  String get list_empty_state => 'Add at least 2 options';

  @override
  String get list_save_cta => 'Save list';

  @override
  String get list_load_saved => 'Load saved list';

  @override
  String get list_saved_toast => 'List saved';

  @override
  String get yesno_title => 'Yes or no';

  @override
  String get yesno_placeholder => 'What\'s on your mind?';

  @override
  String get yesno_decide_cta => 'Decide';

  @override
  String get yesno_answer_yes => 'Yes';

  @override
  String get yesno_answer_no => 'No';

  @override
  String get yesno_answer_maybe => 'Maybe';

  @override
  String get saved_lists_title => 'Saved lists';

  @override
  String get saved_lists_empty => 'No saved lists yet';

  @override
  String get saved_list_delete_confirm => 'Delete this list?';

  @override
  String get saved_list_deleted => 'List deleted';

  @override
  String get saved_list_undo => 'Undo';

  @override
  String get saved_list_name_placeholder => 'List name';

  @override
  String saved_list_option_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count options',
      one: '1 option',
    );
    return '$_temp0';
  }

  @override
  String get history_title => 'History';

  @override
  String get history_empty => 'No decisions yet';

  @override
  String get history_clear_all => 'Clear all';

  @override
  String get history_clear_confirm => 'Clear all decisions?';

  @override
  String get history_share => 'Share';

  @override
  String get history_replay => 'Replay';

  @override
  String get onboarding_welcome_title => 'Stuck? Let Dilio decide.';

  @override
  String get onboarding_welcome_body =>
      'Spin a wheel, flip a coin, pick from a list, or ask yes or no.';

  @override
  String get onboarding_how_title => 'Four ways to decide';

  @override
  String get onboarding_how_body =>
      'Wheel, coin, list picker, or yes/no — choose your method and let Dilio do the rest.';

  @override
  String get onboarding_cta_next => 'Next';

  @override
  String get onboarding_cta_start => 'Let\'s go';

  @override
  String share_result_template(String result) {
    return 'Dilio chose: $result';
  }

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_save => 'Save';

  @override
  String get common_done => 'Done';

  @override
  String get common_back => 'Back';

  @override
  String get verdict_label => 'The verdict is in';
}
