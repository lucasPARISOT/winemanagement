import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'custom_themes.dart';
import 'my_themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  MyThemeKeys theme = MyThemeKeys.DARK;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('theme')){
    prefs.setString('theme', 'MyThemeKeys.DARK');
  }
  else {
    String? code = prefs.getString('theme');
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
        supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR'), Locale('es','ES')],
        path: 'assets/translations',
        fallbackLocale: Locale('fr', 'FR'),
        child:  MyApp(),
      ),
    )
  );
}