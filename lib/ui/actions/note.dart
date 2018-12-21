import 'package:flutter/material.dart';

class AddNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
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

Future createNote(BuildContext context) async {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new AddNotePage(),
        fullscreenDialog: true,
      ));
}
