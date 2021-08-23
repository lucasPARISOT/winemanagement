import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_themes.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.instanceOf(context).theme.backgroundColor,
      body: Center(child: Image.asset('assets/images/wine_bottle.png')),
    );
  }
}