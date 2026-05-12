// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Diliow';

  @override
  String get appTagline => 'Bloqué ? Diliow tranche.';

  @override
  String get home_subtitle => 'Quel est le verdict ?';

  @override
  String get home_mode_wheel => 'Roue';

  @override
  String get home_mode_wheel_sub => 'Tourne pour choisir';

  @override
  String get home_mode_coin => 'Pile ou face';

  @override
  String get home_mode_coin_sub => 'Tire au sort';

  @override
  String get home_mode_list => 'Choisir une option';

  @override
  String get home_mode_list_sub => 'Dans ta liste';

  @override
  String get home_mode_yesno => 'Oui / Non';

  @override
  String get home_mode_yesno_sub => 'Pose la question';

  @override
  String get home_saved_lists => 'Listes enregistrées';

  @override
  String get home_history => 'Historique';

  @override
  String get wheel_title => 'Roue';

  @override
  String get wheel_spin_cta => 'Tourner';

  @override
  String get wheel_edit_segments => 'Modifier les segments';

  @override
  String get wheel_min_segments_error => 'Il faut au moins 2 segments';

  @override
  String get wheel_max_segments_error => 'Maximum 12 segments';

  @override
  String get wheel_segment_add => 'Ajouter un segment';

  @override
  String wheel_default_segment(int index) {
    return 'Option $index';
  }

  @override
  String get coin_title => 'Pièce';

  @override
  String get coin_heads => 'Pile';

  @override
  String get coin_tails => 'Face';

  @override
  String get coin_flip_cta => 'Lancer';

  @override
  String get list_title => 'Choisir';

  @override
  String get list_add_placeholder => 'Ajouter une option';

  @override
  String get list_pick_cta => 'Choisir';

  @override
  String get list_empty_state => 'Ajoute au moins 2 options';

  @override
  String get list_save_cta => 'Enregistrer la liste';

  @override
  String get list_load_saved => 'Charger une liste enregistrée';

  @override
  String get list_saved_toast => 'Liste enregistrée';

  @override
  String get yesno_title => 'Oui ou non';

  @override
  String get yesno_placeholder => 'Quelle est la question ?';

  @override
  String get yesno_decide_cta => 'Décider';

  @override
  String get yesno_answer_yes => 'Oui';

  @override
  String get yesno_answer_no => 'Non';

  @override
  String get yesno_answer_maybe => 'Peut-être';

  @override
  String get saved_lists_title => 'Listes enregistrées';

  @override
  String get saved_lists_empty => 'Aucune liste enregistrée';

  @override
  String get saved_list_delete_confirm => 'Supprimer cette liste ?';

  @override
  String get saved_list_deleted => 'Liste supprimée';

  @override
  String get saved_list_undo => 'Annuler';

  @override
  String get saved_list_name_placeholder => 'Nom de la liste';

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
  String get history_title => 'Historique';

  @override
  String get history_empty => 'Aucune décision pour l\'instant';

  @override
  String get history_clear_all => 'Tout effacer';

  @override
  String get history_clear_confirm => 'Effacer tout l\'historique ?';

  @override
  String get history_share => 'Partager';

  @override
  String get history_replay => 'Rejouer';

  @override
  String get onboarding_welcome_title => 'Bloqué ? Diliow tranche.';

  @override
  String get onboarding_welcome_body =>
      'Tourne une roue, lance une pièce, choisis dans une liste ou pose une question oui/non.';

  @override
  String get onboarding_how_title => 'Quatre façons de décider';

  @override
  String get onboarding_how_body =>
      'Roue, pièce, liste ou oui/non — choisis ta méthode, Diliow s\'occupe du reste.';

  @override
  String get onboarding_cta_next => 'Suivant';

  @override
  String get onboarding_cta_start => 'C\'est parti';

  @override
  String share_result_template(String result) {
    return 'Diliow a choisi : $result';
  }

  @override
  String get common_cancel => 'Annuler';

  @override
  String get common_delete => 'Supprimer';

  @override
  String get common_save => 'Enregistrer';

  @override
  String get common_done => 'Terminé';

  @override
  String get common_back => 'Retour';

  @override
  String get verdict_label => 'Verdict !';
}
