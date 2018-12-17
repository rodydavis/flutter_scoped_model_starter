import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../data/models/contact_model.dart';
import 'edit.dart';
import 'view.dart';

class ContactGroupsScreen extends StatelessWidget {
  final ContactModel model;

  ContactGroupsScreen({
    this.model,
  });

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
    if (model?.groups == null || model.groups.isEmpty) {
      model.loadContactGroups(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Groups"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => model.loadContactGroups(context),
          ),
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () => _editGroup(context, isNew: true),
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          // // Create a grid with 2 columns. If you change the scrollDirection to
          // // horizontal, this would produce 2 rows.
          // crossAxisCount: 2,
          // // Generate 100 Widgets that display their index in the List
          // children: List.generate(model?.groups?.length, (index) {
          //   final _group = model?.groups[index];
          //   return InkWell(
          //     onTap: () => _viewList(
          //           context,
          //           name: _group?.name,
          //           id: _group?.id,
          //         ),
          //     onLongPress: () => _editGroup(
          //           context,
          //           isNew: false,
          //           name: _group?.name,
          //           id: _group?.id,
          //         ),
          //     child: Center(
          //       child: Text(
          //         _group?.name ?? "No Name Found",
          //         style: Theme.of(context).textTheme.headline,
          //       ),
          //     ),
          //   );
          // }),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: model?.groups?.length,
          itemBuilder: (BuildContext context, int index) {
            final _group = model?.groups[index];
            return InkWell(
              onTap: () => _viewList(
                    context,
                    name: _group?.name,
                    id: _group?.id,
                  ),
              onLongPress: () => _editGroup(
                    context,
                    isNew: false,
                    name: _group?.name,
                    id: _group?.id,
                  ),
              child: GridTile(
                // header: Text(
                //   _group?.name ?? "No Name Found",
                //   style: Theme.of(context).textTheme.title,
                // ),
                key: Key(index.toString()),
                // child: Container(),
                child: Center(
                  child: Text(
                    _group?.name ?? "No Name Found",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
