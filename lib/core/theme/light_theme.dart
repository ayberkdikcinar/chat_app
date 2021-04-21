import 'package:flutter/material.dart';

import 'ITheme.dart';

class LightTheme extends ITheme {
  static LightTheme? _instance;
  static LightTheme get instance {
    if (_instance == null) {
      _instance = LightTheme._init();
    }
    return _instance!;
  }

  LightTheme._init();

  final ThemeData _lightTheme = ThemeData.light();
  @override
  ThemeData? get themeData => ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: _lightTheme.appBarTheme.copyWith(backgroundColor: Colors.white),
        backgroundColor: _lightTheme.backgroundColor,
        accentColor: Color(0xFF44C551),
        scaffoldBackgroundColor: Colors.white,
        highlightColor: Color(0xFFFFFFFF),
        cardColor: Color(0xFFD7DBDD),
      );
}
