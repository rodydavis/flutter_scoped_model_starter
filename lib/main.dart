import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/models/auth/model.dart';
import 'data/models/contact/model.dart';
import 'data/models/theme.dart';
import 'screens/auth/login.dart';
import 'screens/contacts/screen.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/account.dart';
import 'screens/splash_screen.dart';
import 'widgets/flutter_drawer_demo.dart';

// STARTER: import - do not remove comment

void main() => runApp(MyApp());

// -- Models --
final AuthModel authModel = AuthModel();
final ThemeModel themeModel = ThemeModel();
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
      title: 'Scoped Model Starter',
      theme: _model.theme,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        '/account': (BuildContext context) => AccountPage(),
        '/settings': (BuildContext context) => SettingsPage(),
        // STARTER: routes - do not remove comment
        '/contacts': (BuildContext context) =>
            ContactScreen(model: contactModel),
      },
    );
  }
}
