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
          Locale('en', 'US'),
          Locale('fr', 'FR'),
          Locale('es', 'ES'),
          Locale('pt', 'PT'),
          Locale('it', 'IT'),
          Locale('el', 'GR'),
          Locale('de', 'DE'),
          Locale('ru', 'RU')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child:  const MyApp(),
      ),
    )
  );
}