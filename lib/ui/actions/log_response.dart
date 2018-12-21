import 'package:flutter/material.dart';

class LogResponsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Log Response"),
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

Future createLogResponse(BuildContext context) async {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LogResponsePage(),
        fullscreenDialog: true,
      ));
}
