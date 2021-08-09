import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

  void _navigateHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(theme: widget.theme)),
    );
  }

  Future<void> _changeTheme(BuildContext buildContext, MyThemeKeys key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(key.toString());
    prefs.setString('theme', key.toString());
    CustomTheme.instanceOf(buildContext).changeTheme(key);
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
                  Divider(height: 100,),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    color: Theme.of(context).primaryColor,
                    width: 100,
                    height: 100,
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