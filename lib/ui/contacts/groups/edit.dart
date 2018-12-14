import 'package:flutter/material.dart';

class EditContactGroup extends StatelessWidget {
  final bool isNew;
  EditContactGroup({this.isNew});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? "Add Contact Group" : "Edit Contact Group"),
      ),
    );
  }
}
