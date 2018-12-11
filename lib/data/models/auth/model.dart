import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../local_storage.dart';
import '../../repositories/auth_repository.dart';
import 'info.dart';
import '../../../constants.dart';

class UserObject {
  String username, password, token;
  User data;

  UserObject({
    this.token = "",
    this.data,
    this.username,
    this.password,
  });

  UserObject.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    data = json['users'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AuthModel extends Model {
  List<UserObject> _users = [];
  UserObject _currentUser;
  bool _loggedIn = false;
  bool _userChanged = false;
  String _error = "";

  bool get loggedIn => _loggedIn;
  List<UserObject> get users => _users;
  UserObject get currentUser => _currentUser;
  bool get userChanged => _userChanged;

  Future<bool> login(
      {@required String username,
      @required String password,
      bool softLogin = false}) async {
    var _newToken = await _getToken(username: username, password: password);
    if (_newToken.isNotEmpty) {
      var _newUser =
          await _getUser(_newToken, username: username, password: password);
      switchToAccount(_newUser, softLogin: softLogin);
    } else {
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  Future logout({bool force = true, bool all = false}) async {
    // -- Logout --
    _loggedIn = false;
    if (all) {
      resetUsers();
    } else {
      if (force) {
        _users.remove(_currentUser);
      }
      if (_users != null && _users.isNotEmpty && _users.length > 1) {
        // Login As Next Avaliable User
        switchToAccount(_users?.first);
      }
    }

    notifyListeners();
  }

  void switchToAccount(UserObject newUser, {bool softLogin = false}) {
    if (!_users.contains(newUser)) _users.add(newUser);
    if (!softLogin) {
      _currentUser = newUser;
      _loggedIn = true;
      _userChanged = true;
      _saveUsers();
    }
    notifyListeners();
  }

  void confirmUserChange() {
    _userChanged = false;
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    var _newUsers = await _loadUsers();
    if (_newUsers.isNotEmpty) {
      _users = _newUsers;
    } else {
      _loggedIn = false;
      notifyListeners();
      return false;
    }
    switchToAccount(_users?.first);
    notifyListeners();
    return true;
  }

  Future refreshToken() async {
    await login(
      username: _currentUser?.username,
      password: _currentUser?.password,
    );
  }

  // void _saveInfoToDisk({@required String username, @required String password}) {
  //   var prefs = AppPreferences();
  //   prefs.setInfo(Info.username, username);
  //   prefs.setSecure(Info.password, password);

  //   saveUsers();
  // }

  Future<List<UserObject>> _loadUsers() async {
    var prefs = AppPreferences();
    List<UserObject> _newUsers = [];
    var _list = await prefs.getList(Info.users);
    if (_list != null && _list.length > kMultipleAccounts) {
      prefs.setList(Info.users, [_list[0], _list[1], _list[2], _list[3]]);
      _list = await prefs.getList(Info.users);
    }
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
    for (var _item in _users) {
      var _id = uuid.v4();
      _list.add(_id);
      sharedPrefs.setString(_id, _item.username);
      storage.write(key: _id, value: _item.password);
    }
    prefs.setList(Info.users, _list);
  }

  void removeUser(UserObject user) {
    _users.remove(user);
    if (user == _currentUser && (_users != null && _users.isNotEmpty)) {
      switchToAccount(_users?.first);
    }
    notifyListeners();
  }

  Future resetUsers() async {
    _currentUser = null;
    _users.clear();
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
      _error = "";
    } catch (e) {
      _newToken = "";
      _error = e.toString();
      print(_error);
    }
    return _newToken;
  }

  Future<UserObject> _getUser(
    String token, {
    @required String username,
    @required String password,
  }) async {
    var _auth = AuthRepository();
    UserObject _user;
    try {
      var _result = await _auth.getInfo(token);
      _user = UserObject(
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
