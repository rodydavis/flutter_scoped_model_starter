import 'package:flutter/material.dart';

import '../../data/classes/contacts/contact_details.dart';
import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contact_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/general/address_tile.dart';
import '../../ui/general/email_tile.dart';
import '../../ui/general/phone_tile.dart';
import '../../utils/null_or_empty.dart';
import 'edit.dart';

class ContactItemDetails extends StatefulWidget {
  final ContactRow item;
  final String name;
  final bool showNameInAppBar;
  final ContactModel model;
  ContactItemDetails({
    @required this.item,
    this.showNameInAppBar = true,
    @required this.model,
    this.name,
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
      if (details?.address != null) {
        _widgets.add(AddressTile(
          address: details?.address,
          label: "Current Address",
          icon: Icons.map,
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
              Navigator.pop(context);
            }
          });
        },
        child: Icon(Icons.edit, color: Colors.white),
        tooltip: 'Edit Item',
      ),
    );
  }
}
