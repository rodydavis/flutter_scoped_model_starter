import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';

class AuthModel extends Model {
  User _currentUser;

  User get currentUser => _currentUser;

  Future login({@required String username, @required String password}) async {
    // -- Login --
    _currentUser = User(
      username: username,
      fullName: "Test User",
      email: "test@email.com",
    );
    notifyListeners();
  }

  Future logout() async {
    // -- Logout --
    _currentUser = null;
    notifyListeners();
  }

  Future refresh() async {
    // -- Load User --
    _currentUser = User(
      fullName: "Another User",
      email: "a@a.com",
    );
    notifyListeners();
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
