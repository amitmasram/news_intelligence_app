import 'package:hive_flutter/hive_flutter.dart';

class AuthRepository {
  static const String _authBoxName = 'authBox';
  static const String _isLoggedInKey = 'isLoggedIn';

  Future<void> init() async {
    await Hive.openBox(_authBoxName);
  }

  bool isLoggedIn() {
    final box = Hive.box(_authBoxName);
    return box.get(_isLoggedInKey, defaultValue: false);
  }

  Future<void> setLoggedIn(bool value) async {
    final box = Hive.box(_authBoxName);
    await box.put(_isLoggedInKey, value);
  }

  Future<void> logout() async {
    final box = Hive.box(_authBoxName);
    await box.put(_isLoggedInKey, false);
  }
}
