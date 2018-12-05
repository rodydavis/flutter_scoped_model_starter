import 'package:shared_preferences/shared_preferences.dart';

enum Settings { darkMode, trueBlack }

class AppPreferences {
  void setBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, value);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getBool(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var _bool = prefs.getBool(key);
      return _bool;
    } catch (e) {
      print(e);
      return false; // Default Value
    }
  }
}
