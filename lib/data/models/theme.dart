import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/local_storage.dart';

class ThemeModel extends Model {
  ThemeData _currentTheme = defaultTheme;
  bool _darkMode = false;
  bool _trueBlack = false;
  bool _isLoaded = false;

  ThemeData get theme => _currentTheme;
  bool get isDarkMode => _darkMode;
  bool get isTrueBlack => _trueBlack;
  bool get isLoaded => _isLoaded;

  void darkMode({bool trueBlack = false}) {
    if (trueBlack) {
      _currentTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
      );
    } else {
      _currentTheme = ThemeData.dark();
    }
    print("Dark Mode Activated");
    _darkMode = true;
    _trueBlack = trueBlack;
    _saveThemeToDisk();
    notifyListeners();
  }

  void lightMode() {
    _currentTheme = ThemeData.light();
    print("Light Mode Activated");
    _darkMode = false;
    _saveThemeToDisk();
    notifyListeners();
  }

  void reset() {
    _currentTheme = defaultTheme;
    print("Default Theme Activated");
    _darkMode = false;
    _saveThemeToDisk();
    notifyListeners();
  }

  Future loadSavedTheme() async {
    var prefs = AppPreferences();
    _darkMode = await prefs.getSetting(Settings.darkMode);
    _trueBlack = await prefs.getSetting(Settings.trueBlack);
    if (_darkMode) {
      darkMode(trueBlack: _trueBlack);
    } else {
      lightMode();
    }
    _isLoaded = true;
    notifyListeners();
    return;
  }

  void _saveThemeToDisk() {
    var prefs = AppPreferences();
    prefs.setSetting(Settings.darkMode, _darkMode);
    prefs.setSetting(Settings.trueBlack, _trueBlack);
  }
}

final ThemeData defaultTheme = ThemeData(
  primaryColor: Colors.red,
  accentColor: Colors.yellow,
);
