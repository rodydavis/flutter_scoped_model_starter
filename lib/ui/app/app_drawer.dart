import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../../data/classes/auth/auth_user.dart';
import '../../ui/auth/login.dart';
import '../../ui/general/profile_avatar.dart';
import '../../utils/two_letter_name.dart';
import '../../utils/url.dart';
import '../../data/models/auth_model.dart';
//import '../../main.dart';
import '../account/screen.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  AppDrawerState createState() {
    return new AppDrawerState();
  }
}

class AppDrawerState extends State<AppDrawer> {
  bool _showAllAccounts = false;

  @override
  Widget build(BuildContext context) {
    NavigatorState navigator = Navigator.of(context);

    return new ScopedModelDescendant<AuthModel>(
        builder: (context, child, auth) => Drawer(
              child: SingleChildScrollView(
                  child: AnimatedCrossFade(
                firstChild:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  _DrawerHeader(
                    showAccounts: true,
                    showAccountsTap: () {
                      setState(() {
                        _showAllAccounts = true;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () => navigator.pushReplacementNamed("/home"),
                  ),

                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Dashboard'),
                    onTap: () => navigator.pushReplacementNamed("/dashboard"),
                  ),
                  // STARTER: menu - do not remove comment

                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text('Contacts'),
                    onTap: () => navigator.pushReplacementNamed("/contacts"),
                  ),

                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Leads'),
                    onTap: () => navigator.pushReplacementNamed("/leads"),
                  ),

                  ListTile(
                    leading: Icon(Icons.folder),
                    title: Text('Loans'),
                    onTap: () => navigator.pushReplacementNamed("/loans"),
                  ),

                  ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text('Unify Video'),
                    onTap: () => navigator.pushReplacementNamed("/unify_video"),
                    trailing: IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () =>
                          launchURL('https://myunifyvideo.page.link/5WrR'),
                    ),
                  ), // Add Unify Video Icon

                  // Todo: Add Screens...

                  //          ListTile(
                  //            leading: Icon(Icons.videocam),
                  //            title: Text('Whats New'),
                  //            // onTap: () => navigator.pushReplacementNamed("/leads"),
                  //          ),

                  Divider(),

//          Container(
//            child: ListTile(
//              leading: Icon(Icons.file_upload),
//              trailing: Container(
//                width: 35.0,
//                height: 35.0,
//                decoration: new BoxDecoration(
//                    color:
//                        0 == 0 ? Colors.grey : Theme.of(context).primaryColor,
//                    borderRadius:
//                        new BorderRadius.all(const Radius.circular(17.0))),
//                child: Text(
//                  "0",
//                  style: Theme.of(context)
//                      .textTheme
//                      .display1
//                      .copyWith(color: Colors.white),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              title: Text('Pending'),
////            onTap: () => navigator.popAndPushNamed("/pending"),
//            ),
//          ),

                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Search'),
                    onTap: () => navigator.popAndPushNamed("/search"),
                  ),
//
//          ListTile(
//            leading: Icon(Icons.star),
//            title: Text("What's New"),
////            onTap: () => navigator.popAndPushNamed("/whats_new"),
//          ),

                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () => navigator.popAndPushNamed("/settings"),
                  ),

                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                    onTap: () => navigator.popAndPushNamed("/help"),
                  ),

                  // AboutListTile(
                  //   applicationName: 'My Unify Mobile',
                  //   icon: Icon(Icons.info_outline),
                  //   child: Text('About'),
                  // ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      auth.logout();
                      navigator.pop();
                      navigator.pushReplacementNamed("/login");
                    },
                    trailing: (auth?.users?.length ?? 0) >= kMultipleAccounts
                        ? null
                        : IconButton(
                            tooltip: "Login to Another Account",
                            icon: Icon(Icons.add),
                            onPressed: () {
                              auth.logout(force: false);
                              navigator.pop();
                              navigator.push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage(addUser: true),
                                    fullscreenDialog: true),
                              );
                            },
                          ),
                  ),
                ]),
                secondChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _DrawerHeader(
                      showAccounts: false,
                      showAccountsTap: () {
                        setState(() {
                          _showAllAccounts = false;
                        });
                      },
                    ),
                  ]
                    ..addAll(auth.users
                        .map((u) => ListTile(
                              leading: AvatarWidget(
                                imageURL: u?.data?.profileImageUrl,
                                noImageText: convertNamesToLetters(
                                  u?.data?.firstName,
                                  u?.data?.lastName,
                                ),
                              ),
                              selected: u == auth?.currentUser,
                              title: Text(u?.data?.fullName),
                              subtitle: Text(u?.username),
                              trailing: IconButton(
                                tooltip: "Logout",
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  if (auth?.users?.length == 1) {
                                    auth.logout();
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                        context, "/login");
                                  } else {
                                    auth?.removeUser(u);
                                  }
                                },
                              ),
                              onTap: () {
                                auth.switchToAccount(u);
                              },
                            ))
                        .toList())
                    ..add(
                      ListTile(
                        leading: Icon(Icons.add),
                        title: Text("Add Account"),
                        onTap: () {
                          auth.logout(force: false);
                          navigator.pop();
                          navigator.push(
                            MaterialPageRoute(
                                builder: (context) => LoginPage(addUser: true),
                                fullscreenDialog: true),
                          );
                        },
                      ),
                    ),
                ),
                crossFadeState: _showAllAccounts
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              )),
            ));
  }
}

class _DrawerHeader extends StatelessWidget {
  final bool showAccounts;
  final VoidCallback showAccountsTap;

  _DrawerHeader({
    this.showAccounts = false,
    this.showAccountsTap,
  });

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<AuthModel>(
      builder: (context, child, auth) {
        final _item = auth?.currentUser?.data;
        final _otherUsers = auth.users
            .where((a) => a.data.userId != auth.currentUser.data.userId);

        return Container(
          child: Stack(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  image: _item?.companyImageUrl == null
                      ? null
                      : DecorationImage(
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
                otherAccountsPictures: _otherUsers
                    .map((u) => GestureDetector(
                          onTap: () {
                            print("Switching Accounts... ${u?.data?.fullName}");
                            auth.switchToAccount(u);
                          },
                          child: Semantics(
                            label: "Switch to this Account",
                            child: AvatarWidget(
                              imageURL: u?.data?.profileImageUrl,
                              noImageText: convertNamesToLetters(
                                u?.data?.firstName,
                                u?.data?.lastName,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                margin: EdgeInsets.zero,
                onDetailsPressed: () =>
                    Navigator.of(context).popAndPushNamed("/account"),
              ),
              Positioned(
                right: 8.0,
                bottom: 8.0,
                child: IconButton(
                  icon: showAccounts
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(Icons.arrow_drop_up),
                  iconSize: 30.0,
                  onPressed: showAccountsTap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
