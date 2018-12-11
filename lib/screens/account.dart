import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:scoped_model/scoped_model.dart';

import '../constants.dart';
import '../data/models/auth/model.dart';
import '../ui/containers/profile_avatar.dart';
import '../utils/two_letter_name.dart';
import 'auth/login.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
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
          actions: (_model?.users?.length ?? 0) >= kMultipleAccounts
              ? null
              : <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(addUser: true),
                            fullscreenDialog: true),
                      );
                    },
                  ),
                ],
        ),
        body: TabBarView(
          children: [
            _AccountInfoScreen(),
            _AccountsScreen(),
          ],
        ),
      ),
    );
  }
}

class _AccountInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    final _user = _model?.currentUser?.data;
    return ListView(
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
    );
  }
}

class _AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return new DragAndDropList<UserObject>(
      _model?.users,
      itemBuilder: (BuildContext context, item) {
        final _item = item;
        return ListTile(
          leading: AvatarWidget(
            imageURL: _item?.data?.profileImageUrl,
            noImageText: convertNamesToLetters(
              _item?.data?.firstName,
              _item?.data?.lastName,
            ),
          ),
          selected: _item == _model?.currentUser,
          title: Text(_item?.data?.fullName),
          subtitle: Text(_item?.username),
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
      onDragFinish: _model.changeUsersOrder,
      canBeDraggedTo: (one, two) => true,
      dragElevation: 8.0,
    );
  }
}
