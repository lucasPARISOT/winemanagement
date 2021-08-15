import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'custom_themes.dart';
import 'my_home_page.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
        const Locale('es', 'ES'),
        const Locale('pt', 'PT')
      ],
      locale: null,
      title: tr('wine_management'),
      theme: CustomTheme.of(context),
      home: MyHomePage(theme: CustomTheme.of(context)),
    );
  }
}

