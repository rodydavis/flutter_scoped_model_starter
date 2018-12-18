import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/local_storage.dart';
import '../../data/models/auth_model.dart';
import 'package:navigate/navigate.dart';
import '../../data/models/theme_model.dart';
import '../../routes.dart';

// class LoadingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
//     final _theme = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
//     return LoadingScreen(
//       auth: _auth,
//       theme: _theme,
//       duration: Duration(seconds: 10),
//     );
//   }
// }

class SplashScreen extends StatelessWidget {
  final AuthModel auth;

  SplashScreen({this.auth}) {
    Navigate.registerRoutes(
        routes: routes, defualtTransactionType: TransactionType.fromRight);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(auth: auth, duration: Duration(seconds: 30));
  }
}

class LoadingScreen extends StatefulWidget {
  final Duration duration;
  final AuthModel auth;

  const LoadingScreen({@required this.duration, this.auth});

  @override
  LoadingScreenState createState() => new LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool autoLogin = false;
  String _message = "Loading...";

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    var prefs = AppPreferences();
    var _autoLogin = await prefs.getSetting(Settings.autoSignin);
    setState(() {
      autoLogin = _autoLogin;
    });
    print("Should Log In :$_autoLogin");
    if (_autoLogin ?? false) {
      setState(() {
        _message = "Signing In...";
      });
      _loginAuto(context);
    } else {
      // -- Manual Login --
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _loginAuto(BuildContext context) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    // -- Auto Login --
    var _valid = await _auth.autoLogin();

    if (!_valid) {
      // -- Login Failed --
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // -- Valid User --
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    int _count = _auth?.usersCount ?? 0;
    int _users = _auth?.usersAdded ?? 0;
    final _theme = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
    if (!_theme.isLoaded) _theme.loadSavedTheme();

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: _auth?.progress,
            ),
          ),
          Text(_message.contains("Signing In")
              ? _message + " ($_users/$_count)"
              : _message),
          RaisedButton(
            child: Text("Cancel"),
            onPressed: () {
              setState(() {
                autoLogin = false;
                Navigator.pushReplacementNamed(context, '/login');
              });
            },
          )
        ],
      )),
    );
  }
}
