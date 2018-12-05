import 'package:shared_preferences/shared_preferences.dart';

enum Settings { darkMode, trueBlack, autoSignin }

enum Info { username, password }

class AppPreferences {
  void setSetting(Settings key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(key.toString(), value);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getSetting(Settings key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var _value = prefs.getBool(key.toString());
      return _value;
    } catch (e) {
      print(e);
      // if (key == Settings.autoSignin) return true;
      return false; // Default Value
    }
  }

  void setInfo(Info key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key.toString(), value);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getInfo(Info key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var _value = prefs.getString(key.toString());
      return _value;
    } catch (e) {
      print(e);
      return ""; // Default Value
    }
  }
}
