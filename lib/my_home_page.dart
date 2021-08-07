import 'dao.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  String image_wine = 'assets/images/wine_bottle.png';

  void _incrementCounter() {
    setState(() {
      _counter++;

      DAO().insertTest(_counter);
    });
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(widget.title),
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

  Widget body() {
    return new TabBarView(
      children: <Widget>[
        Center(
          child: mainPage(),
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

  Widget floatingActionButtons() {
    return Stack(
      children: <Widget> [
        Align(
          alignment: Alignment(1.0, -0.5),
          child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Parameter',
            child: Icon(Icons.settings),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Add new bottle',
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget mainPage() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text("Gestion de cave à vin"),
        Image(image: AssetImage(image_wine)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: appBar(),
            body: body(),
            floatingActionButton: floatingActionButtons(),
        ),
      ),
    );
  }
}