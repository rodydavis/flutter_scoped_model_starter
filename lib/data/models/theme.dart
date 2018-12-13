import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/local_storage.dart';
import '../classes/app/theme.dart';

class ThemeModel extends Model {
  ThemeData _currentTheme = defaultTheme;
  ThemeModule _module;

  ThemeData get theme => _currentTheme;
  bool get isDarkMode => _module?.darkMode ?? false;
  bool get isTrueBlack => _module?.trueBlack ?? false;
  bool get isLoaded => _module?.isLoaded ?? false;

  void darkMode({bool trueBlack = false}) {
    if (trueBlack) {
      _currentTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
        primaryColorDark: Colors.grey,
      );
    } else {
      _currentTheme = ThemeData.dark();
    }
    print("Dark Mode Activated");
    _module?.darkMode = true;
    _module?.trueBlack = trueBlack;
    _saveThemeToDisk();
    notifyListeners();
  }

  void lightMode() {
    _currentTheme = ThemeData.light();
    print("Light Mode Activated");
    _module?.darkMode = false;
    _saveThemeToDisk();
    notifyListeners();
  }

  void reset() {
    _currentTheme = defaultTheme;
    print("Default Theme Activated");
    _module?.darkMode = false;
    _saveThemeToDisk();
    notifyListeners();
  }

  Future loadSavedTheme() async {
    var prefs = AppPreferences();
    _module?.darkMode = await prefs.getSetting(Settings.darkMode);
    _module?.trueBlack = await prefs.getSetting(Settings.trueBlack);
    if (_module?.darkMode ?? false) {
      darkMode(trueBlack: _module?.trueBlack);
    } else {
      lightMode();
    }
    _module?.isLoaded = true;
    notifyListeners();
    return;
  }

  void _saveThemeToDisk() {
    var prefs = AppPreferences();
    prefs.setSetting(Settings.darkMode, _module?.darkMode);
    prefs.setSetting(Settings.trueBlack, _module?.trueBlack);
  }
}

final ThemeData defaultTheme = ThemeData(
  primaryColor: Colors.red,
  accentColor: Colors.yellow,
);
