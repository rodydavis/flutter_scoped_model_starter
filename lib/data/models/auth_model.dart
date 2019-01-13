import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/data/repositories/persistence_repository.dart';
import 'package:scoped_model/scoped_model.dart';

import '../abstract/persit_data.dart';
import '../classes/auth/auth_module.dart';
import '../classes/auth/auth_user.dart';
import '../classes/auth/token.dart';
import '../classes/user/user.dart';
import '../file_storage.dart';
import '../local_storage.dart';
import '../repositories/auth_repository.dart';
import '../../utils/date_formatter.dart';
import '../../main.dart';

class AuthModel extends Model implements PersistData {
  AuthModule _authModel = AuthModule(
    users: [],
    loggedIn: false,
  );

  bool get loggedIn => _authModel?.loggedIn ?? false;
  List<AuthUser> get users => _authModel?.users ?? [];
  AuthUser get currentUser {
    if (tokenExpired) refreshToken();
    return _authModel?.currentUser ?? users?.first;
  }

  bool get fetching => _fetching;

  Future<bool> login({
    @required String username,
    @required String password,
    bool softLogin = false,
  }) async {
    if (!_fetching) {
      _fetching = true;
      notifyListeners();

      var _newToken = await _getToken(username: username, password: password);
      if (_newToken != null && _newToken.token.isNotEmpty) {
        var _newUser =
            await _getUser(_newToken, username: username, password: password);
        if (!_authModel.users.contains(_newUser)) {
          _authModel.users.add(_newUser);
        }

        switchToAccount(_newUser, softLogin: softLogin);
      } else {
        _fetching = false;
        notifyListeners();
        return false;
      }

      _fetching = false;
    }

    notifyListeners();
    return true;
  }

  Future logout({bool force = true, bool all = false}) async {
    // -- Logout --
    _authModel?.loggedIn = false;
    if (all) {
      resetUsers();
    } else {
      if (users != null) {
        if (force) {
          _authModel?.users?.remove(_authModel?.currentUser);
        }
        if (users.isNotEmpty && users.length > 1) {
          // Login As Next Avaliable User
          switchToAccount(users?.first);
        }
      }
    }

    notifyListeners();
  }

  void switchToAccount(AuthUser newUser, {bool softLogin = false}) {
    if (_authModel?.users != null && _authModel.users.contains(newUser)) {
      _authModel.users.remove(newUser);
      _authModel.users.insert(0, newUser);
    }

    if (!softLogin) {
      _authModel?.currentUser = newUser;
      _authModel?.loggedIn = true;
      notifyListeners();
      appModel.refresh();
      saveToDisk();
    }
    notifyListeners();
//    _currentUser = newUser;
//    notifyListeners();
  }

  Future<bool> autoLogin() async {
    if (!loaded) await loadFromDisk();
    if (_authModel?.users != null && _authModel.users.isNotEmpty) {
      _authModel?.loggedIn = true;
    } else {
      _authModel?.loggedIn = false;
      notifyListeners();
      return false;
    }
    switchToAccount(users?.first);
    notifyListeners();
    return true;
  }

  Future refreshToken() async {
    var _token = await _getToken(
      username: _authModel?.currentUser?.username,
      password: _authModel?.currentUser?.password,
    );
    currentUser.token = _token.token;
    currentUser.tokenExpiration = _token.expires;
  }

  void changeUsersOrder(int before, int after) {
    var data = users[before];
    _authModel?.users?.removeAt(before);
    _authModel?.users?.insert(after, data);
    notifyListeners();
    saveToDisk();
  }

  void removeUser(AuthUser user) {
    if (users != null) {
      _authModel?.users?.remove(user);
    }

    if (user == _authModel?.currentUser &&
        (users != null && users.isNotEmpty)) {
      switchToAccount(users?.first);
    }
    notifyListeners();
  }

  Future resetUsers() async {
    _authModel?.currentUser = null;
    if (users != null) users.clear();
    var prefs = AppPreferences();
    prefs.setList(Info.users, []);
  }

  // -- Helpers --
  Future<TokenResponse> _getToken({
    @required String username,
    @required String password,
  }) async {
    var _auth = AuthRepository();
    TokenResponse _newToken;
    try {
      _newToken = await _auth.login(username, password);
      _authModel?.error = "";
    } catch (e) {
      _authModel?.error = e.toString();
      print(_authModel?.error);
    }
    _newToken.expires = DateTime.now()
        .add(Duration(seconds: _newToken.expires))
        .millisecondsSinceEpoch;
    return _newToken;
  }

  Future<AuthUser> _getUser(
    TokenResponse token, {
    @required String username,
    @required String password,
  }) async {
    var _auth = AuthRepository();
    AuthUser _user;
    try {
//      var _result = await _auth.getInfo(token?.token);
//      var _info = User.fromJson(_result?.result);
//      _info.kalturaId = "CompanyAdmin2@BammUnify.com";
      _user = AuthUser(
        token: token?.token,
        tokenExpiration: token.expires,
        data: null,
        username: username,
        password: password,
      );
      return _user;
    } catch (e) {
      print("Error Getting Info: $e");
    }
    return _user;
  }

  bool _fetching = false;
  void cancel() {
    _fetching = false;
    notifyListeners();
  }

  bool get tokenExpired =>
      (_authModel?.currentUser?.tokenExpiration ?? 0) >=
      DateTime.now().millisecondsSinceEpoch;

  bool get unifyVideoEnabled =>
      currentUser?.data?.kalturaId != null &&
      currentUser.data.kalturaId.isNotEmpty;

  @override
  bool loaded = false;

  @override
  bool loading = false;

  @override
  Future loadFromDisk() async {
    if (!loading) {
      loading = true;
      notifyListeners();

      AuthModule _auth;
      try {
        _auth = await storage.loadAuthState();
      } catch (e) {
        print("Error Loading Auth State => $e");
      }
      if (_auth == null) {
        _authModel = AuthModule(
          users: [],
          loggedIn: false,
        );
      } else {
        _authModel = _auth;
      }

      loading = false;
      loaded = true;
      notifyListeners();

//      _loadSettings();
    }
  }

  @override
  void saveToDisk() {
    storage.saveAuthState(_authModel);
  }

  @override
  PersistenceRepository get storage =>
      PersistenceRepository(fileStorage: FileStorage(module));

  @override
  String get module => "auth";
}
