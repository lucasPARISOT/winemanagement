import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:winemanagement/custom_themes.dart';
import 'package:winemanagement/init.dart';
import 'package:winemanagement/my_home_page.dart';
import 'package:winemanagement/splash.dart';

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('fr', 'FR'),
              Locale('es', 'ES'),
              Locale('pt', 'PT'),
              Locale('el', 'GR'),
              Locale('it', 'IT')
            ],
            locale: context.locale,
            title: tr('wine_management'),
            theme: CustomTheme.of(context),
            home: MyHomePage(theme: CustomTheme.of(context)),
          );
        }
      }
    );
  }
}
