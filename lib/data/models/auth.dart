import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';
import '../local_storage.dart';

class AuthModel extends Model {
  User _currentUser;
  bool _loggedIn = false;
  String _token = "";

  User get currentUser => _currentUser;
  bool get loggedIn => _loggedIn;
  String get token => _token;

  Future login({@required String username, @required String password}) async {
    // -- Login --
    try {
      _token = "983769873n498h273x7iuhdjskhfkjsdhf78er";
      // -- Get User Info --
      var _userInfo = User(
        fullName: "Test User",
        email: username,
        profileImage: "https://picsum.photos/200/300/?random",
      );

      // -- Update User --
      _currentUser = _userInfo;
      _loggedIn = true;
      notifyListeners();
      _saveInfoToDisk(username: username, password: password);
    } catch (e) {
      logout();
    }
  }

  Future logout() async {
    // -- Logout --
    _loggedIn = false;
    _currentUser = null;
    notifyListeners();

    // -- Logout on API --
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

class User {
  final String fullName, email, profileImage;

  User({
    this.fullName,
    this.email,
    this.profileImage,
  });

  @override
  String toString() {
    final String _user = "$fullName";
    return _user.toString();
  }
}
