import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/auth/model.dart';
import 'auth/login.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    final _user = _model?.currentUser?.data;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.people)),
            ],
          ),
          title: Text('Account Info'),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.restore),
            //   onPressed: () {
            //     _model?.resetUsers();
            //     Navigator.pushReplacementNamed(context, "/login");
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(),
                      fullscreenDialog: true),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                ListTile(
                  title: Text(_user?.fullName),
                ),
                ListTile(
                  title: Text(_user?.email),
                ),
                ListTile(
                  title: Text(_user?.licenseNumber),
                ),
                ListTile(
                  title: Text(_user?.title),
                ),
              ],
            ),
            ListView.builder(
              itemCount: _model?.users?.length,
              itemBuilder: (BuildContext context, int index) {
                final _item = _model?.users[index];
                return ListTile(
                  selected: _item == _model?.currentUser,
                  title: Text(_item?.data?.fullName),
                  subtitle: Text(_item?.data?.email),
                  trailing: IconButton(
                    tooltip: "Logout",
                    icon: Icon(Icons.close),
                    onPressed: () {
                      if (_model?.users?.length == 1) {
                        _model.logout();
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, "/login");
                      } else {
                        _model?.removeUser(_item);
                      }
                    },
                  ),
                  onTap: () {
                    _model.switchToAccount(_item);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
