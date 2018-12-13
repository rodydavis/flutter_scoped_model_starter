import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/local_storage.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/theme_model.dart';
import '../../../ui/general/settings_section.dart';

class SettingsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SettingsPage> {
  bool _darkMode = false;
  bool _trueBlack = false;
  bool _autoSignIn = true;

  @override
  void initState() {
    _initPlatformAsync();
    super.initState();
  }

  _initPlatformAsync() async {
    var _prefs = AppPreferences();
    _darkMode = await _prefs.getSetting(Settings.darkMode);
    _trueBlack = await _prefs.getSetting(Settings.trueBlack);
    _autoSignIn = await _prefs.getSetting(Settings.autoSignin);
    setState(() {
      print("Settings Loaded");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
    final _user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          SettingsSection(
            name: "Theme",
            items: <Widget>[
              ListTile(
                title: Text("Dark Mode"),
                subtitle: Text("Dark Themed Elements"),
                trailing: Switch(
                  value: _darkMode ?? false,
                  onChanged: (bool value) {
                    setState(() => _darkMode = value);
                    if (value != null) {
                      if (value) {
                        _theme.darkMode(trueBlack: _trueBlack);
                      } else {
                        _theme.lightMode();
                      }
                    }
                  },
                ),
              ),
              _darkMode ?? false
                  ? ListTile(
                      title: Text("True Black"),
                      subtitle: Text("Black on OLED Screens"),
                      trailing: Switch(
                        value: _trueBlack ?? false,
                        onChanged: (bool value) {
                          setState(() => _trueBlack = value);
                          if (value != null) {
                            _theme.darkMode(trueBlack: value);
                          }
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
          SettingsSection(
            initiallyExpanded: false,
            name: "Authentication",
            items: <Widget>[
              ListTile(
                title: Text("Auto Sign In"),
                subtitle: Text("Sign In Every Time You Open The App"),
                trailing: Switch(
                  value: _autoSignIn ?? true,
                  onChanged: (bool value) {
                    setState(() => _autoSignIn = value);
                    if (value != null) {
                      var _prefs = AppPreferences();
                      _prefs.setSetting(Settings.autoSignin, value);
                    }
                  },
                ),
              ),
            ],
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _user.logout().then((_) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "/login");
              });
            },
          ),
          // ListTile(
          //   title: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Text(
          //           "Delete All Data",
          //           style: TextStyle(color: Colors.red),
          //         ),
          //       ]),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
