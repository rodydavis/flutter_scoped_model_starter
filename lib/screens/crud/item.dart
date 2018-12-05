import 'package:flutter/material.dart';

import '../../data/models/crud.dart';
import 'item/edit.dart';
import 'item/view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CRUDItem extends StatelessWidget {
  final CRUDObject item;
  final CRUDModel model;
  final bool share, edit, delete;
  CRUDItem({
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
          builder: (context) => CRUDItemEdit(item: item),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        CRUDObject _item = value;
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
          builder: (context) => CRUDItemDetails(item: item, model: model)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: ListTile(
        title: Text(item?.name),
        onTap: () => _viewItem(context),
        onLongPress: () => _editItem(context),
      ),
      actions: <Widget>[
        share
            ? new IconSlideAction(
                caption: 'Share',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () => _shareItem(context),
              )
            : Container(),
      ],
      secondaryActions: <Widget>[
        edit
            ? new IconSlideAction(
                caption: 'Edit',
                color: Colors.black45,
                icon: Icons.edit,
                onTap: () => _editItem(context),
              )
            : Container(),
        delete
            ? new IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => _removeItem(context),
              )
            : Container(),
      ],
    );
  }
}
