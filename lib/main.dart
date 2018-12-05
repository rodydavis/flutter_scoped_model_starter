import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/models/counter.dart';
import 'data/models/theme.dart';
import 'screens/home.dart';
import 'screens/splash_screen.dart';
import 'screens/settings.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<ThemeModel>(
      model: ThemeModel(),
      child: AppTheme(),
    );
  }
}

class AppTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _model.theme,
      home: HomePage(model: _model),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/settings': (BuildContext context) => SettingsPage(),
      },
    );
  }
}
