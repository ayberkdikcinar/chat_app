import 'package:chat_app/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

import 'default_tab_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: DefaulTabView(),
      theme: LightTheme.instance.themeData,
    );
  }
}
