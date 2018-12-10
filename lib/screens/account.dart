import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/auth/model.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    final _user = _model?.currentUser?.data;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
        ),
        body: ListView(
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
        ));
  }
}
