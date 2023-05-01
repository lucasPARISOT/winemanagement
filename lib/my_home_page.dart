import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:winemanagement/custom_themes.dart';
import 'package:winemanagement/dao.dart';
import 'package:winemanagement/parameters/parameters_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.theme, Key? key}) : super(key: key);

  final ThemeData theme;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// This class is for the home page of this application
class _MyHomePageState extends State<MyHomePage> {

  String imageWine = 'assets/images/wine_bottle.png';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      showDialog(
        context: context, builder: (context) {
          setCustomTheme(context);
          return Container();
        }
      );
      Future.delayed(const Duration(microseconds: 1),() {
        Navigator.pop(context);
      });
    });
  }

  Future<void> setCustomTheme(BuildContext buildContext) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('theme')) {
      if(prefs.getString('theme') == 'MyThemeKeys.CUSTOM'){
        final int? bgColor = prefs.getInt('backgroundColor');

        Color? secondaryColor;
        if(prefs.containsKey('secondaryColor')){
          final int ?secondaryColorCode = prefs.getInt('secondaryColor');
          secondaryColor = Color(secondaryColorCode!);
        }
        else {
          secondaryColor = Colors.teal;
        }

        Color? primaryColor = Colors.black;
        Brightness? brightness = Brightness.dark;
        if(prefs.containsKey('appBarTheme')) {

          if(prefs.getString('appBarTheme') == 'MyThemeKeys.LIGHT') {
            primaryColor = Colors.lightBlue;
            brightness = Brightness.light;
          }
        }

        CustomTheme.instanceOf(buildContext).newCustomTheme(
          ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: secondaryColor,
              brightness: brightness,
              background: primaryColor,
              primary: primaryColor,
            ),
            scaffoldBackgroundColor: Color(bgColor!),
          )
        );
      }
    }
  }

  Future<void> _getWine() async {
    final response = await DAO().getAllWines();
    // TODO(user): do something with response
  }

  void _setWine() {
    // Auto generated data
    DAO().addWine();
  }

  void _navigateParameters() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ParametersPage(theme: widget.theme)
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(tr('wine_management')),
      bottom: const TabBar(
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
    return TabBarView(
      children: <Widget>[
        Center(
          child: mainPage(context),
        ),
        Center(
          child: listPage(context),
        ),
        Center(
          child: Text(tr('photo')),
        ),
      ],
    );
  }

  Widget floatingActionButtons(BuildContext context) {
    return Stack(
      children: <Widget> [
        Align(
          alignment: const Alignment(1.0, -0.5),
          child: FloatingActionButton(
            heroTag: 'btn1',
            onPressed: _navigateParameters,
            tooltip: tr('parameters'),
            child: const Icon(Icons.settings),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'btn2',
            onPressed: _getWine,
            tooltip: tr('new_bottle'),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget mainPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr('wine_management')),
        Image(image: AssetImage(imageWine)),
      ],
    );
  }

  Widget listPage(BuildContext context) {

    return FutureBuilder(
      future: DAO().getAllWines(),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const SizedBox.shrink();
        }
        else {
          if (snapshot.error != null) {
            return Center(
                child: Text(tr('error'))
            );
          }
          else {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                      onTap: () {
                        // Actions
                      },
                      title: Text(snapshot.data[index]['desc']),
                      subtitle: Text(snapshot.data[index]['desc']),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundImage: AssetImage(imageWine),
                      ),
                    )
                );
              }
            );
          }
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: widget.theme,
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