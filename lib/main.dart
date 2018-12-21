import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants.dart';
import 'data/models/auth_model.dart';
import 'data/models/contacts/list.dart';
import 'data/models/leads/list.dart';
import 'data/models/task_model.dart';
import 'data/models/theme_model.dart';
import 'ui/app/account/screen.dart';
import 'ui/app/home/screen.dart';
import 'ui/app/settings/screen.dart';
import 'ui/app/splash_screen.dart';
import 'ui/auth/login.dart';
import 'ui/contacts/screen.dart';
import 'ui/leads/screen.dart';
import 'ui/phone_contacts/import.dart';
import 'data/models/contacts/groups.dart';
import 'ui/contacts/groups/screen.dart';
import 'ui/tasks/screen.dart';
import 'data/models/leads/groups.dart';
import 'ui/leads/groups/screen.dart';

// STARTER: import - do not remove comment

void main() => runApp(MyApp());

// -- Models --
final AuthModel authModel = AuthModel();
final ThemeModel themeModel = ThemeModel();
final ContactModel contactModel = ContactModel(auth: authModel);
final ContactGroupModel contactGroupModel = ContactGroupModel(auth: authModel);
final TaskModel taskModel = TaskModel(auth: authModel);
final LeadModel leadModel = LeadModel(auth: authModel);
final LeadGroupModel leadGroupModel = LeadGroupModel(auth: authModel);

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
      home: SplashScreen(auth: authModel),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) =>
            LoginPage(username: authModel?.currentUser?.username),
        '/home': (BuildContext context) => HomePage(taskModel: taskModel),

        '/account': (BuildContext context) => AccountPage(),
        '/settings': (BuildContext context) => SettingsPage(),
        // STARTER: routes - do not remove comment
        '/contacts': (BuildContext context) =>
            ContactsScreen(model: contactModel, groupModel: contactGroupModel),
        '/leads': (BuildContext context) =>
            LeadsScreen(model: leadModel, groupModel: leadGroupModel),
        '/import_multiple': (BuildContext context) => ImportContactsScreen(),
        '/import_single': (BuildContext context) =>
            ImportContactsScreen(selectSingle: true),
        '/all_tasks': (BuildContext context) => TasksScreen(model: taskModel),
        '/contact_tasks': (BuildContext context) => TasksScreen(
            model: TaskModel(auth: authModel, type: TasksType.contact),
            type: TasksType.contact),
        '/lead_tasks': (BuildContext context) => TasksScreen(
            model: TaskModel(auth: authModel, type: TasksType.lead),
            type: TasksType.lead),
        '/core_lead_tasks': (BuildContext context) => TasksScreen(
            model: TaskModel(auth: authModel, type: TasksType.core_lead),
            type: TasksType.core_lead),
        '/contact_groups': (BuildContext context) => ContactGroupsScreen(
            groupModel: contactGroupModel, contactModel: contactModel),
        '/lead_groups': (BuildContext context) =>
            LeadGroupsScreen(groupModel: leadGroupModel, leadModel: leadModel),
      },
    );
  }
}
