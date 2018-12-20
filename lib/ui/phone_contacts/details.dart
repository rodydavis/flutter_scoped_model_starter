import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../data/classes/general/address.dart';
import '../../data/classes/general/phone.dart';
import '../../utils/null_or_empty.dart';
import '../general/address_tile.dart';
import '../general/email_tile.dart';
import '../general/phone_tile.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;
  final bool selected;
  ContactDetailsScreen({this.contact, this.selected = false});
  @override
  Widget build(BuildContext context) {
    var _details = <Widget>[
      ListTile(
        leading: Icon(Icons.person),
        title: Text(isNullOrEmpty(contact?.displayName)
            ? "No Name Found"
            : contact?.displayName),
        subtitle:
            isNullOrEmpty(contact?.company) ? null : Text(contact?.company),
      ),
    ];
    if (contact?.phones != null && contact.phones.isNotEmpty) {
      var _phones = getPhones(context, items: contact.phones.toList());
      _details.addAll(_phones);
    }
    if (contact?.emails != null && contact.emails.isNotEmpty) {
      var _emails = getEmails(context, items: contact.emails.toList());
      _details.addAll(_emails);
    }
    if (contact?.postalAddresses != null &&
        contact.postalAddresses.isNotEmpty) {
      var _addresses =
          getAddresses(context, items: contact.postalAddresses.toList());
      _details.addAll(_addresses);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: <Widget>[
          IconButton(
            icon: selected ? Icon(Icons.close) : Icon(Icons.check),
            onPressed: () => Navigator.pop(context, !selected),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _details,
        ),
      ),
    );
  }

  List<Widget> getPhones(BuildContext context, {@required List<Item> items}) {
    var _widgets = <Widget>[];
    for (var _item in items) {
      _widgets.add(PhoneTile(
        label: _item?.label,
        number: _item?.value != null && _item.value.isNotEmpty
            ? Phone.fromString(_item?.value)
            : null,
        icon: getIcon(_item?.label ?? ""),
      ));
    }
    return _widgets;
  }

  List<Widget> getEmails(BuildContext context, {@required List<Item> items}) {
    var _widgets = <Widget>[];
    for (var _item in items) {
      _widgets.add(
        EmailTile(
          label: _item?.label,
          email: _item?.value,
        ),
      );
    }
    return _widgets;
  }

  List<Widget> getAddresses(BuildContext context,
      {@required List<PostalAddress> items}) {
    var _widgets = <Widget>[];
    for (var _item in items) {
      _widgets.add(
        AddressTile(
          label: _item?.label,
          address: Address(
            street: _item?.street,
            state: _item?.region,
            city: _item?.city,
            zip: _item?.postcode,
          ),
        ),
      );
    }
    return _widgets;
  }

  IconData getIcon(String name) {
    if (name.contains("mobile")) return Icons.phone;
    if (name.contains("work")) return Icons.work;
    if (name.contains("fax")) return Icons.print;
    if (name.contains("home")) return Icons.home;
    return Icons.phone;
  }
}

Future<bool> viewContact(BuildContext context,
    {Contact contact, bool selected = false}) async {
  bool _select = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
            ContactDetailsScreen(contact: contact, selected: selected)),
  );
  return _select;
}
