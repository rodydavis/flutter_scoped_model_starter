import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/models/crud.dart';
import 'edit/crud_edit.dart';
import 'view/crud_view.dart';
import '../../utils/null_or_empty.dart';

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
    return new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: ListTile(
        title: Text(item?.name),
        subtitle: isNullOrEmpty(item?.description)
            ? null
            : Text(item?.description, maxLines: 1),
        onTap: () => _viewItem(context),
        onLongPress: () => _editItem(context),
      ),
      actions: _getIconButtons(context, right: false),
      secondaryActions: _getIconButtons(context, right: true),
    );
  }
}
