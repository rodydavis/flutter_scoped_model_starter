import 'package:flutter/material.dart';

import 'edit.dart';
import 'view.dart';

class ContactGroupsScreen extends StatelessWidget {
  void _editGroup(BuildContext context,
      {bool isNew = true, String id = "", String name = ""}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditContactGroup(isNew: isNew),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        // ContactDetails _item = value;
        // widget.model.editItem(context, item: _item, id: item?.id);
        // Navigator.pop(context);
      }
    });
  }

  void _viewList(BuildContext context, {String id = "", String name = ""}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactGroupList(groupName: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Groups"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _editGroup(context, isNew: true),
          ),
        ],
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this would produce 2 rows.
        crossAxisCount: 2,
        // Generate 100 Widgets that display their index in the List
        children: List.generate(100, (index) {
          return InkWell(
            onTap: () =>
                _viewList(context, name: 'Item $index', id: index.toString()),
            onLongPress: () => _editGroup(context,
                isNew: false, name: 'Item $index', id: index.toString()),
            child: Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          );
        }),
      ),
    );
  }
}
