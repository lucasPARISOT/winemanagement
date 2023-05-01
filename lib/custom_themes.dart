import 'package:flutter/material.dart';

import 'package:winemanagement/my_themes.dart';

class _CustomTheme extends InheritedWidget {

  const _CustomTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final CustomThemeState data;

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

/// This class contains custom themes
class CustomTheme extends StatefulWidget {
  /// Constructor
  const CustomTheme({
    required this.initialThemeKey,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final MyThemeKeys initialThemeKey;

  @override
  CustomThemeState createState() => CustomThemeState();

  static ThemeData of(BuildContext context) {
    final _CustomTheme? inherited =
    context.dependOnInheritedWidgetOfExactType<_CustomTheme>();
    return inherited!.data.theme;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    final _CustomTheme? inherited =
    context.dependOnInheritedWidgetOfExactType<_CustomTheme>();
    return inherited!.data;
  }
}

/// This class is used to init Themes
/// Change between predefined Themes or custom ones
class CustomThemeState extends State<CustomTheme> {
  late ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  void initState() {
    final MyThemes myThemes = MyThemes();
    _theme = myThemes.getThemeFromKey(widget.initialThemeKey);
    super.initState();
  }

  void changeTheme(MyThemeKeys themeKey) {
    setState(() {
      final MyThemes myThemes = MyThemes();
      _theme = myThemes.getThemeFromKey(themeKey);
    });
  }

  void newCustomTheme(ThemeData themeData) {
    setState(() {
      _theme = themeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(
      data: this,
      child: widget.child,
    );
  }
}