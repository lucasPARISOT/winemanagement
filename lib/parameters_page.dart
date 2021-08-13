import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_themes.dart';
import 'my_home_page.dart';
import 'my_themes.dart';

class ParametersPage extends StatefulWidget {

  final ThemeData theme;

  ParametersPage({Key? key, required this.theme}) : super(key: key);

  @override
  _ParametersPage createState() => _ParametersPage();
}

class _ParametersPage extends State<ParametersPage> {

  Color currentBackgroundColor = Colors.limeAccent;
  Color currentAccentColor = Colors.white;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  Padding? body;

  _ParametersPage() {
    getCurrentColor().then((value) => setState(() {
      currentBackgroundColor = value;
    }));
    body = this.bodyDefault();
  }

  Future<Color> getCurrentColor() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('backgroundColor')){
      return Colors.black;
    }
    else {
      int? colorCode = prefs.getInt('backgroundColor');
      return Color(colorCode!);
    }
  }

  void changeBackgroundColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('backgroundColor', color.value);

    setState(() {
      currentBackgroundColor = color;
    });
  }

  void changeAccentColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('accentColor', color.value);

    setState(() {
      currentAccentColor = color;
    });
  }

  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  void _navigateHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(theme: widget.theme)),
    );
  }

  Future<void> _changeTheme(BuildContext buildContext, MyThemeKeys key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', key.toString());
    prefs.setString('appBarTheme', key.toString());
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  Future<void> _applyTheme(BuildContext buildContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('theme', 'MyThemeKeys.CUSTOM');

    Color? backgroundColor;
    if(prefs.containsKey('backgroundColor')){
      int ?backgroundColorCode = prefs.getInt('backgroundColor');
      backgroundColor = Color(backgroundColorCode!);
    }
    else {
      backgroundColor = Colors.teal;
    }

    Color? accentColor;
    if(prefs.containsKey('accentColor')){
      int ?accentColorCode = prefs.getInt('accentColor');
      accentColor = Color(accentColorCode!);
    }
    else {
      accentColor = Colors.teal;
    }

    ThemeData oldTheme = CustomTheme.of(context);

    ThemeData theme = ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      accentColor: accentColor,
      primaryColor: oldTheme.primaryColor,
      brightness: oldTheme.brightness,
    );

    CustomTheme.instanceOf(buildContext).newCustomTheme(theme);
  }

  Widget floatingButton() {
    return Stack(
      children: [
        Align(
          alignment: Alignment(1.0, -0.5),
          child: FloatingActionButton(
            onPressed: _navigateHomePage,
            tooltip: tr('back'),
            child: Icon(Icons.keyboard_return),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(tr('parameters')),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView (
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Center(
              child: Text('menu'),
            ),
            onTap: () {
              setState(() {
                body = bodyDefault();
              });
            },
          ),
          ListTile(
            title: Text('display'),
            onTap: () {
              setState(() {
                body = bodyDisplay();
              });
            },
          ),
          ListTile(
            title: Text('advanced'),
            onTap: () {
              // Update the state of the app.
              // ...
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
          children: <Widget>[
            Text('Changelog: Nothing yet'),
            Text('Twitter integration ?'),
          ],
        ),
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
              child: Text(tr("light_mode")),
            ),
            ElevatedButton(
              onPressed: () {
                _changeTheme(context, MyThemeKeys.DARK);
              },
              child: Text(tr("dark_mode")),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
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
                            topLeft: const Radius.circular(2.0),
                            topRight: const Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(tr("select_bg_color")),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: currentAccentColor,
                          onColorChanged: changeAccentColor,
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          showLabel: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(2.0),
                            topRight: const Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(tr("select_second_color")),
            ),
            ElevatedButton(
              onPressed: () {
                _applyTheme(context);
              },
              child: Text(tr("apply_theme")),
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
        drawer: drawer(),
        appBar: appBar(),
        body: body,
        floatingActionButton: floatingButton()
      ),
    );
  }
}