import 'package:easy_localization/easy_localization.dart';

import '../localization/locale_keys.g.dart';

extension DateTimeExtension on DateTime {
  String get gettimeDifference {
    var diff = DateTime.now().difference(this);
    if (diff.inDays > 0) {
      return diff.inDays.toString() + LocaleKeys.day_abbreviation.tr();
    }
    if (diff.inHours > 0) {
      return diff.inHours.toString() + LocaleKeys.hour_abbreviation.tr();
    }
    if (diff.inMinutes > 0) {
      return diff.inMinutes.toString() + LocaleKeys.minute_abbreviation.tr();
    }
    if (diff.inSeconds > 0) {
      return diff.inSeconds.toString() + LocaleKeys.second_abbreviation.tr();
    }
    return '';
  }
}
