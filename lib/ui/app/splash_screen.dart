import 'package:flutter/material.dart';
import 'package:navigate/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/local_storage.dart';
import '../../data/models/app_model.dart';
import '../../data/models/auth_model.dart';

class SplashScreen extends StatelessWidget {
  final AuthModel auth;

  SplashScreen({this.auth});

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
//    _initQuickActions();
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
//    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    // -- Auto Login --
    var _valid = await widget.auth.autoLogin();

    if (!_valid) {
      // -- Login Failed --
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // -- Valid User --
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

//  void _initQuickActions() {
//    final QuickActions quickActions = const QuickActions();
//    quickActions.initialize((String shortcutType) {
//      print('The user tapped on the "$shortcutType" action.');
//      if (shortcutType == 'action_contact') {
//        Navigator.pushNamed(context, '/create_contact');
//      }
//      if (shortcutType == 'action_lead') {
//        Navigator.pushNamed(context, '/create_lead');
//      }
//      if (shortcutType == 'action_tasks') {
//        Navigator.pushNamed(context, '/all_tasks');
//      }
//      if (shortcutType == 'action_calc') {
//        Navigator.pushNamed(context, '/calculator');
//      }
//    });
//
//    quickActions.setShortcutItems(<ShortcutItem>[
//      const ShortcutItem(
//        type: 'action_contact',
//        localizedTitle: 'Create Contact',
////        icon: 'AppIcon',
//      ),
//      const ShortcutItem(
//        type: 'action_lead',
//        localizedTitle: 'Create Lead',
////        icon: 'AppIcon',
//      ),
//      const ShortcutItem(
//        type: 'action_tasks',
//        localizedTitle: 'View Todays Tasks',
////        icon: 'AppIcon',
//      ),
//      const ShortcutItem(
//        type: 'action_calc',
//        localizedTitle: 'Mortgage Calculator',
////        icon: 'AppIcon',
//      ),
//    ]);
//  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    print("Current Width: ${_size.width}");
    print("Current Heigth: ${_size.height}");
////    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
//    int _count = widget.auth?.usersCount ?? 0;
//    int _users = widget.auth?.usersAdded ?? 0;

    final _app = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    if (!_app.isLoaded) _app.loadFromDisk();

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.all(8.0),
//            child: LinearProgressIndicator(
//              value: widget.auth?.progress,
//            ),
//          ),
          CircularProgressIndicator(),
//          Text(_message.contains("Signing In")
//              ? _message + " ($_users/$_count)"
//              : _message),
          Container(height: 50.0),
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
