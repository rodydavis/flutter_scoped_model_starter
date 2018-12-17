import 'package:flutter/material.dart';

import '../../../data/classes/app/paging.dart';
import '../../../data/classes/contacts/contact_row.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/contact_model.dart';
import '../item.dart';
import 'edit.dart';

class ContactGroupList extends StatefulWidget {
  final String groupName, id;
  final VoidCallback groupDeleted;
  final ContactModel model;
  final AuthModel auth;

  ContactGroupList({
    this.groupName,
    this.id,
    this.groupDeleted,
    @required this.model,
    @required this.auth,
  });

  @override
  ContactGroupListState createState() {
    return new ContactGroupListState();
  }
}

class ContactGroupListState extends State<ContactGroupList> {
  List<ContactRow> _contacts;
  Paging _paging = Paging(rows: 100, page: 1);

  void _editGroup(BuildContext context,
      {bool isNew = true, String id = "", String name = ""}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditContactGroup(
                isNew: isNew,
                groupName: name,
                id: id,
                groupDeleted: () {
                  Navigator.pop(context);
                  widget.groupDeleted();
                },
              ),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        Navigator.pop(context, value);
      }
    });
  }

  void _loadData() {
    setState(() {
      _contacts = null;
    });
    widget.model
        .getContactsForContactGroup(
      context,
      auth: widget.auth,
      paging: _paging,
      id: widget?.id ?? "",
    )
        .then((items) {
      final List<ContactRow> _items = items;
      setState(() {
        _contacts = _items ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.groupName ?? "Contact Group"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => _loadData(),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _editGroup(context,
              isNew: false, name: widget.groupName, id: widget.id),
        ),
      ],
    );

    if (_contacts == null || _contacts.isEmpty) {
      if (_contacts == null) {
        _loadData();

        return Scaffold(
          appBar: appBar,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: appBar,
        body: Center(
          child: Text("No Contacts Found"),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: _contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final _item = _contacts[index];
          return ContactItem(
            item: _item,
            model: widget.model,
          );
        },
      ),
    );
  }
}
