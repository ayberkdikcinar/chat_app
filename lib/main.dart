import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation/default_tab_view.dart';
import 'bottom_navigation/default_tab_viewmodel.dart';
import 'core/constants/app_constants.dart';
import 'core/localization/locale_keys.g.dart';
import 'core/localization/localization_managar.dart';
import 'core/navigation/INavigation.dart';
import 'core/navigation/navigation_service.dart';
import 'core/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DefaultTabViewModel()),
    ],
    child: EasyLocalization(
      path: ApplicationConstant.LANG_PATH,
      supportedLocales: LocalizationManager.instance.supportedLocales,
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.app_title.tr(),
      home: DefaulTabView(),
      theme: LightTheme.instance.themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
