import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'custom_themes.dart';
import 'my_themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.DARK,
      child: EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR'), Locale('es','ES')],
        path: 'assets/translations',
        fallbackLocale: Locale('fr', 'FR'),
        child:  MyApp(),
      ),
    )
  );
}