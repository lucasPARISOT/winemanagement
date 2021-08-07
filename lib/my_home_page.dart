import 'dao.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'parameters_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  String imageWine = 'assets/images/wine_bottle.png';

  void _incrementCounter() {
    setState(() {
      _counter++;

      DAO().insertTest(_counter);
    });
  }

  void _navigateParameters() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ParametersPage()),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {

    return AppBar(
      centerTitle: true,
      title: Text(tr('wineManagement')),
      bottom: TabBar(
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.liquor),
          ),
          Tab(
            icon: Icon(Icons.photo_camera),
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return new TabBarView(
      children: <Widget>[
        Center(
          child: mainPage(context),
        ),
        Center(
          child: new Text("List"),
        ),
        Center(
          child: new Text("Photo"),
        ),
      ],
    );
  }

  Widget floatingActionButtons(BuildContext context) {
    return Stack(
      children: <Widget> [
        Align(
          alignment: Alignment(1.0, -0.5),
          child: FloatingActionButton(
            onPressed: _navigateParameters,
            tooltip: tr('parameters'),
            child: Icon(Icons.settings),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: tr('new_bottle'),
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget mainPage(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr('wineManagement')),
        Image(image: AssetImage(imageWine)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    print(Localizations.localeOf(context));
    context.resetLocale();
    print(Localizations.localeOf(context));

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: appBar(context),
            body: body(context),
            floatingActionButton: floatingActionButtons(context),
        ),
      ),
    );
  }
}