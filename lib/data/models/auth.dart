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
      _token =
          "frUL-jz9EqGlWyHbPeKOd_bzFRAqJ3U6rOYH0nJdim50x-P3hRXySLMCYRv2bL-hnCRbJbwmtmR_9ZvFVW-DgxJLNOAvu3Eoc8q-8raIvrfwU8B2KGMlD5khnBvJ12va4tepfq-jkwNz3U2LCfZ-Wg3wIxcU3pGFYgxOtoI1uXGZmvWH4nisak_141n8cSuaKH9ayrbcsPDAfpNClxAn0c74m7u_ei1qyUksnR3C7gWBDHCr5iKOXGwwr08FpKNDRBYpXap4sUDoIm2zIIVO1UwSvJ5lISwZV9V4xDdcWFg2KnrX2QQjXRZliC0nVW1yix92287lpO9pQQhOYzErFQyCXLFJ28Ig_vA5wNAo2zK226TySB5xIImI-qaEkpgV";
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
