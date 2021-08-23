class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {

    //TODO: await dataBase();
    await Future.delayed(Duration(seconds: 2));
  }
}