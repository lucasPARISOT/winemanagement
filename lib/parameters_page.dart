import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:winemanagement/custom_themes.dart';
import 'package:winemanagement/language_data.dart';
import 'package:winemanagement/language_flag.dart';
import 'package:winemanagement/my_home_page.dart';
import 'package:winemanagement/my_themes.dart';


class ParametersPage extends StatefulWidget {
  const ParametersPage({required this.theme, Key? key}) : super(key: key);

  final ThemeData theme;

  @override
  _ParametersPage createState() => _ParametersPage();
}

/// This class is for the parameter page of this application
class _ParametersPage extends State<ParametersPage> {
  _ParametersPage() {
    getCurrentColor().then((value) => setState(() {
      currentBackgroundColor = value;
    }));
    body = bodyDefault();
  }

  Color currentBackgroundColor = Colors.limeAccent;
  Color currentSecondaryColor = Colors.white;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  Padding? body;

  Future<Color> getCurrentColor() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('backgroundColor')){
      return Colors.black;
    }
    else {
      final int? colorCode = prefs.getInt('backgroundColor');
      return Color(colorCode!);
    }
  }

  void changeLocale(String localeString, BuildContext buildContext) {
    int supportedLocaleIndex = 0;
    switch(localeString) {
      case 'FR':
        supportedLocaleIndex = 1;
        break;
      case 'ES':
        supportedLocaleIndex = 2;
        break;
      case 'PT':
        supportedLocaleIndex = 3;
        break;
      case 'IT':
        supportedLocaleIndex = 4;
        break;
      case 'GR':
        supportedLocaleIndex = 5;
        break;
      case 'DE':
        supportedLocaleIndex = 6;
        break;
    }
    final Locale locale = buildContext.supportedLocales[supportedLocaleIndex];
    setState(() {
      EasyLocalization.of(buildContext)!.setLocale(locale);
    });
  }

  Future<void> changeBackgroundColor(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('backgroundColor', color.value);

    setState(() {
      currentBackgroundColor = color;
    });
  }

  Future<void> changeSecondaryColor(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('secondaryColor', color.value);

    setState(() {
      currentSecondaryColor = color;
    });
  }

  void changeColors(List<Color> colors)
    => setState(() => currentColors = colors);

  void _navigateHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(theme: widget.theme)),
    );
  }

  Future<void> _changeTheme(BuildContext buildContext, MyThemeKeys key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', key.toString());
    prefs.setString('appBarTheme', key.toString());
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  Future<void> _applyTheme(BuildContext buildContext) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('theme', 'MyThemeKeys.CUSTOM');

    Color? backgroundColor;
    if(prefs.containsKey('backgroundColor')){
      final int ?backgroundColorCode = prefs.getInt('backgroundColor');
      backgroundColor = Color(backgroundColorCode!);
    }
    else {
      backgroundColor = Colors.teal;
    }

    Color? secondaryColor;
    if(prefs.containsKey('secondaryColor')){
      final int ?secondaryColorCode = prefs.getInt('secondaryColor');
      secondaryColor = Color(secondaryColorCode!);
    }
    else {
      secondaryColor = Colors.teal;
    }

    final ThemeData oldTheme = CustomTheme.of(context);

    final ThemeData theme = ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      accentColor: secondaryColor,
      primaryColor: oldTheme.primaryColor,
      brightness: oldTheme.brightness,
    );
    CustomTheme.instanceOf(buildContext).newCustomTheme(theme);
  }

  Widget floatingButton() {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(1.0, -0.5),
          child: FloatingActionButton(
            onPressed: _navigateHomePage,
            tooltip: tr('back'),
            child: const Icon(Icons.keyboard_return),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(tr('parameters')),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: tr('open_navigation_menu'),
          );
        },
      ),
    );
  }

  Widget drawer(BuildContext buildContext) {
    return Drawer(
      child: ListView (
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Center(
              child: Text(tr('parameters')),
            ),
            onTap: () {
              setState(() {
                body = bodyDefault();
              });
            },
          ),
          ListTile(
            title: Text(tr('display')),
            onTap: () {
              setState(() {
                body = bodyDisplay();
              });
            },
          ),
          ListTile(
            title: const Text('Language'),
            onTap: () {
              setState(() {
                body = bodyLanguage(buildContext);
              });
            },
          ),
          ListTile(
            title: Text(tr('advanced')),
            onTap: () {
              setState(() {
                body = bodyAdvanced();
              });
            },
          ),
        ],
      ),
    );
  }

  Padding bodyDefault() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Text('Changelog: Nothing yet'),
            Text('Twitter integration ?'),
          ],
        ),
      ),
    );
  }

  Padding bodyAdvanced() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Text('Nothing yet, Coming soon'),
          ],
        ),
      ),
    );
  }

  Padding bodyLanguage(BuildContext buildContext) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TypeAheadField(
              textFieldConfiguration: const TextFieldConfiguration(
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Image(image: AssetImage('assets/images/wine_bottle.png')),
                  border: OutlineInputBorder(),
                  hintText: 'Select application language'),
              ),
              suggestionsCallback: (pattern) async {
                final LanguageData languageData = LanguageData();
                return languageData.getSuggestions(pattern);
              },
              itemBuilder: (context, LanguageFlag? suggestion) {
                final languageFlag = suggestion!;
                return ListTile(
                  title: Text(languageFlag.language),
                  leading: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image(
                    image: AssetImage(
                      'assets/images/flags/${languageFlag.language}.png')
                    ),
                  )
                );
              },
              noItemsFoundBuilder: (context) => const SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'No Users Found.',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              onSuggestionSelected: (LanguageFlag? suggestion) {
                final languageFlag = suggestion!;
                changeLocale(languageFlag.locale, buildContext);
              },
            ),
          ]
        )
      ),
    );
  }

  Padding bodyDisplay() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _changeTheme(context, MyThemeKeys.LIGHT);
              },
              child: Text(tr('light_mode')),
            ),
            ElevatedButton(
              onPressed: () {
                _changeTheme(context, MyThemeKeys.DARK);
              },
              child: Text(tr('dark_mode')),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: currentBackgroundColor,
                          onColorChanged: changeBackgroundColor,
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          showLabel: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2.0),
                            topRight: Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(tr('select_bg_color')),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: currentSecondaryColor,
                          onColorChanged: changeSecondaryColor,
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          showLabel: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2.0),
                            topRight: Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(tr('select_second_color')),
            ),
            ElevatedButton(
              onPressed: () {
                _applyTheme(context);
              },
              child: Text(tr('apply_theme')),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: widget.theme,
      home: Scaffold(
        drawer: drawer(context),
        appBar: appBar(),
        body: body,
        floatingActionButton: floatingButton()
      ),
    );
  }
}