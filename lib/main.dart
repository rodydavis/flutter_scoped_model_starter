import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/data/models/tasks/task_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants.dart';
import 'data/models/app_model.dart';
import 'data/models/auth_model.dart';
import 'data/models/contacts/details.dart';
import 'data/models/leads/details.dart';
import 'ui/account/screen.dart';
import 'ui/app/splash_screen.dart';
import 'ui/auth/login.dart';
import 'ui/general/data_table.dart';
import 'ui/help/support.dart';
import 'ui/home/screen.dart';
import 'ui/settings/screen.dart';

// STARTER: import - do not remove comment

void main() => runApp(MyApp());

final AuthModel authModel = AuthModel();
final AppState appModel = AppState();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<AppState>(
        model: appModel,
        child: ScopedModel<AuthModel>(
          model: authModel,
          child: _MainApp(),
        ));
  }
}

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(builder: (context, child, app) {
      return MaterialApp(
        debugShowCheckedModeBanner: !devMode,
//      showPerformanceOverlay: true,
        title: 'Unify Mobile',
        theme: app.theme,
        home: SplashScreen(auth: authModel),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) =>
              LoginPage(username: authModel?.currentUser?.username),
          '/home': (BuildContext context) => HomePage(),
          SupportPage.routeName: (BuildContext context) => SupportPage(),
          '/account': (BuildContext context) => AccountPage(),

          '/settings': (BuildContext context) => SettingsPage(),
          // STARTER: routes - do not remove comment
        },
      );
    });
  }
}
