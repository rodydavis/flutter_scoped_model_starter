import 'package:flutter/material.dart';
import '../data/models/theme.dart';
import '../data/models/auth.dart';
import '../data/local_storage.dart';

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
      await widget.authModel.autoLogin();
      if (widget.authModel?.currentUser == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/counter');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
