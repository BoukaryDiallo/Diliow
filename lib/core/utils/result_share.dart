import 'package:share_plus/share_plus.dart';

import '../../l10n/generated/app_localizations.dart';

class ResultShare {
  ResultShare._();

  static Future<void> shareResult(AppLocalizations l10n, String result) async {
    final text = l10n.share_result_template(result);
    await Share.share(text);
  }
}
