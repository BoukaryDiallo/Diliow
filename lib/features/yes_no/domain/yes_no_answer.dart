import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

enum YesNoAnswer { yes, no, maybe }

extension YesNoAnswerX on YesNoAnswer {
  String get emoji {
    switch (this) {
      case YesNoAnswer.yes:
        return '✅';
      case YesNoAnswer.no:
        return '❌';
      case YesNoAnswer.maybe:
        return '🤔';
    }
  }

  Color get color {
    switch (this) {
      case YesNoAnswer.yes:
        return AppColors.success;
      case YesNoAnswer.no:
        return AppColors.danger;
      case YesNoAnswer.maybe:
        return AppColors.warning;
    }
  }

  String label(String yes, String no, String maybe) {
    switch (this) {
      case YesNoAnswer.yes:
        return yes;
      case YesNoAnswer.no:
        return no;
      case YesNoAnswer.maybe:
        return maybe;
    }
  }
}
