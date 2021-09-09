import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:winemanagement/custom_themes.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.instanceOf(context).theme.backgroundColor,
      body: Center(child: Image.asset('assets/images/wine_bottle.png')),
    );
  }
}