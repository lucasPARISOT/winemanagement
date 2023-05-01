import 'package:flutter/material.dart';

import 'package:winemanagement/custom_themes.dart';

/// This class is for the splash screen loading at first launch
class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.instanceOf(context).theme.colorScheme.background,
      body: Center(child: Image.asset('assets/images/wine_bottle.png')),
    );
  }
}