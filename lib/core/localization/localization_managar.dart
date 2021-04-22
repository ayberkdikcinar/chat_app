import 'package:flutter/cupertino.dart';

class LocalizationManager {
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    _instance ??= LocalizationManager._init();
    return _instance!;
  }

  LocalizationManager._init();

  final enLocale = Locale('en', 'US');

  List<Locale> get supportedLocales => [enLocale];
}
