import 'app.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR'), Locale('es','ES')],
        path: 'assets/translations',
        fallbackLocale: Locale('fr', 'FR'),
        child:  MyApp(),
    )
  );
}