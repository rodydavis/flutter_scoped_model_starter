import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../local_storage.dart';
import '../../repositories/auth_repository.dart';
import 'info.dart';

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
  String _token = "";
  String _error = "";

  bool get loggedIn => _loggedIn;
  String get token => _token;
  List<UserObject> get users => _users;
  UserObject get currentUser => _currentUser;

  Future login(
      {@required String username,
      @required String password,
      bool softLogin = false}) async {
    var _auth = AuthRepository();
    // -- Login --
    try {
      _token = await _auth.login(username, password);
      _error = "";
      // _saveInfoToDisk(username: username, password: password);
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
        var _user = UserObject(
          token: _token,
          data: _result?.result,
          username: username,
          password: password,
        );
        // if (!_users.contains(_user)) _users.add(_user);
        switchToAccount(_user, softLogin: softLogin);
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

  void switchToAccount(UserObject newUser, {bool softLogin = false}) {
    if (!_users.contains(newUser)) _users.add(newUser);
    if (!softLogin) {
      _currentUser = newUser;
      _token = newUser?.token;
      _loggedIn = true;
      saveUsers();
    }
    notifyListeners();
  }

  Future autoLogin() async {
    await loadUsers();
    // var prefs = AppPreferences();
    // var _username = await prefs.getInfo(Info.username);
    // var _password = await prefs.getSecure(Info.password);

    // login(username: _username, password: _password);
    if (_users == null || _users.isEmpty) _loggedIn = false;
  }

  void _saveInfoToDisk({@required String username, @required String password}) {
    var prefs = AppPreferences();
    prefs.setInfo(Info.username, username);
    prefs.setSecure(Info.password, password);

    saveUsers();
  }

  Future loadUsers() async {
    var prefs = AppPreferences();
    var _list = await prefs.getList(Info.users);

    final storage = new FlutterSecureStorage();
    final sharedPrefs = await SharedPreferences.getInstance();

    if (_list != null && _list.isNotEmpty) {
      for (var _id in _list) {
        var _username = sharedPrefs.getString(_id);
        var _password = await storage.read(key: _id);
        login(username: _username, password: _password, softLogin: true);
      }
      if (_users != null && _users.isNotEmpty)
        switchToAccount(_users?.first, softLogin: false);
    }
  }

  Future saveUsers() async {
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
}
