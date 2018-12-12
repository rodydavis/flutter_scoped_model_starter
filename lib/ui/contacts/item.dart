import 'package:flutter/material.dart';

import '../../data/models/contact/list.dart';
import '../../data/models/contact/model.dart';
import '../../ui/general/three_row_tile.dart';
import '../../utils/date_formatter.dart';
import 'edit.dart';
import 'view.dart';
import '../../data/models/contact/info.dart';

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
          builder: (context) => ContactItemEdit(item: item, model: model),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        ContactDetails _item = value;
        model.editItem(context, item: _item, id: item?.id);
      }
    });
  }

  void _removeItem(BuildContext context) {
    model.deleteItem(context, id: item?.id);
  }

  void _viewItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactItemDetails(
              item: item, model: model, showNameInAppBar: false)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var _name = item?.lastName.toString() + ", " + item?.firstName;
    // var _tile = ListTile(
    //   // dense: true,
    //   title: Text(item?.displayName),
    //   subtitle: Text(item?.id),
    //   onTap: () => _viewItem(context),
    //   onLongPress: () => _editItem(context),
    // );

    return ThreeRowTile(
      icon: Icon(Icons.person),
      title: Text(item?.displayName),
      subtitle: Text(item?.lastActivity),
      onTap: () => _viewItem(context),
      onLongPress: () => _editItem(context),
      cell: item?.cellPhone,
      home: item?.homePhone,
      office: item?.officePhone,
      email: item?.email,
      box1: Utility(
        value: formatDate(item?.dateCreated),
        hint: "Date Created",
      ),
      box2: Utility(
        value: formatDate(item?.dateModified),
        hint: "Date Modified",
      ),
      onDelete: () => _removeItem(context),
      onEdit: () => _editItem(context),
      onShare: () => _shareItem(context),
    );
  }
}
