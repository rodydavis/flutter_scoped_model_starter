import 'package:flutter/material.dart';
import 'edit.dart';

class ContactGroupsScreen extends StatelessWidget {
  void _editGroup(BuildContext context, {bool isNew = true}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Groups"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _editGroup(context, isNew: true),
          )
        ],
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this would produce 2 rows.
        crossAxisCount: 2,
        // Generate 100 Widgets that display their index in the List
        children: List.generate(100, (index) {
          return InkWell(
            onLongPress: () => _editGroup(context, isNew: false),
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
