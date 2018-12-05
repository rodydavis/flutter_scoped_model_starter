import 'package:flutter/material.dart';
import '../data/models/theme.dart';
import '../data/models/auth.dart';
import '../data/local_storage.dart';
import 'package:native_widgets/native_widgets.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;
  final ThemeModel themeModel;
  final AuthModel authModel;

  const SplashScreen({
    @required this.duration,
    this.themeModel,
    this.authModel,
  });

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    widget.themeModel.loadSavedTheme();
    var prefs = AppPreferences();
    var _autoLogin = await prefs.getSetting(Settings.autoSignin);
    if (_autoLogin ?? false) {
      // -- Auto Login --
      await widget.authModel.autoLogin();

      if (widget.authModel?.currentUser == null) {
        // -- Login Failed --
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // -- Valid User --
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      // -- Manual Login --
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NativeLoadingIndicator(
        text: Text("Loading..."),
      ),
    );
  }
}
