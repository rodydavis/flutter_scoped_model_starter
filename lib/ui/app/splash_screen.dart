import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/local_storage.dart';
import '../../data/models/auth/model.dart';
import '../../data/models/theme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    final _theme = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
    return _SplashScreen(
      auth: _auth,
      theme: _theme,
      duration: Duration(seconds: 10),
    );
  }
}

class _SplashScreen extends StatefulWidget {
  final Duration duration;
  final AuthModel auth;
  final ThemeModel theme;

  const _SplashScreen({@required this.duration, this.auth, this.theme});

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen>
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
    widget.theme.loadSavedTheme();
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
        ],
      )),
    );
  }
}
