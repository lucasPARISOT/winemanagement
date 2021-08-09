import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, CUSTOM }

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light();

  static final ThemeData darkTheme = ThemeData.dark();

  ThemeData customTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );

  ThemeData getCustomTheme() {
    print('GETTING !');
    return customTheme;
  }

  void setCustomTheme(ThemeData theme) {
    this.customTheme = theme;
    print('UPDATED !');
  }

  ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.CUSTOM:
        return getCustomTheme();
      default:
        return darkTheme;
    }
  }
}