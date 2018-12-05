import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../data/models/theme.dart';
import '../data/local_storage.dart';
import '../widgets/components/settings/section.dart';

class SettingsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SettingsPage> {
  bool _darkMode = false;
  bool _trueBlack = false;

  @override
  void initState() {
    _initPlatformAsync();
    super.initState();
  }

  _initPlatformAsync() async {
    var _prefs = AppPreferences();
    _darkMode = await _prefs.getBool(Settings.darkMode.toString());
    _trueBlack = await _prefs.getBool(Settings.trueBlack.toString());
    setState(() {
      print("Settings Loaded");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
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
                        theme.darkMode(trueBlack: _trueBlack);
                      } else {
                        theme.lightMode();
                      }
                    }
                  },
                ),
              ),
              _darkMode ?? false
                  ? ListTile(
                      title: Text("True Black"),
                      subtitle: Text("Looks better on OLED Screen"),
                      trailing: Switch(
                        value: _trueBlack ?? false,
                        onChanged: (bool value) {
                          setState(() => _trueBlack = value);
                          if (value != null) {
                            theme.darkMode(trueBlack: value);
                          }
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
