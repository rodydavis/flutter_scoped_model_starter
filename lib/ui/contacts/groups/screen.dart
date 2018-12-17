import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../data/models/contact_model.dart';
import 'edit.dart';
import 'view.dart';
import '../../../data/classes/unify/contact_group.dart';

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
          builder: (context) => EditContactGroup(
                isNew: isNew,
                groupName: name,
                id: id,
              ),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        model.loadContactGroups(context);
      }
    });
  }

  void _viewList(BuildContext context, {String id = "", String name = ""}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactGroupList(groupName: name),
      ),
    ).then((value) {
      if (value != null) {
        model.loadContactGroups(context);
      }
    });
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
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: model?.groups?.length,
        itemBuilder: (BuildContext context, int index) {
          final _group = model?.groups[index];
          // return InkWell(
          //   onTap: () => _viewList(
          //         context,
          //         name: _group?.name,
          //         id: _group?.id,
          //       ),
          //   onLongPress: () => _editGroup(
          //         context,
          //         isNew: false,
          //         name: _group?.name,
          //         id: _group?.id,
          //       ),
          //   child: SafeArea(
          //     child: Center(
          //       child: Text(
          //         _group?.name ?? "No Name Found",
          //         textAlign: TextAlign.center,
          //         style: Theme.of(context).textTheme.title,
          //       ),
          //     ),
          //   ),
          // );
          return SafeArea(
            child: WrapItem(
              _group,
              true,
              index: index,
              onTap: () => _viewList(
                    context,
                    name: _group?.name,
                    id: _group?.id,
                  ),
              onLongPressed: () => _editGroup(
                    context,
                    isNew: false,
                    name: _group?.name,
                    id: _group?.id,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class WrapItem extends StatelessWidget {
  const WrapItem(
    this.item,
    this.isSource, {
    this.index = 0,
    this.onTap,
    this.onLongPressed,
  }) : size = isSource ? 40.0 : 50.0;
  final bool isSource;
  final double size;
  final int index;
  final ContactGroup item;
  final VoidCallback onTap, onLongPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => SidekickTeamBuilder.of<Item>(context).move(item),
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size - 4,
          width: size - 4,
          decoration: new BoxDecoration(
              color: _getColor(index),
              borderRadius: new BorderRadius.all(const Radius.circular(60.0))),
          child: Center(
            child: Text(item?.name ?? "No Name Found",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    switch (index % 4) {
      // case 0:
      //   return Colors.blueGrey;
      // case 1:
      //   return Colors.red;
      // case 2:
      //   return Colors.purple;
      // case 3:
      //   return Colors.green;
    }
    return Colors.blueGrey;
  }
}
