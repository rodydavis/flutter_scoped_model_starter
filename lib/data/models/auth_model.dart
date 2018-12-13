import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../classes/auth/auth_module.dart';
import '../classes/auth/auth_user.dart';
import '../classes/user/user.dart';
import '../local_storage.dart';
import '../repositories/auth_repository.dart';

class AuthModel extends Model {
  AuthModule _module = AuthModule(
    users: [],
    isLoading: false,
    userChanged: false,
    savedUsersCount: 0,
    saveUsersAdded: 0,
    loggedIn: false,
  );

  bool get isLoading => _module?.isLoading ?? false;
  bool get loggedIn => _module?.loggedIn ?? false;
  List<AuthUser> get users => _module?.users ?? [];
  AuthUser get currentUser => _module?.currentUser;
  bool get userChanged => _module?.userChanged ?? false;
  int get usersCount => _module?.savedUsersCount ?? 0;
  int get usersAdded => _module?.saveUsersAdded ?? 0;

  double get progress {
    if (usersAdded == 0) return 0.0;
    return usersAdded / usersCount;
  }

  Future<bool> login(
      {@required String username,
      @required String password,
      bool softLogin = false}) async {
    _module?.isLoading = true;
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
    _module?.isLoading = false;
    notifyListeners();
    return true;
  }

  Future logout({bool force = true, bool all = false}) async {
    // -- Logout --
    _module?.loggedIn = false;
    if (all) {
      resetUsers();
    } else {
      if (users != null) {
        if (force) {
          _module?.users?.remove(_module?.currentUser);
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
    List<String> _usernames = [];
    for (var _item in users) {
      _usernames.add(_item?.username);
    }
    print("User: ${newUser?.username} => Users: $_usernames");
    if (!_usernames.contains(newUser?.username) && users != null) {
      _module?.users?.add(newUser);
    }

    if (!softLogin) {
      _module?.currentUser = newUser;
      _module?.loggedIn = true;
      _module?.userChanged = true;
      _saveUsers();
    }
    notifyListeners();
  }

  void confirmUserChange() {
    _module?.userChanged = false;
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    var _newUsers = await _loadUsers();
    if (_newUsers.isNotEmpty) {
      _module.users = _newUsers;
    } else {
      _module?.loggedIn = false;
      notifyListeners();
      return false;
    }
    switchToAccount(users?.first);
    notifyListeners();
    return true;
  }

  Future refreshToken() async {
    await login(
      username: _module?.currentUser?.username,
      password: _module?.currentUser?.password,
    );
  }

  void changeUsersOrder(int before, int after) {
    var data = users[before];
    _module?.users?.removeAt(before);
    _module?.users?.insert(after, data);
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
    _module?.savedUsersCount = _list?.length;
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
            _module?.saveUsersAdded += 1;
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
    for (var _item in users) {
      var _id = uuid.v4();
      _list.add(_id);
      sharedPrefs.setString(_id, _item.username);
      storage.write(key: _id, value: _item.password);
    }
    prefs.setList(Info.users, _list);
  }

  void removeUser(AuthUser user) {
    if (users != null) {
      _module?.users?.remove(user);
    }

    if (user == _module?.currentUser && (users != null && users.isNotEmpty)) {
      switchToAccount(users?.first);
    }
    notifyListeners();
  }

  Future resetUsers() async {
    _module?.currentUser = null;
    if (users != null) users.clear();
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
      var _info = User.fromJson(_result?.result);
      _user = AuthUser(
        token: token,
        data: _info,
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
