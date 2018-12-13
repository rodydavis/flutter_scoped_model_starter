import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../local_storage.dart';
import '../repositories/auth_repository.dart';
import '../classes/auth/auth_user.dart';
import '../../constants.dart';
import '../classes/auth/auth_module.dart';

class AuthModel extends Model {
  AuthModule _module;

  bool get isLoading => _module.isLoading;
  bool get loggedIn => _module.loggedIn;
  List<AuthUser> get users => _module?.users;
  AuthUser get currentUser => _module?.currentUser;
  bool get userChanged => _module.userChanged;
  int get usersCount => _module.savedUsersCount;
  int get usersAdded => _module.saveUsersAdded;

  double get progress {
    if (_module.saveUsersAdded == 0) return 0.0;
    return _module.saveUsersAdded / _module.savedUsersCount;
  }

  Future<bool> login(
      {@required String username,
      @required String password,
      bool softLogin = false}) async {
    _module.isLoading = true;
    notifyListeners();
    var _newToken = await _getToken(username: username, password: password);
    if (_newToken.isNotEmpty) {
      var _newUser =
          await _getUser(_newToken, username: username, password: password);
      switchToAccount(_newUser, softLogin: softLogin);
    } else {
      notifyListeners();
      return false;
    }
    _module.isLoading = false;
    notifyListeners();
    return true;
  }

  Future logout({bool force = true, bool all = false}) async {
    // -- Logout --
    _module.loggedIn = false;
    if (all) {
      resetUsers();
    } else {
      if (force) {
        _module?.users.remove(_module.currentUser);
      }
      if (_module?.users != null &&
          _module?.users.isNotEmpty &&
          _module?.users.length > 1) {
        // Login As Next Avaliable User
        switchToAccount(_module?.users?.first);
      }
    }

    notifyListeners();
  }

  void switchToAccount(AuthUser newUser, {bool softLogin = false}) {
    List<String> _usernames = [];
    for (var _item in _module?.users) {
      _usernames.add(_item?.username);
    }
    print("User: ${newUser?.username} => Users: $_usernames");
    if (!_usernames.contains(newUser?.username) && _module?.users != null) {
      _module.users.add(newUser);
    }

    if (!softLogin) {
      _module.currentUser = newUser;
      _module.loggedIn = true;
      _module.userChanged = true;
      _saveUsers();
    }
    notifyListeners();
  }

  void confirmUserChange() {
    _module.userChanged = false;
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    var _newUsers = await _loadUsers();
    if (_newUsers.isNotEmpty) {
      _module?.users = _newUsers;
    } else {
      _module.loggedIn = false;
      notifyListeners();
      return false;
    }
    switchToAccount(_module?.users?.first);
    notifyListeners();
    return true;
  }

  Future refreshToken() async {
    await login(
      username: _module.currentUser?.username,
      password: _module.currentUser?.password,
    );
  }

  void changeUsersOrder(int before, int after) {
    var data = _module?.users[before];
    _module?.users.removeAt(before);
    _module?.users.insert(after, data);
    notifyListeners();
    _saveUsers();
  }

  Future<List<AuthUser>> _loadUsers() async {
    var prefs = AppPreferences();
    List<AuthUser> _newUsers = [];
    var _list = await prefs.getList(Info.users);
    if (_list != null && _list.length > kMultipleAccounts) {
      prefs.setList(Info.users, [_list[0], _list[1], _list[2], _list[3]]);
      _list = await prefs.getList(Info.users);
    }
    _module.savedUsersCount = _list?.length;
    notifyListeners();
    final storage = new FlutterSecureStorage();
    final sharedPrefs = await SharedPreferences.getInstance();
    print("List of Users => $_list");
    if (_list != null && _list.isNotEmpty) {
      for (var _id in _list) {
        print("ID => $_id");
        var _username = sharedPrefs.getString(_id);
        var _password = await storage.read(key: _id);
        var _newToken =
            await _getToken(username: _username, password: _password);
        print("Username: $_username, Password: $_password => $_newToken");
        if (_newToken.isNotEmpty) {
          var _newUser = await _getUser(_newToken,
              username: _username, password: _password);
          if (_newUser != null && !_newUsers.contains(_newUser?.username)) {
            _newUsers.add(_newUser);
            _module.saveUsersAdded += 1;
            notifyListeners();
          }
        }
      }
      print("List of Users => $_newUsers");
    }

    return _newUsers;
  }

  Future _saveUsers() async {
    var prefs = AppPreferences();
    var uuid = new Uuid();
    final storage = new FlutterSecureStorage();
    final sharedPrefs = await SharedPreferences.getInstance();

    List<String> _list = [];
    for (var _item in _module?.users) {
      var _id = uuid.v4();
      _list.add(_id);
      sharedPrefs.setString(_id, _item.username);
      storage.write(key: _id, value: _item.password);
    }
    prefs.setList(Info.users, _list);
  }

  void removeUser(AuthUser user) {
    if (_module?.users != null) {
      _module.users.remove(user);
    }

    if (user == _module.currentUser &&
        (_module?.users != null && _module.users.isNotEmpty)) {
      switchToAccount(_module?.users?.first);
    }
    notifyListeners();
  }

  Future resetUsers() async {
    _module.currentUser = null;
    _module?.users.clear();
    var prefs = AppPreferences();
    prefs.setList(Info.users, []);
  }

  // -- Helpers --
  Future<String> _getToken({
    @required String username,
    @required String password,
  }) async {
    var _auth = AuthRepository();
    String _newToken = "";
    try {
      _newToken = await _auth.login(username, password);
      _module?.error = "";
    } catch (e) {
      _newToken = "";
      _module?.error = e.toString();
      print(_module?.error);
    }
    return _newToken;
  }

  Future<AuthUser> _getUser(
    String token, {
    @required String username,
    @required String password,
  }) async {
    var _auth = AuthRepository();
    AuthUser _user;
    try {
      var _result = await _auth.getInfo(token);
      _user = AuthUser(
        token: token,
        data: _result?.result,
        username: username,
        password: password,
      );
      return _user;
    } catch (e) {
      print("Error Getting Info: $e");
    }
    return _user;
  }
}
