import 'package:hive_flutter/hive_flutter.dart';

/// Repository responsible for persisting and retrieving authentication data.
class AuthRepository {
  static const String _authBoxName = 'authBox';
  static const String _isLoggedInKey = 'isLoggedIn';

  /// Initializes the local storage for authentication.
  Future<void> init() async {
    await Hive.openBox(_authBoxName);
  }

  /// Checks if the user is currently marked as logged in.
  bool isLoggedIn() {
    final box = Hive.box(_authBoxName);
    return box.get(_isLoggedInKey, defaultValue: false);
  }

  /// Updates the logged-in status of the user.
  Future<void> setLoggedIn(bool value) async {
    final box = Hive.box(_authBoxName);
    await box.put(_isLoggedInKey, value);
  }

  /// Helper method to perform logout by clearing the logged-in status.
  Future<void> logout() async {
    final box = Hive.box(_authBoxName);
    await box.put(_isLoggedInKey, false);
  }
}
