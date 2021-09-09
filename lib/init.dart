class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {

    // TODO(user): await dataBase();
    await Future.delayed(const Duration(seconds: 2));
  }
}