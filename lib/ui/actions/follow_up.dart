import 'package:flutter/material.dart';

class FollowUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Follow Up"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          )
        ],
      ),
      body: Container(),
    );
  }
}

Future createFollowUp(BuildContext context) async {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new FollowUpPage(),
        fullscreenDialog: true,
      ));
}
