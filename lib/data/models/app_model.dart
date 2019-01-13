import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/data/repositories/persistence_repository.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import '../abstract/persit_data.dart';
import '../classes/app/settings.dart';
import '../file_storage.dart';
import '../repositories/persistence_repository.dart';

class AppState extends Model implements PersistData {
  AppState();

  void refresh() {
//    contactModel.refresh();
  }

  ThemeData _currentTheme = ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.yellow,
  );

  AppSettings _settings = AppSettings(
    // Defaults
    darkMode: false,
    trueBlack: false,
    isLoaded: false,
  );

  AppSettings get setting {
    if (loaded) loadFromDisk();
    return _settings;
  }

  void _loadSettings() {
    _loadTheme();
    authModel?.loadFromDisk();
    notifyListeners();
  }

  // -- Theme --
  ThemeData get theme => _currentTheme;
  bool get isLoaded => loaded;

  void _loadTheme() {
    if (_settings?.darkMode ?? false) {
      darkMode(trueBlack: _settings?.trueBlack);
    } else {
      lightMode();
    }
  }

  void darkMode({bool trueBlack = false}) {
    if (trueBlack ?? false) {
      _currentTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
        primaryColorDark: Colors.grey,
      );
    } else {
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
    print("Dark Mode Activated");
    _settings?.darkMode = true;
    _settings?.trueBlack = trueBlack;
    saveToDisk();
    notifyListeners();
  }

  void lightMode() {
    _currentTheme = ThemeData.light();
    notifyListeners();
    print("Light Mode Activated");
    _settings?.darkMode = false;
    saveToDisk();
    notifyListeners();
  }

  void reset() {
    _currentTheme = ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.yellow,
    );
    notifyListeners();
    print("Default Theme Activated");
    _settings?.darkMode = false;
    saveToDisk();
    notifyListeners();
  }

  @override
  bool loaded = false;

  @override
  bool loading = false;

  @override
  Future loadFromDisk() async {
    if (!loading) {
      loading = true;
      AppSettings _appSettings;
      try {
        _appSettings = await storage.loadSettingsState();
      } catch (e) {
        print("Error Loading App State => $e");
      }
      if (_appSettings == null) {
        _settings = AppSettings(
          // Defaults
          darkMode: false,
          trueBlack: false,
          isLoaded: false,
        );
      } else {
        _settings = _appSettings;
      }

      loading = false;
      loaded = true;
      notifyListeners();

      _loadSettings();
    }
  }

  @override
  void saveToDisk() {
    storage.saveSettingsState(_settings);
  }

  @override
  PersistenceRepository get storage =>
      PersistenceRepository(fileStorage: FileStorage(module));

  @override
  String get module => "settings";
}
