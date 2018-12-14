import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants.dart';
import 'data/models/auth_model.dart';
import 'data/models/contact_model.dart';
import 'data/models/task_model.dart';
import 'data/models/theme_model.dart';
import 'ui/app/account/screen.dart';
import 'ui/app/home/screen.dart';
import 'ui/app/settings/screen.dart';
import 'ui/app/splash_screen.dart';
import 'ui/auth/login.dart';
import 'ui/contacts/screen.dart';
import 'ui/phone_contacts/import.dart';
import 'ui/contacts/groups/list.dart';

// STARTER: import - do not remove comment

void main() => runApp(MyApp());

// -- Models --
final AuthModel authModel = AuthModel();
final ThemeModel themeModel = ThemeModel();
final ContactModel contactModel = ContactModel();
final TaskModel taskModel = TaskModel();

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
      debugShowCheckedModeBanner: !devMode,
      title: 'Scoped Model Starter',
      theme: _model.theme,
      home: SplashScreen(duration: Duration(seconds: 3), auth: authModel),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) =>
            LoginPage(username: authModel?.currentUser?.username),
        '/home': (BuildContext context) => HomePage(model: taskModel),
        '/account': (BuildContext context) => AccountPage(),
        '/settings': (BuildContext context) => SettingsPage(),
        // STARTER: routes - do not remove comment
        '/contacts': (BuildContext context) =>
            ContactScreen(model: contactModel),
        '/import': (BuildContext context) => ImportContactsScreen(),
        '/import_single': (BuildContext context) =>
            ImportContactsScreen(selectSingle: true),
        '/contact_tasks': (BuildContext context) =>
            HomePage(model: taskModel, type: TasksType.contact),
        '/lead_tasks': (BuildContext context) =>
            HomePage(model: taskModel, type: TasksType.lead),
        '/core_lead_tasks': (BuildContext context) =>
            HomePage(model: taskModel, type: TasksType.core_lead),
        '/contact_groups': (BuildContext context) => ContactGroupsScreen(),
      },
    );
  }
}
