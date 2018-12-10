import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../local_storage.dart';
import '../../repositories/auth_repository.dart';
import 'info.dart';
import 'user.dart';

class AuthModel extends Model {
  List<UserObject> _users = [];
  UserObject _currentUser;
  bool _loggedIn = false;
  String _token = "";
  String _error = "";

  bool get loggedIn => _loggedIn;
  String get token => _token;
  List<UserObject> get users => _users;
  UserObject get currentUser => _currentUser;

  Future login({@required String username, @required String password}) async {
    var _auth = AuthRepository();
    // -- Login --
    try {
      _token = await _auth.login(username, password);
      _error = "";
      _loggedIn = true;
      _saveInfoToDisk(username: username, password: password);
    } catch (e) {
      _token = "";
      _error = e;
      print(_error);
      logout();
    }

    if (_token.toString().isNotEmpty) {
      // -- Get User Info --
      try {
        var _result = await _auth.getInfo(_token);
        var _user = UserObject(token: _token, data: _result?.result);
        // if (!_users.contains(_user)) _users.add(_user);
        switchToAccount(_user);
      } catch (e) {
        print("Error Getting Info: $e");
      }
    }

    notifyListeners();
  }

  Future logout({bool force = true}) async {
    // -- Logout --
    _loggedIn = false;
    if (force) {
      _users.remove(_currentUser);
      _currentUser = null;
    } else {
      if (_users != null && _users.isNotEmpty && _users.length > 1) {
        // Login As Next Avaliable User
        switchToAccount(_users?.first);
      }
    }
    notifyListeners();
  }

  void switchToAccount(UserObject newUser) {
    if (!_users.contains(newUser)) _users.add(newUser);
    _currentUser = newUser;
    _token = newUser?.token;
    notifyListeners();
  }

  Future autoLogin() async {
    var prefs = AppPreferences();
    var _username = await prefs.getInfo(Info.username);
    var _password = await prefs.getSecure(Info.password);

    login(username: _username, password: _password);
  }

  void _saveInfoToDisk({@required String username, @required String password}) {
    var prefs = AppPreferences();
    prefs.setInfo(Info.username, username);
    prefs.setSecure(Info.password, password);
  }
}
