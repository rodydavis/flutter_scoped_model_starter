import 'package:flutter/material.dart';

class EditContactGroup extends StatelessWidget {
  final bool isNew;
  final String groupName, id;
  EditContactGroup({this.isNew, this.id, this.groupName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? "Add Contact Group" : "Edit Contact Group"),
      ),
    );
  }
}
