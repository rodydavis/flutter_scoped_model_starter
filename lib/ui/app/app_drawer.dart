import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/auth/model.dart';
import '../../widgets/profile_avatar.dart';
import '../../utils/two_letter_name.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    NavigatorState navigator = Navigator.of(context);
    List<Widget> _buildOtherAccounts() {
      List<Widget> list = [];
      for (var user in _user?.users) {
        var _item = user.data;
        if (user != _user.currentUser) {
          list.add(
            GestureDetector(
              onTap: () {
                _onOtherAccountsTap(context, user: user);
              },
              child: Semantics(
                label: "Switch to this Account",
                child: AvatarWidget(
                  imageURL: _item?.profileImageUrl,
                  noImageText: convertNamesToLetters(
                    _item?.firstName,
                    _item?.lastName,
                  ),
                ),
              ),
            ),
          );
        }
      }
      return list;
    }

    var _item = _user?.currentUser?.data;
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: new UserAccountsDrawerHeader(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_item?.companyImageUrl),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                ),
              ),
              accountName: Text(
                _item?.fullName ?? "Guest",
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
              accountEmail: Text(
                _item?.email ?? "No Email Found",
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle.color,
                ),
              ),
              currentAccountPicture: AvatarWidget(
                imageURL: _item?.profileImageUrl,
              ),
              otherAccountsPictures: _buildOtherAccounts(),
              margin: EdgeInsets.zero,
              onDetailsPressed: () => navigator.popAndPushNamed("/account"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => navigator.pushReplacementNamed("/home"),
          ),
          // STARTER: menu - do not remove comment

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Contacts'),
            onTap: () => navigator.pushReplacementNamed("/contacts"),
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
            onLongPress: _user?.users?.length == 3
                ? null
                : () {
                    _user.logout(force: false);
                    navigator.popAndPushNamed("/login");
                  },
            trailing: _user?.users?.length == 3
                ? null
                : IconButton(
                    tooltip: "Login to Multiple Accounts",
                    icon: Icon(Icons.account_circle),
                    onPressed: () {
                      _user.logout(force: false);
                      navigator.popAndPushNamed("/login");
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _onOtherAccountsTap(BuildContext context, {@required UserObject user}) {
    print("Switching Accounts... ${user?.data?.fullName}");
    final _user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    if (user != null) _user.switchToAccount(user);
  }
}
