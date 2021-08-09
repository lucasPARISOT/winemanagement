import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, CUSTOM }

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light();

  static final ThemeData darkTheme = ThemeData.dark();

  static final ThemeData customTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.CUSTOM:
        return customTheme;
      default:
        return darkTheme;
    }
  }
}