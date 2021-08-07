import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:winemanagement/my_home_page.dart';

class ParametersPage extends StatefulWidget {
  const ParametersPage() : super();

  @override
  _ParametersPage createState() => _ParametersPage();
}

class _ParametersPage extends State<ParametersPage> {

  void _navigateHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
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
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: appBar(),
        //body: Center(
        //),
        floatingActionButton: floatingButton()
      ),
    );
  }
}