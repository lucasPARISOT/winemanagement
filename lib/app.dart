import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: [
        const Locale('fr', 'FR'),
        const Locale('en', 'US'),
        const Locale('es','ES'),
      ],
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

