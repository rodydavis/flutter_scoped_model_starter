import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, "/settings"),
        ),
      ),
      body: Container(
        child: Center(
          child: Text(_user.currentUser?.username ?? "Guest"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.exit_to_app),
        label: Text("Open Counter"),
        onPressed: () => Navigator.pushNamed(context, "/counter"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
