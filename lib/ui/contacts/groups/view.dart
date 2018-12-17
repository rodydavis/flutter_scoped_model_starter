import 'package:flutter/material.dart';

import 'edit.dart';

class ContactGroupList extends StatelessWidget {
  final String groupName, id;
  ContactGroupList({this.groupName, this.id});

  void _editGroup(BuildContext context,
      {bool isNew = true, String id = "", String name = ""}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditContactGroup(
                isNew: isNew,
                groupName: name,
                id: id,
              ),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName ?? "Contact Group"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () =>
                _editGroup(context, isNew: false, name: groupName, id: id),
          ),
        ],
      ),
    );
  }
}
