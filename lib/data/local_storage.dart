import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Settings { darkMode, trueBlack, autoSignin }

enum Info { username, password, users }

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
      if (_value == null && key == Settings.autoSignin) return true;
      return _value;
    } catch (e) {
      print(e);
      if (key == Settings.autoSignin) return true;
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

  void setSecure(Info key, String value) async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.write(key: key.toString(), value: value);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getSecure(Info key) async {
    try {
      final storage = new FlutterSecureStorage();
      String _value = await storage.read(key: key.toString());
      return _value;
    } catch (e) {
      print(e);
      return ""; // Default Value
    }
  }

  void setList(Info key, List<String> values) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList(key.toString(), values);
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> getList(Info key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var _values = prefs.getStringList(key.toString());
      return _values;
    } catch (e) {
      print(e);
      return []; // Default Value
    }
  }
}
