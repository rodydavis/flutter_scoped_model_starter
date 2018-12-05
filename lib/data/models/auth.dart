import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';
import '../local_storage.dart';

class AuthModel extends Model {
  User _currentUser;

  User get currentUser => _currentUser;

  Future login({@required String username, @required String password}) async {
    // -- Login --

    // -- Get User Info --
    var _userInfo = User(
      username: username,
      fullName: "Test User",
      email: "test@email.com",
    );

    // -- Update User --
    _currentUser = _userInfo;

    notifyListeners();
    _saveInfoToDisk(username: username, password: password);
  }

  Future logout() async {
    // -- Logout --
    _currentUser = null;
    notifyListeners();
  }

  Future autoLogin() async {
    var prefs = AppPreferences();
    var _username = await prefs.getInfo(Info.username);
    var _password = await prefs.getInfo(Info.password);

    login(username: _username, password: _password);
  }

  void _saveInfoToDisk({@required String username, @required String password}) {
    var prefs = AppPreferences();
    prefs.setInfo(Info.username, username);
    prefs.setInfo(Info.password, password);
  }
}

class User {
  final String fullName, email, username;

  User({
    this.fullName,
    this.email,
    this.username,
  });

  @override
  String toString() {
    final String _user = "$fullName";
    return _user.toString();
  }
}
