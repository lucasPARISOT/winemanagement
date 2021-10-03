import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:winemanagement/app.dart';
import 'package:winemanagement/custom_themes.dart';
import 'package:winemanagement/my_themes.dart';

/// Entry point of this application
/// Widget, Localization and ThemeData initializations
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();

  MyThemeKeys theme = MyThemeKeys.DARK;

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('theme')){
    prefs.setString('theme', 'MyThemeKeys.DARK');
  }
  else {
    final String? code = prefs.getString('theme');
    switch(code) {
      case 'MyThemeKeys.DARK':
        theme = MyThemeKeys.DARK;
        break;
      case 'MyThemeKeys.LIGHT':
        theme = MyThemeKeys.LIGHT;
        break;
      case 'MyThemeKeys.CUSTOM':
        theme = MyThemeKeys.CUSTOM;
        break;
    }
  }
  runApp(
    CustomTheme(
      initialThemeKey: theme,
      child: EasyLocalization(
        supportedLocales: const [
          Locale('bg', 'BG'),
          Locale('zh', 'CN'),
          Locale('da', 'DK'),
          Locale('nl', 'NL'),
          Locale('en', 'US'),
          Locale('et', 'EE'),
          Locale('fi', 'FI'),
          Locale('fr', 'FR'),
          Locale('de', 'DE'),
          Locale('el', 'GR'),
          Locale('hu', 'HU'),
          Locale('it', 'IT'),
          Locale('ja', 'JP'),
          Locale('lv', 'LV'),
          Locale('lt', 'LT'),
          Locale('pl', 'PL'),
          Locale('pt', 'PT'),
          Locale('ro', 'RO'),
          Locale('ru', 'RU'),
          Locale('es', 'ES'),
          Locale('sv', 'SE'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child:  const MyApp(),
      ),
    )
  );
}