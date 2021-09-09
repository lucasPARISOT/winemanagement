/// Singleton init class
/// Data should be initialized in this class
class Init {
  Init._();

  /// Singleton constructor
  static final instance = Init._();

  /// Data should be initialized in this function
  Future initialize() async {

    // TODO(user): await dataBase();
    await Future.delayed(const Duration(seconds: 2));
  }
}