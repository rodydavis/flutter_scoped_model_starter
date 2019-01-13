import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../../data/classes/auth/auth_user.dart';
import '../../data/classes/general/phone.dart';
import '../../data/models/app_model.dart';
import '../../ui/auth/login.dart';
import '../../ui/general/email_tile.dart';
import '../../ui/general/phone_tile.dart';
import '../../ui/general/profile_avatar.dart';
import '../../utils/two_letter_name.dart';
import '../../data/models/auth_model.dart';
import '../../main.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _app = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Details"),
              Tab(text: "Users"),
            ],
          ),
          title: Text('My Account'),
          actions: (authModel?.users?.length ?? 0) >= kMultipleAccounts
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
            AccountsScreen(),
          ],
        ),
      ),
    );
  }
}

class _AccountInfoScreen extends StatelessWidget {
  Widget _buildPhone(BuildContext context, {Phone phone, String label = ""}) {
    if (phone == null) return Container();
    return PhoneTile(label: label, number: phone);
  }

  @override
  Widget build(BuildContext context) {
    final _user = authModel?.currentUser?.data;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(_user?.fullName),
            subtitle: Text(_user?.title),
          ),
          EmailTile(
            label: "Email Address",
            email: _user?.email,
          ),
          _buildPhone(
            context,
            phone: _user?.phones[0],
            label: "Primary Number",
          ),
          _buildPhone(
            context,
            phone: _user?.phones[1],
            label: "Secondary Number",
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text(_user?.licenseNumber),
          ),
        ],
      ),
    );
  }
}

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final _app = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    return new ScopedModelDescendant<AuthModel>(
        builder: (context, child, auth) => Container(
              child: new DragAndDropList<AuthUser>(
                authModel?.users,
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
                    selected:
                        _item.data.userId == authModel.currentUser.data.userId,
                    title: Text(_item?.data?.fullName),
                    subtitle: Text(_item?.username),
                    trailing: IconButton(
                      tooltip: "Logout",
                      icon: Icon(Icons.close),
                      onPressed: () {
                        if (authModel?.users?.length == 1) {
                          authModel.logout();
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, "/login");
                        } else {
                          authModel?.removeUser(_item);
                        }
                      },
                    ),
                    onTap: () {
                      authModel.switchToAccount(_item);
                    },
                  );
                },
                onDragFinish: authModel.changeUsersOrder,
                canBeDraggedTo: (one, two) => true,
                dragElevation: 8.0,
              ),
            ));
  }
}
