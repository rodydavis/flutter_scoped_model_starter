import 'package:flutter/material.dart';

import '../../data/classes/contacts/contact_details.dart';
import '../../data/classes/contacts/contact_row.dart';
import '../../data/classes/unify/contact_group.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/contact_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/general/address_tile.dart';
import '../../ui/general/email_tile.dart';
import '../../ui/general/phone_tile.dart';
import '../../utils/null_or_empty.dart';
import 'edit.dart';
import 'groups/manage.dart';
import 'groups/view.dart';
import '../general/simple_scaffold.dart';

class ContactItemDetails extends StatefulWidget {
  final ContactRow item;
  final AuthModel auth;
  final String name;
  final bool showNameInAppBar;
  final ContactModel model;
  ContactItemDetails({
    @required this.item,
    this.showNameInAppBar = true,
    @required this.model,
    this.name,
    @required this.auth,
  });
  @override
  _ContactItemDetailsState createState() => _ContactItemDetailsState();
}

class _ContactItemDetailsState extends State<ContactItemDetails> {
  ContactRow item;
  ContactDetails details;

  @override
  void initState() {
    _loadInfo();
    super.initState();
  }

  void _loadInfo() async {
    setState(() {
      item = widget.item;
    });
    // -- Load Info From API --
  }

  void _getDetails(BuildContext context, {ContactModel model}) async {
    var _contact = await model.getDetails(context, id: widget?.item?.id);
    setState(() {
      details = _contact;
    });
  }

  void _viewList(BuildContext context, {ContactGroup group}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactGroupList(
              auth: widget.auth,
              model: widget.model,
              groupName: group?.name,
              id: group?.id,
              groupDeleted: () {
                widget.model.deleteContactGroup(
                  context,
                  id: group?.id,
                  auth: widget.auth,
                );
              },
            ),
      ),
    ).then((value) {
      if (value != null) {
        final ContactGroup _group = value;
        widget.model.editContactGroup(
          context,
          auth: widget.auth,
          isNew: false,
          model: ContactGroup(name: _group?.name, id: _group?.id),
        );
      }
    });
  }

  void _manageContactGroups(BuildContext context, {ContactModel model}) async {
    if (model.groups == null || model.groups.isEmpty) {
      await model.loadContactGroups(context, auth: widget.auth);
    }

    var _source = model.groups;
    var _inital = details.contactGroups;

    if (_source != null) {
      for (var _item in _inital) {
        if (_source.contains(_item)) {
          _source.remove(_item);
        }
      }
      // Navigator.pushNamed(context, "manage_groups");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactGroupManageContact(
                source: _source,
                inital: _inital,
              ),
        ),
      ).then((value) {
        if (value != null) {
          final List<ContactGroup> _items = value;
          details.contactGroups = _items;
          // -- Update Contact --
          ContactDetails _item = details;
          print(_item.toJson());
          widget.model.editItem(context, item: _item, id: item?.id);
          setState(() {
            details = _item;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _model = widget.model;
    if (details == null) _getDetails(context, model: _model);

    var _widgets = <Widget>[
      ListTile(
        leading: Icon(Icons.person),
        title: Text(
          ((item?.firstName ?? "") + " " + (item?.lastName ?? "")),
        ),
        // subtitle: Text(item?.lastActivity ?? ""),
      ),
      PhoneTile(
          label: "Cell Phone", number: item?.cellPhone, icon: Icons.phone),
      PhoneTile(label: "Home Phone", number: item?.homePhone, icon: Icons.home),
      PhoneTile(
          label: "Office Phone", number: item?.officePhone, icon: Icons.work),
      EmailTile(label: "Email Address", email: item?.email),
    ];

    if (details != null) {
      // -- Add Details from API Call --
      if (details?.address != null) {
        _widgets.add(AddressTile(
          address: details?.address,
          label: "Current Address",
          icon: Icons.map,
        ));
      }

      if (details?.companyCategory != null) {
        _widgets.add(
          ListTile(
            leading: Icon(Icons.category),
            title: Text(details.companyCategory.name ?? "No Name Found"),
          ),
        );
      }

      if (details?.contactGroups != null && details.contactGroups.isNotEmpty) {
        var _groups = <Widget>[];
        for (var _group in details.contactGroups) {
          //   print("Name: ${_group?.name} => ID: ${_group?.id}");
          _groups.add(
            ListTile(
              title: Text(_group?.name ?? "No Name Found"),
              onTap: () => _viewList(context, group: _group),
            ),
          );
        }
        _widgets.add(ExpansionTile(
          leading: Icon(Icons.people),
          title: Text("Contact Groups"),
          children: _groups,
        ));
      }
    } else {
      _widgets.add(CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: widget.showNameInAppBar
            ? Text(widget?.name ?? item?.firstName ?? "Details")
            : Text("Details"),
        actions: <Widget>[
          IconButton(
            tooltip: "Contact Groups",
            icon: Icon(Icons.people),
            onPressed: () => _manageContactGroups(context, model: _model),
          ),
          IconButton(
            tooltip: "Share Contact",
            icon: Icon(Icons.share),
            onPressed: null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: _widgets),
      ),
      bottomNavigationBar: AppBottomBar(
        showSort: false,
        buttons: [
          IconButton(
            tooltip: "Delete Contact",
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.model.deleteItem(context, id: item?.id);
              Navigator.pop(context);
            },
          ),
          IconButton(
            tooltip: "Add Follow Up",
            icon: Icon(Icons.event_available),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Add Note",
            icon: Icon(Icons.note_add),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Add Log Response",
            icon: Icon(Icons.timer),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Create Lead",
            icon: Icon(Icons.person_add),
            onPressed: null,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "Contact Edit",
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactItemEdit(
                    item: item, model: _model, details: details),
                fullscreenDialog: true),
          ).then((value) {
            if (value != null) {
              ContactDetails _item = value;
              widget.model.editItem(context, item: _item, id: item?.id);
              setState(() {
                details = _item;
              });
              // Navigator.pop(context);
            }
          });
        },
        child: Icon(Icons.edit, color: Colors.white),
        tooltip: 'Edit Item',
      ),
    );
  }
}
