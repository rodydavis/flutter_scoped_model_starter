import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigatorState navigator = Navigator.of(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
              child: Container(),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('Home'),
          //   onTap: () {
          //     store.dispatch(UpdateCurrentRoute(HomeScreen.route));
          //     navigator.pushReplacementNamed(HomeScreen.route);
          //   },
          // ),
          // STARTER: menu - do not remove comment
          // ListTile(
          //   leading: Icon(Icons.people),
          //   title: Text('Contact Groups'),
          //   onTap: () => store.dispatch(ViewGroupList(context)),
          // ),

          // ListTile(
          //   leading: Icon(Icons.track_changes),
          //   title: Text('Tasks'),
          //   onTap: () => store.dispatch(ViewTaskList(context)),
          // ),

          // ListTile(
          //   leading: Icon(Icons.contacts),
          //   title: Text('Contacts'),
          //   onTap: () => store.dispatch(ViewContactList(context)),
          // ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => navigator.popAndPushNamed("/settings"),
          ),

          AboutListTile(
            applicationName: 'My Unify Mobile',
            icon: Icon(Icons.info_outline),
            child: Text('About'),
          ),

          Divider(),

          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () => store.dispatch(LoadUserLogin(context)),
          // ),
        ],
      ),
    );
  }
}
