import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/models/auth/model.dart';
import 'data/models/contact_model.dart';
import 'data/models/counter.dart';
import 'data/models/crud_model.dart';
import 'data/models/theme.dart';
import 'screens/auth/login.dart';
import 'screens/contacts/screen.dart';
import 'screens/counter/counter_page.dart';
import 'screens/crud/crud_screen.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/splash_screen.dart';

// STARTER: import - do not remove comment

void main() => runApp(MyApp());

// -- Models --
final AuthModel authModel = AuthModel();
final ThemeModel themeModel = ThemeModel();
final CounterModel counterModel = CounterModel();
final CRUDModel crudModel = CRUDModel();
final ContactModel contactModel = ContactModel();

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
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        '/settings': (BuildContext context) => SettingsPage(),
        // STARTER: routes - do not remove comment
        '/counter': (BuildContext context) => CounterPage(model: counterModel),
        '/crud': (BuildContext context) => CRUDScreen(model: crudModel),
        '/contacts': (BuildContext context) =>
            ContactScreen(model: contactModel),
      },
    );
  }
}
