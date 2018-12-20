import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/groups.dart';
import '../../data/models/contacts/list.dart';
import '../../utils/date_formatter.dart';
import '../../utils/null_or_empty.dart';
import '../../utils/popUp.dart';
import '../../utils/vcf_card.dart';
import '../app/buttons/app_share_button.dart';
import '../general/three_row_tile.dart';
import 'edit.dart';
import 'view.dart';

class ContactItem extends StatelessWidget {
  final ContactRow contact;
  final ContactModel model;
  final ContactGroupModel groupModel;

  ContactItem(
      {@required this.contact,
      @required this.model,
      @required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return ThreeRowTile(
      icon: Icon(Icons.person),
      title: Text(contact?.displayName),
//      subtitle: Text(contact?.lastActivity),
      onTap: () => viewContact(context,
          model: model, row: contact, groupModel: groupModel),
      onLongPress: () => editContact(context,
          model: model, row: contact, groupModel: groupModel),
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
      onDelete: () => showConfirmationPopup(context,
          detail: "Are you sure you want to delete?"),
      onEdit: () => editContact(context,
          model: model, row: contact, groupModel: groupModel),
      onShare: () => shareContact(context, contact: contact),
    );
  }
}

void shareContact(BuildContext context, {ContactRow contact}) async {
  var _phones = <Item>[];

  if (!isNullOrEmpty(contact?.cellPhone?.raw())) {
    _phones.add(Item(label: "cell", value: contact?.cellPhone?.toString()));
  }

  if (!isNullOrEmpty(contact?.homePhone?.raw())) {
    _phones.add(Item(label: "home", value: contact?.homePhone?.toString()));
  }

  if (!isNullOrEmpty(contact?.officePhone?.raw())) {
    _phones.add(Item(label: "work", value: contact?.officePhone?.toString()));
  }

  var _emails = <Item>[];

  if (!isNullOrEmpty(contact?.email)) {
    _emails.add(Item(label: "home", value: contact?.email));
  }

  final Contact _info = Contact(
    givenName: contact?.firstName,
    familyName: contact?.lastName,
    company: "Unify Contact",
    phones: _phones,
    emails: _emails,
  );
  var _file = await generateVCARD(context, contact: _info);
  if (_file != null) {
    shareFile(context, file: _file);
  }
}
