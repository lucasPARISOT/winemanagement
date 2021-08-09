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
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  _ParametersPage() {
    getCurrentColor().then((value) => setState(() {
      currentBackgroundColor = value;
    }));
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
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  Future<void> _applyTheme(BuildContext buildContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? colorCode = prefs.getInt('backgroundColor');

    prefs.setString('theme', 'MyThemeKeys.CUSTOM');

    ThemeData oldTheme = CustomTheme.of(context);

    ThemeData theme = ThemeData(
      scaffoldBackgroundColor: Color(colorCode!),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: widget.theme,
      home: Scaffold(
        appBar: appBar(),
          body: Padding(
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
                      _changeTheme(context, MyThemeKeys.CUSTOM);
                    },
                    child: Text("Custom!"),
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
                    child: Text("background color!"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _applyTheme(context);
                    },
                    child: Text("Apply background color!"),
                  ),
                ],
              ),
            ),
          ),
        floatingActionButton: floatingButton()
      ),
    );
  }
}