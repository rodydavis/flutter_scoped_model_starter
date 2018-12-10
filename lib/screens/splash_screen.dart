import 'package:flutter/material.dart';
import '../data/models/theme.dart';
import '../data/models/auth/model.dart';
import '../data/local_storage.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

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
      _loginAuto(context);
    } else {
      // -- Manual Login --
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _loginAuto(BuildContext context) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    // -- Auto Login --
    await _auth.autoLogin();

    if (_auth?.loggedIn ?? false) {
      print("Logged In :${_auth?.loggedIn}");
      // -- Login Failed --
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // -- Valid User --
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NativeLoadingIndicator(
          text: Text("Loading..."),
        ),
      ),
    );
  }
}
