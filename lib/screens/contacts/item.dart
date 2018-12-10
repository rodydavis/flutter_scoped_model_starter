import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/models/contact/list.dart';
import '../../data/models/contact/model.dart';
import 'edit.dart';
import 'view.dart';

class ContactItem extends StatelessWidget {
  final ContactObject item;
  final ContactModel model;
  final bool share, edit, delete;
  ContactItem({
    @required this.item,
    @required this.model,
    this.share = true,
    this.edit = true,
    this.delete = true,
  });

  void _shareItem(BuildContext context) {}

  void _editItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactItemEdit(item: item),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        ContactObject _item = value;
        model.editItem(_item);
      }
    });
  }

  void _removeItem(BuildContext context) {
    model.removeItem(item);
  }

  void _viewItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactItemDetails(item: item, model: model)),
    );
  }

  dynamic _getIconButtons(BuildContext context, {bool right = true}) {
    if (right == false) {
      if (share == false) return null;
      return <Widget>[
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _shareItem(context),
        )
      ];
    }

    if (edit == false && delete == false) return null;

    var _widgets = <Widget>[];

    if (edit) {
      _widgets.add(IconSlideAction(
        caption: 'Edit',
        color: Colors.black45,
        icon: Icons.edit,
        onTap: () => _editItem(context),
      ));
    }

    if (delete) {
      _widgets.add(IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => _removeItem(context),
      ));
    }

    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    // var _name = item?.lastName.toString() + ", " + item?.firstName;
    return new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: ListTile(
        // dense: true,
        title: Text(item?.displayName),
        subtitle: Text(item?.id),
        onTap: () => _viewItem(context),
        onLongPress: () => _editItem(context),
      ),
      actions: _getIconButtons(context, right: false),
      secondaryActions: _getIconButtons(context, right: true),
    );
  }
}
