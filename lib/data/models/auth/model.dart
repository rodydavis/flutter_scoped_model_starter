import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../local_storage.dart';
import '../../repositories/auth_repository.dart';
import '../auth/user.dart';

class AuthModel extends Model {
  User _currentUser;
  bool _loggedIn = false;
  String _token = "";
  String _error = "";

  User get currentUser => _currentUser;
  bool get loggedIn => _loggedIn;
  String get token => _token;
  String get error => _error;

  Future login({@required String username, @required String password}) async {
    var _auth = AuthRepository();
    // -- Login --
    try {
      _token = await _auth.login(username, password);
      _error = "";
      _loggedIn = true;
      notifyListeners();
      _saveInfoToDisk(username: username, password: password);
    } catch (e) {
      _token = "";
      _error = e;
      print(_error);
      logout();
    }

    // -- Get User Info --
    try {
      var _userInfo = await _auth.getInfo(_token);

      // -- Update User --
      _currentUser = User(
        fullName: _userInfo?.fullName,
        email: _userInfo?.email ?? "",
        profileImage: _userInfo?.profileImageUrl ?? "",
      );
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    // -- Logout --
    _loggedIn = false;
    _currentUser = null;
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
