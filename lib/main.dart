import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/models/auth.dart';
import 'data/models/counter.dart';
import 'data/models/crud.dart';
import 'data/models/theme.dart';
import 'screens/auth/login.dart';
import 'screens/counter/counter_page.dart';
import 'screens/crud/crud_screen.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

// -- Models --

final AuthModel authModel = AuthModel();
final ThemeModel themeModel = ThemeModel();
final CounterModel counterModel = CounterModel();
final CRUDModel crudModel = CRUDModel();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<ThemeModel>(
      model: themeModel,
      child: new ScopedModel<AuthModel>(
        model: authModel,
        child: AppTheme(),
      ),
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
      home: SplashScreen(
        duration: Duration(seconds: 3),
        themeModel: themeModel,
        authModel: authModel,
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/settings': (BuildContext context) => SettingsPage(),
        '/counter': (BuildContext context) => CounterPage(model: counterModel),
        '/login': (BuildContext context) => LoginPage(),
        '/crud': (BuildContext context) => CRUDScreen(model: crudModel),
      },
    );
  }
}
