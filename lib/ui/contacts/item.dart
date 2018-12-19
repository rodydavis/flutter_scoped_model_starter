import 'package:flutter/material.dart';

import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/list.dart';
import '../../utils/date_formatter.dart';
import '../../utils/share.dart';
import '../general/three_row_tile.dart';
import 'edit.dart';
import 'view.dart';

class ContactItem extends StatelessWidget {
  final ContactRow contact;
  final ContactModel model;

  ContactItem({@required this.contact, @required this.model});

  @override
  Widget build(BuildContext context) {
    return ThreeRowTile(
      icon: Icon(Icons.person),
      title: Text(contact?.displayName),
//      subtitle: Text(contact?.lastActivity),
      onTap: () => viewLead(context, model: model, row: contact),
      onLongPress: () => editContact(context, model: model, row: contact),
      cell: contact?.cellPhone,
      home: contact?.homePhone,
      office: contact?.officePhone,
      email: contact?.email,
      box1: Utility(
        value: formatDateCustom(contact?.dateCreated),
        hint: "Date Created",
      ),
      box2: Utility(
        value: formatDateCustom(contact?.dateModified),
        hint: "Date Modified",
      ),
      // onDelete: () => _removeItem(context),
      onEdit: () => editContact(context, model: model, row: contact),
      onShare: () => shareText(contact.toString()),
    );
  }
}
