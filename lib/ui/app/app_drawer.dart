import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/auth/model.dart';
import '../../data/models/theme.dart';
import '../../widgets/profile_avatar.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    NavigatorState navigator = Navigator.of(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(color: Colors.transparent),
                accountName: Text(
                  _user?.currentUser?.fullName ?? "Guest",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                accountEmail: Text(
                  _user?.currentUser?.email ?? "No Email Found",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle.color,
                  ),
                ),
                currentAccountPicture: AvatarWidget(
                  imageURL: _user?.currentUser?.profileImageUrl,
                )),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => navigator.popAndPushNamed("/home"),
          ),
          // STARTER: menu - do not remove comment
          ListTile(
            leading: Icon(Icons.my_location),
            title: Text('CRUD'),
            onTap: () => navigator.popAndPushNamed("/crud"),
          ),

          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Counter'),
            onTap: () => navigator.popAndPushNamed("/counter"),
          ),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Contacts'),
            onTap: () => navigator.popAndPushNamed("/contacts"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => navigator.popAndPushNamed("/settings"),
          ),

          AboutListTile(
            applicationName: 'Scoped Model',
            icon: Icon(Icons.info_outline),
            child: Text('About'),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              _user.logout();
              navigator.pop();
              navigator.pushReplacementNamed("/login");
            },
          ),
        ],
      ),
    );
  }
}
