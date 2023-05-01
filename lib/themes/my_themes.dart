import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light();

  static final ThemeData darkTheme = ThemeData.dark();

  ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}