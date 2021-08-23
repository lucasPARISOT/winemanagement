import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_themes.dart';
import 'init.dart';
import 'my_home_page.dart';
import 'splash.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('fr', 'FR'),
              const Locale('es', 'ES'),
              const Locale('pt', 'PT'),
              const Locale('el', 'GR'),
              const Locale('it', 'IT')
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
